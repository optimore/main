function model = EvaluateNextStep(model,data)
%EVALUATENEXTSTEP uses predefined parameters to change phases etc.
%   This function handles different phases and methods associated with the
%   heuristic and when to change between the two,


conditionsToChange = ...
    model.activePhase.changeFactor > ... 
    model.changePhase.changeCondition;

if conditionsToChange
    model.activePhase = model.nextPhase;
else
    model.activePhase.changeFactor = ...
        model.activePhase.incrementFactor;
end

end

