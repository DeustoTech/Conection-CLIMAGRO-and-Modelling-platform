clear 

fp = folderpath;

fp_data = fullfile(fp,'src','model','data');

r = what(fp_data);
%%
full_data = [];
for imat = r.mat'
   load(imat{:})
   full_data = [full_data data];
end

%%
DateTime = [];
Ti = [];
HD = [];
for j = 1:length(full_data)
    DateTime = [DateTime ;full_data{j}.DateTime];
    Ti = [Ti; full_data{j}.GH.IC.Temp.Tair];
    HD = [HD; full_data{j}.HeatDemand];
end
%%
clf
subplot(2,1,1)
plot(DateTime,Ti-273.15,'.-')
subplot(2,1,2)
plot(DateTime,HD/1e3,'.-')
ylabel('kW')