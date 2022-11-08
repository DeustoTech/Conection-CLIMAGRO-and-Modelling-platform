function parameters = FinalStates2InitialStates(parameters,result)


parameters.climate.T0 =   result.FinalStates.IC.T0;
parameters.climate.C0 = result.FinalStates.IC.C0;
parameters.crop.C     = result.FinalStates.Crop.C;
parameters.crop.C_wv  = result.FinalStates.Crop.C_wv;
parameters.crop.N     = result.FinalStates.Crop.N;
parameters.crop.R     = result.FinalStates.Crop.R;
parameters.crop.Tsum  = result.FinalStates.Crop.Tsum;
parameters.crop.Tv    = result.FinalStates.Crop.Tv;

end

