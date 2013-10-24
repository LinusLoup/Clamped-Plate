classdef LinearRefBasisFunction
    %LINEARREFBASISFUNCTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        left
        right
        deriv_left
        deriv_right
    end
    
    methods
        function obj = LinearRefBasisFunction
            obj.left = 0;
            obj.right = 1;
            obj.deriv_left = -1;
            obj.deriv_right = 1;
        end
        
        function y = GetValue(obj,pos)
            for i = 1 : length(pos)
                if (pos(i) > 1) || (pos(i) < 0)
                    y(i,:) = zeros(1,2);
                else
                    y(i,:) = [1-pos(i),pos(i)];
                end
            end
        end
        
        function y = GetDerivation(obj,pos)
            for i = 1 : length(pos)
                if (pos(i) > 1) || (pos(i) < 0)
                    y(i,:) = zeros(1,2);
                else
                    y(i,:) = [obj.deriv_left,obj.deriv_right];
                end
            end
        end
    
    end
end

