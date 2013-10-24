classdef LinearSplineBasisFunction
    % Basisfunktion für stückweise lineare Funktionen
    %   Detailed explanation goes here
    
    properties
        left
        center
        right
        deriv_left
        deriv_right
    end
    
    methods
        function obj = LinearSplineBasisFunction(left, center, right)
            obj.left = left;
            obj.center = center;
            obj.right = right;
            obj.deriv_left = 1/(center-left);
            obj.deriv_right = -1/(right-center);
        end
        
        function y = GetValue(obj,pos)
            for i = 1 : length(pos)
              if (pos(i) <= obj.left) || (pos(i) >= obj.right)
                 y(i) = 0;
                else if pos(i) <= obj.center
                        y(i) = (pos(i) - obj.left)/(obj.center - obj.left);
                    else
                        y(i) = (obj.right - pos(i))/(obj.right - obj.center);
                    end
              end
            end
        end
        
        function y = GetDerivation(obj,pos)
            for i = 1 : length(pos)
                if (pos(i) >= obj.left) && (pos(i) <= obj.center)
                    y(i) = obj.deriv_left;
                else if (pos(i) > obj.center) && (pos(i) <= obj.right)
                        y(i) = obj.deriv_right;
                    else
                        y(i) = 0;
                    end
                end
            end
        end
        
    end
    
end
