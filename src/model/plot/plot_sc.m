clear 

fp = folderpath;

fp_data = fullfile(fp,'src','model','data');

r = what(fp_data);
%%
full_data = [];
for imat = r.mat'
   load(imat{:})
   pause(0.1)
   full_data = [full_data data];
end

%%
t = epo2date(vertcat(full_data.t));
Temp = vertcat(full_data.Temp) - 273.15;
EC   = vertcat(full_data.EC)
Tw   = vertcat(full_data.Tw) - 273.15;
TwSOFC   = vertcat(full_data.TwSOFC) - 273.15
IC   = vertcat(full_data.IC);
QS = vertcat(full_data.Q_SOFC);
clf
%
subplot(4,1,1)
hold on
plot(t,Temp,'.-')
plot(t,EC(:,1)-273.15,'.-')
legend('Tc','Ti','Tf','Ts','Te')

subplot(4,1,2)
hold on
plot(t,Tw,'--')
plot(t,TwSOFC,'.')
legend('Tw_{GH}','Tw_{SOFC}')
subplot(4,1,3)
%plot(t,EC(:,2),'.-')
plot(t,QS,'.-')
title('QSOFC')

subplot(4,1,4)
plot(t,EC(:,2),'.-')
title('Rad')

