clear
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
times_ve = 60*30;

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
        G0 = rt_yout.signals(5).values(end,:);
        Tw_SOFC = rt_yout.signals(6).values(end,:);    
        %clear rt_yout rt_tout
    else
        G0 = [ 0.0050   0.0007];
        T0 = [287.1500  287.1500  287.1500  287.1500];
        Tw = 287.15;
        Tw_SOFC = 287.15;
    end
    %%
    if exist(fp_in,'file')
        try 
            load(fp_in)
        catch
            fprintf('Error en la lectura de im.out\n\n')
            pause(1)
        end
    else
        QSOFC = 0;
        flow = 0;
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

