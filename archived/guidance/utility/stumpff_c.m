function [ret] = stumpff_c(z)
%STUMPFF_C Stumpff C(z) function
%
%   INPUTS
%       z   - dimensionless value (alpha*univ_anom^2)
%   OUTPUTS
%       ret - output value of the function

if z > 0
    ret = (1 - cos(sqrt(z))) / z;
elseif z < 0
    ret = (cosh(sqrt(-z)) - 1) / (-z);
else
    % z == 0
    ret = 1/2;
end

