function [v1, v2] = lamberts_orbit_deter(r1, r2, dt, prograde, grav_param, conv_crit)
%LAMBERTS_ORBIT_DETER Calculates orbital velocity at each provided position

r1_mag = norm(r1);
r2_mag = norm(r2);

% calculates the change in the true anomaly
resolve_quad_ambig = dot([0, 0, 1], cross(r1, r2));
ang_comp = acos(dot(r1, r2) / (r1_mag * r2_mag));

if prograde == true
    % performs calculations for a prograde orbit
    if resolve_quad_ambig >= 0
        d_true_anom = ang_comp;
    else
        d_true_anom = 2*pi - ang_comp;
    end
else
    % performs calculations for a retrograde orbit
    if resolve_quad_ambig < 0
        d_true_anom = ang_comp;
    else
        d_true_anom = 2*pi - ang_comp;
    end
end

% disp(["d_true_anom: ", rad2deg(d_true_anom)]);

% defines internal functions needed for Newton-Raphson iteration

A = sin(d_true_anom)*sqrt((r1_mag * r2_mag) / (1-cos(d_true_anom)));
disp(["A: ", A]);
    
    % internal utility function
    function y = y(z)
        y = r1_mag + r2_mag + A * (z * stumpff_s(z) - 1) / sqrt(stumpff_c(z));
    end

    % root-finding equation
    function F = F(z)
        F = (y(z) / stumpff_c(z))^(3/2) * stumpff_s(z) + A*sqrt(y(z)) - sqrt(grav_param)*dt;
    end

    % derivative of root-finding equation
    function d_F = d_F(z)
        if z ~= 0
            d_F = (y(z) / stumpff_c(z))^(3/2) * (1/(2*z)*(stumpff_c(z) - 3/2*stumpff_s(z)/stumpff_c(z)) + 3/4*stumpff_s(z)^2/stumpff_c(z)) ...
                + A/8*(3*stumpff_s(z)/stumpff_c(z)*sqrt(y(z)) + A*sqrt(stumpff_c(z)/y(z)));
        else
            % z == 0
            d_F = sqrt(2)/40*y(0)^(3/2) + A/8*(sqrt(y(0)) + A*sqrt(1/(2*y(0))));
        end
    end

% perform Newton-Raphson iteration to find z

z = 0; % initial value for iteration, could potentially use bracketing

ratio = conv_crit * 2; % must be larger than convergence criterion

while abs(ratio) > conv_crit 
    ratio = F(z) / d_F(z);
    z = z - ratio;

    % disp(["z iter: ", z]);
    % disp(["ratio: ", ratio]);
end
% disp(["z: ", z]);

% uses Lagrange coefficients to calculate velocities
f = 1 - y(z)/r1_mag;
g = A*sqrt(y(z)/grav_param);
d_f = sqrt(grav_param)/(r1_mag*r2_mag) * sqrt(y(z)/stumpff_c(z))*(z*stumpff_s(z) - 1);
d_g = 1-y(z)/r2_mag;

% disp(["f: ", f]);
% disp(["g: ", g]);
% disp(["d_f: ", d_f]);
% disp(["d_g: ", d_g]);

% calculates velocities
v1 = 1/g*(r2 - f*r1);
v2 = 1/g*(d_g*r2 - r1);

end