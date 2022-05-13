clear 
%%
tspan = linspace(0,10);
u_data = sin(2*pi*tspan/10);
%%
u.signals.values = u_data';
u.signals.dimensions = 1;
u.time = tspan';
%%
in = Simulink.SimulationInput('example_model');
in = in.setExternalInput(u);
r = sim(in);
%%
clf
hold on
plot(tspan,u_data)

plot(r.tout,r.yout{1}.Values.Data)
