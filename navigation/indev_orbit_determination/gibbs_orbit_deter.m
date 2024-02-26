function [v1, v2, v3] = gibbs_orbit_deter(r1, r2, r3, grav_param)
%GIBBS_ORBIT_DETER Calculates orbital velocity at each provided position
%   Detailed explanation goes here

r1_mag = norm(r1);
r2_mag = norm(r2);
r3_mag = norm(r3);

C_12 = cross(r1, r2);
C_23 = cross(r2, r3);
C_31 = cross(r3, r1);

N = r1_mag * C_23 + r2_mag * C_31 + r3_mag * C_12;
D = C_12 + C_23 + C_31;
S = r1 * (r2_mag - r3_mag) + r2 * (r3_mag - r1_mag) + r3 * (r1_mag - r2_mag);

v1 = sqrt(grav_param / (norm(N) * norm(D))) * (cross(D, r1) / r1_mag + S);
v2 = sqrt(grav_param / (norm(N) * norm(D))) * (cross(D, r2) / r2_mag + S);
v3 = sqrt(grav_param / (norm(N) * norm(D))) * (cross(D, r3) / r3_mag + S);

end

