clear 
%% Abrimos el modelo de Simulonk
open_system('crop_simulation')
% Opcion de simulion para acelerar la simulacion 
set_param('crop_simulation', 'MinimalZcImpactIntegration', 'on')
set_param('crop_simulation','SimulationMode','normal')
%%
fp = folderpath;
cd(fp)
fp_model = fullfile(fp,'src','model');
fp_in    = fullfile(fp_model,'io','in.mat');
fp_out   = fullfile(fp_model,'io','out.mat');
%%
%
[Hours,tt,Si,vv,HR,ChangeDay] = LoadExternalClimate;
%%
parameters = LoadParameters_TCP_IP();
%% 
% Condiciones iniciales por defecto
% 
InitStates = DefaultInitialConditions();
%
%% 
% Default of input variables 
insignal.Qreal = 1; % [W]
insignal.Tw      = 273.15 + 80; % [K]
%%
%
dt_w = 3; % Sample time of loop;
%
t0 = datetime('01-Feb-2019'); % 
faster = 60*60*6; % Cada segundo se multiplica por este factor;
tic;
%
D01_Jan = datetime('01-Jan-2019');
while true 
    
    % Controlamos el tiempo 
    dt = toc;
    tnew = t0 + faster*seconds(dt);

    StartTime = days(tnew - D01_Jan);
    StopTime     = StartTime +  dt_w*faster/(3600*24);

    fprintf ("Simulation will be run " +  ...
            "from : "  + num2str(StartTime,'%.4f')+ ...
             " | to : " + num2str(StopTime,'%.4f')+"\n") + ...
             "from : "  + string(days(StartTime) + D01_Jan)+ ...
             " | to : " + string(days(StopTime)  + D01_Jan)+"\n" ) 
         
    tic_simu = tic; % tiempo que tarda la simulacion
    %
    % Leemos condiciones iniciales de la ultima simulacion 
    % en caso de no existir el fichero "out.mat" cargaremos las 
    % condiciones iniciales por defecto
    % ----------------------------------------------
    if exist(fp_out,'file')
        load(fp_out)    
        InitStates = result.FinalStates;
    end
    % ----------------------------------------------
    % Leemos los datos señales externas 
    if exist(fp_in,'file')
        load(fp_in) % se carga la variable r
    end
    % ----------------------------------------------
    %
    % Cargamos parametros modificables durante la simulacion
    %load('create_p')
    %
    % Lanzamos la simulacion 
    rl = sim('crop_simulation', ...
        'StartTime',num2str(StartTime,'%.4f'), ...
        'StopTime',num2str(StopTime,'%.4f'));
    %% 
    % En esta variable se encuentra todo los resultados de las simulacion
    result = parse_data_tcp_ip(rl);

    %% 
    save('src/model/io/out.mat','result')

    toc_simu = toc(tic_simu); % tiempo que tarda la simulacion
    % 
    % Pausamos solo necesario 
    %
    pause(max(dt_w -toc_simu,0))

end

