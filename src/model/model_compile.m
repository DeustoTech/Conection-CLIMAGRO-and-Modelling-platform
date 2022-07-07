clear
Tw = 10 + 273.15;
Tw_SOFC = 10 + 273.15;
%%
climate_GH3 = climate_p;
clima = [273.15+10 400 50 0.1];

hour0 = climate_GH3.hour0;
G0 = climate_GH3.G0;
T0 = climate_GH3.T0;
flow= 0;

%%
fp = folderpath;
cd(fp)
current_path = pwd;
cd(fullfile(fp,'src','model'))
pause(1)
slbuild('model01')

%
x0 = rsimgetrtp('model01');
save('params.mat','x0')
%
cd(fp)
%
%%
