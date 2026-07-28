function [eccent_anom] = calc_eccent_anom_from_true_anom(true_anom, ecc)
%CALC_ECCENT_ANOM_FROM_TRUE_ANOM Calculates the eccentric anomaly from the
%true anomaly using the orbital eccentricity.
%
%   INPUTS
%       true_anom   - true anomaly (radians)
%       ecc         - orbital eccentricity
%   OUTPUTS
%       eccent_anom - eccentric anomaly (radians)

eccent_anom = 2*atan(sqrt((1-ecc)/(1+ecc))*tan(true_anom / 2));

end

