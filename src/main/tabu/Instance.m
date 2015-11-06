classdef Instance
    %INSTANCE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Weights
        
    end
    
    methods
        function S = Instance(we)
           Weigts = we;
        end
        
        function R = rsomething(obj)
            R = obj.Weights;
        end
        
        function endPhase = StoppingCriteria(obj)
            endPhase = obj.Weights;
        end
    end
    
end

