function [json_utf8, json_len] = emit_to_unity(eci_to_body_tar, ...
    eci_to_body, eci_to_body_est, ang_vel, sun_dir, ...
    earth_dir, mag, tar_dir, ang_vel_est, sun_dir_est, earth_dir_est, ...
    mag_est, body_axes, eci_axes, ecef_axes, lvlh_axes, anlg_sun_sens)
%EMIT_TO_UNITY Sends input values packaged in JSON to Unity sent over UDP

% Initializes the values (needed for initialization)
json_utf8 = uint8(zeros(1024, 1));
json_len = double(0); %#ok This is needed for informing Simulink about size
s = struct;

% Creates a persistent UDP sender to use on repeated calls to this function
persistent u;
if isempty(u)
    u = udpport;
end

% Needed to allow jsonencode to be run by the MATLAB engine (as is
% note supported directly through codegen
coder.extrinsic('jsonencode');

% Sets the values in the struct. Note that the single() usage converts the
% value representations from double-precision floating point numbers to
% single-precision (given that Unity only uses single-precision)

% Quaternions
s.eci_to_body_tar = single(eci_to_body_tar);
s.eci_to_body = single(eci_to_body);
s.eci_to_body_est = single(eci_to_body_est);

% Vectors
s.ang_vel = ang_vel;
s.sun_dir = sun_dir;
s.earth_dir = earth_dir;
s.mag = mag;
s.tar_dir = tar_dir;

% Estimated vectors
s.ang_vel_est = ang_vel_est;
s.sun_dir_est = sun_dir_est;
s.earth_dir_est = earth_dir_est;
s.mag_est = mag_est;

% Axes
s.body_axes = single(body_axes);
s.eci_axes = single(eci_axes);
s.ecef_axes = single(ecef_axes);
s.lvlh_axes = single(lvlh_axes);

% Sensors
s.anlg_sun_sens = single(anlg_sun_sens);

% Produces the JSON data through serializing the struct
json_str = jsonencode(s);
json_len = strlength(json_str); % Finds the data size

% Moves this new data to the fixed size output in uint8 format
json_utf8(1:json_len) = json_str;

% sends the json data to the Unity receiver
write(u, json_utf8, "uint8", "127.0.0.1", 7226);