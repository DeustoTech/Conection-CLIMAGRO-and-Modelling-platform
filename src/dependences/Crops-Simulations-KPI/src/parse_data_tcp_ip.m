function result = parse_data_tcp_ip(rl,InitDate)
TOMATO = rl.logsout.getElement('Tomato').Values;

for ic = {'TOMATO'}
    eval("Data = "+ic{:}+".Data;")
    eval("Time = "+ic{:}+".Time;")

    result.(ic{:}).Data = Data;
    result.(ic{:}).Time = Time;

end
%%
result.GH.time = rl.tout;

sg_CROP = rl.logsout.getElement('Crop');
result.GH.CROP = parseCrop(sg_CROP,rl.tout);
%
sg_IC = rl.logsout.getElement('Indoor Climate');
result.GH.IC = parseIndoorClimate(sg_IC,rl.tout);
%
sg_EC = rl.logsout.getElement('EC');
result.GH.EC = parseIndoorClimate(sg_EC,rl.tout);
%
dTom_dt = gradient(TOMATO.Data,TOMATO.Time);
dTom_dt(dTom_dt<0) = 0;
result.GH.TOMATO_EVOLUTION = cumtrapz(TOMATO.Time,dTom_dt);
result.GH.TOTAL_TOMATO = result.GH.TOMATO_EVOLUTION(end);

%%

result.FinalStates.clima = IC_FinalStates(result.GH.IC);
result.FinalStates.crop = Crop_FinalStates(result.GH.CROP);
result.FinalStates.tomato.Cfruit0 = result.TOMATO.Data(end);

result.HeatDemand = rl.logsout.getElement('HeatDemand').Values.Data;
result.AR = rl.logsout.getElement('AR').Values.Data;

result.DateTime = InitDate + days(rl.tout - rl.tout(1));
end
