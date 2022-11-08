%%
function parameters = LoadParameters_TCP_IP()

warning off

parameters.Tref=16.5;

%% Cargamos los parametros por defecto del modelo de crop
parameters.crop = struct(crop_p);

parameters.crop.A_v = 40;       % Area de cultivo [m^2]
parameters.crop.n_seasons = 2;  % Numero de sesisiones [-]

%% Cargamos los parametros por defecto del modelo de crop de clima
parameters.climate = struct(climate_p);
%
parameters.climate.A_c          = 60;        % Area de cubierta del invernadero
parameters.climate.A_f          = 60;        % Area de suelo
parameters.climate.alpha_i      = 0.1;       % Coeficiente de absorcion de radiacion del aire en el invernadero [-]
parameters.climate.alpha_f      = 0.001;     % Coeficiente de absorcion de radiacion del suelo en el invernadero [-]
parameters.climate.tau_c        = 0.7;       % Coeficiente de transmisividad de radiacion de la cubierta del invernadero [-]
parameters.climate.H            = 4;         % Altura del invernadero
parameters.climate.minWindows   = 0.01;      % Coeficiente de hermeticidad del invernadero [-],   aunque las ventanas esten cerradas el invernadero tiene conveccion con el exterior por los defectos que puede tener su cubierta (agujeros, puertas, etc)
%%
%
% Cargamos potencia electrica de la luz artificial
parameters.PowerArtificial = 1000;

warning on
end