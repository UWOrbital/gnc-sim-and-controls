function [eccent_anom] = calc_eccent_anom_from_mean_anom(mean_anom, ecc, conv_crit)
%CALC_ECCENT_ANOM_FROM_MEAN_ANOM Iteratively calculates and converges upon
%the eccentric anomaly from the mean anomaly and orbital eccentricity
%
%   INPUTS
%       mean_anom   - mean anomaly (radians)
%       ecc         - orbital eccentricity
%       conv_crit   - relative tolerance needed to stop convergence
%   OUTPUTS
%       eccent_anom - eccentric anomaly (radians)

% Calculates a starting estimate of the eccentric anomaly
if mean_anom < pi
    eccent_anom = mean_anom + ecc / 2;
else
    % mean_anom >= pi
    eccent_anom = mean_anom - ecc / 2;
end

% Performs Newton-Raphson iteration to converge on the actual value
while true
    ratio = (eccent_anom - ecc * sin(eccent_anom) - mean_anom) ...
        / (1 - ecc*cos(eccent_anom));
    eccent_anom = eccent_anom - ratio;

    if abs(ratio) < conv_crit
        break;
    end
end

end

