function r = DefaultInitialConditions()

crop_params = crop_p;
%
r = [];
r.crop.C = crop_params.C;
r.crop.R = crop_params.R;
r.crop.N = crop_params.N;
r.crop.Tsum = crop_params.Tsum;
r.crop.C_wv = crop_params.C_wv;
r.crop.Tv = crop_params.Tv;
%
climate_params = climate_p;
r.clima.T0 = climate_params.T0;
r.clima.G0 = climate_params.G0;
%r.clima.hour0 = climate_params.hour0;

r.tomato.Cfruit0 = 1e-3; % [kg/m^2]

end

