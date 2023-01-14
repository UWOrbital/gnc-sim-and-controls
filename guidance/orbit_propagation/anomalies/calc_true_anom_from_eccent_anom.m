function [true_anom] = calc_true_anom_from_eccent_anom(eccent_anom, ecc)
%CALC_TRUE_ANOM_FROM_ECCENT_ANOM Calculates the true anomaly from the
%eccentric anomaly using the eccentricity.
%
%   INPUTS
%       eccent_anom - eccentric anomaly (radians)
%       ecc         - orbital eccentricity
%   OUTPUTS
%       true_anom   - true anomaly (radians)

true_anom = 2*atan(sqrt((1+ecc)/(1-ecc))*tan(eccent_anom / 2));

end

