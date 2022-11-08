clear 


mtotal = 1000;       % [kg{H2O}]     masa total de agua 
mtotal = 1e1;
cp_H2O = 4182;      % [J/(Kg . K)]  calor especificio de agua 
area = 1e-2;         % [m^2]         area en contacto 
lamb_s = 2;         % [W/(mK)]      conductividad termica 
l_w = 0.01;         % [m]           grosor
maxPower = 70*1e3; % 70kw

DiffT = 1;
PID_p = maxPower/DiffT;

set_point_Ti = 16.5;
file_path_cparams = '/Users/djoroya/Dropbox/My Mac (Deyviss’s MacBook Pro)/Documents/GitHub/projects/HortiMED/code/Connection-CLIMAGRO-and-Modelling-platform/src/model/create_p.mat';


save(file_path_cparams)