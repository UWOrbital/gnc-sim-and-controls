function [mean_anom] = calc_mean_anom_from_eccent_anom(eccent_anom, ecc)
%CALC_MEAN_ANOM_FROM_ECCENT_ANOM Calculates the mean anomaly from the
%eccentric anomaly using the orbital eccentricity.
%
%   INPUTS
%       eccent_anom - eccentric anomaly (radians)
%       ecc         - orbital eccentricity
%   OUTPUTS
%       mean_anom   - mean anomaly (radians)

mean_anom = eccent_anom - ecc*sin(eccent_anom);

end

