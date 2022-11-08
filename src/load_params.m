Tw = 10 + 273.15;
Tw_SOFC = 10 + 273.15;
%%
climate_GH3 = climate_p;
clima = [273.15+10 400 50 0.1];

hour0 = climate_GH3.hour0;
G0 = climate_GH3.G0;
T0 = climate_GH3.T0;
climate_GH3.tau_c = 0.9;
climate_GH3.minWindows = 0.5;
climate_GH3.H = 3;
climate_GH3.A_f = 200;
climate_GH3.A_c = 200;
climate_GH3.alpha_i = 0.05;
flow= 0;

%%
crop_params = crop_p;
crop_params.A_v = 180;
%
