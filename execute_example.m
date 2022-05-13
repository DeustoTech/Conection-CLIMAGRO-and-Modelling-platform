clear
%%

tspan = linspace(0,10);
u_data = sin(2*pi*tspan/10);
%
u.signals.values = u_data';
u.signals.dimensions = 1;
u.time = tspan';
%%
save('input.mat','u')
%%

system("./example/compile_files/example_model -i input.mat")

%%
load('example_model.mat')
plot(rt_yout.time,rt_yout.signals.values)