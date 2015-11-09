function [new_modelParameters] = model_fixtures(active_vec)

modelParameters = struct( ...
    'tabu', struct('active',0,'initial',1,'phases',[1]), ...
    'LNS' , struct('active',0,'initial',1,'phases',[1]), ...
    'ampl', struct('active',0,'initial',1,'phases',[1]));

modelParameters.tabu = setfield(modelParameters.tabu,'active',active_vec(1));

modelParameters.LNS = setfield(modelParameters.LNS,'active',active_vec(2));

modelParameters.ampl = setfield(modelParameters.ampl,'active',active_vec(3));

new_modelParameters = modelParameters;

end