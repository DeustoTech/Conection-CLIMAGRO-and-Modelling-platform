function [x,Te,Ls] = model_fcn(t,dt,x,u,ext_clima_fcn,LightSystem_fcn)

x1 = x(1);
x2 = x(2);
x3 = x(3);

Te = ext_clima_fcn(t);
Ls = LightSystem_fcn(t);


tf = t + dt;
tspan = [t,tf];
Te_t = Te + 0*tspan;
ut = u + 0*tspan;

Ti = x1;
Tw = x2;

in = Simulink.SimulationInput('model01');
in = in.setExternalInput([tspan ;Te_t; ut]');
in = setVariable(in,'Ti',Ti,'Workspace','model01');
in = setVariable(in,'Tw',Tw,'Workspace','model01');
in = setVariable(in,'tf',tf,'Workspace','model01');
in = setVariable(in,'t',t,'Workspace','model01');


r = sim(in);

Ti_out = r.yout{1}.Values.Data(end);
Tw_out = r.yout{2}.Values.Data(end); 
Te_out = r.yout{3}.Values.Data(end); 


x = [Ti_out Tw_out Te_out];
end

