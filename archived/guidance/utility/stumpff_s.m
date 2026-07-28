function [ret] = stumpff_s(z)
%STUMPFF_S Stumpff S(z) function
%
%   INPUTS
%       z   - dimensionless value (alpha*univ_anom^2)
%   OUTPUTS
%       ret - output value of the function

if z > 0
    ret = (sqrt(z) - sin(sqrt(z))) / sqrt(z)^3;
elseif z < 0
    ret = (sinh(sqrt(-z)) - sqrt(-z)) / sqrt(z)^3;
else
    % z == 0
    ret = 1/6;
end

