clear

  
mtotal = 100;       % [kg{H2O}]     masa total de agua 
cp_H2O = 4182;      % [J/(Kg . K)]  calor especificio de agua 
area = 150;         % [m^2]         area en contacto 
lamb_s = 2;         % [W/(mK)]      conductividad termica 
l_w = 0.01;         % [m]           grosor
load('data/exclima.mat')
ds.DateTime = ds.DateTime + days(2*365);

ds(diff(posixtime(ds.DateTime)) == 0,:) = [];
ds.unix_time = posixtime(ds.DateTime);
%%
fp = folderpath;
cd(fp)
fp_model = fullfile(fp,'src','model');

%
dt = dt_wait();

%%

fp_in = fullfile(fp_model,'io','in.mat');
fp_out = fullfile(fp_model,'io','out.mat');

%%
load(fullfile(fp_model,'params.mat'));


time0 = now_unix;
told = time0;
pause(1)
times_ve = 60*15;
times_ve = 4*60*30;

clima_fcn = griddedInterpolant(posixtime(ds.DateTime),[ds.temp ds.RadCloud ds.humidity ds.wind_speed]);


load_simulink_model = true;

if load_simulink_model
    load_system('model01_nc')
    set_param('model01_nc','StopTime','tf')
    load_params
end

first = true;
isplot = true;

count = 0;
while true 

    if exist(fp_out,'file')
        load(fp_out)
        T0 = rt_yout.signals(1).values(end,:);
        Tw = rt_yout.signals(2).values(end,:);    
        G0 = rt_yout.signals(3).values(end,:);
        %
        cx0 = rt_yout.signals(7).values(end,:);
        Tv    = cx0(1);
        Tsum  = cx0(2);
        C_wv  = cx0(3);
        C = rt_yout.signals(8).values(end,:);
        R = rt_yout.signals(9).values(end,:);
        N = rt_yout.signals(10).values(:,:,end);
        %
    else
        G0 = [ 0.0050   0.0007];
        T0 = [287.1500  287.1500  287.1500  287.1500];
        Tw = 287.15;
        %
        Tv    = 10 + 273;
        Tsum  = 0;
        C_wv  = 0;
        C = crop_params.C;
        R = crop_params.R;
        N = crop_params.N;
    end
    %%
    if exist(fp_in,'file')
        try 
            load(fp_in)
            for ifield = fieldnames(r)'
                eval(ifield{:} + "= r."+ifield{:}+";")
            end
        catch
            fprintf('Error en la lectura de in.out\n\n')
            pause(1)
        end
    else
        T_ida_real = 273.15;
        T_retorno_real = 273.15;
        AR_state_real = 0;
        flow_real = 0;
    end
    dat_time = datetime('now');
    new_date = epo2date(times_ve*(posixtime(dat_time) - time0) + time0);
    dat_time = new_date;
    
    dt_sim = posixtime(dat_time) - told;
    told = posixtime(dat_time);
    % tomamos la hora del día
    hour0 = dat_time.Hour + dat_time.Minute/60;
    
    clima = clima_fcn(posixtime(dat_time));
    
    %%
    
    try
        tic;
        
        if ~load_simulink_model
            set_parameters_model;
            save(fullfile(fp_model,'io','params_loop.mat'),'x0')
            cmd = "./src/model/model01 -o src/model/io/out.mat -p src/model/io/params_loop.mat -tf "+num2str(dt_sim/3600/24);
            system(cmd)    
        else
            r = sim('model01_nc','StopTime',num2str(dt_sim/3600/24));
            
            rt_yout = r.yout;
            rt_tout = r.tout;
            save('src/model/io/out.mat','rt_yout','rt_tout','dat_time')
        end
        
        t = toc;
        if t < dt
            fprintf("stop : "+num2str(dt-t)+"\n")
            pause(dt - t)
        end
        
        fprintf(now_str+" ... Se ha actualizado src/model/io/out.mat con fecha:  "+string(dat_time)+"\n\n")
        count = 0;
    catch
        fprintf(now_str+" ... ha habido un error\n\n")
        count = count + 1;
        if count > 5
            continue
        else
           error 
        end
    end
end

