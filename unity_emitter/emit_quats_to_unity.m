function [outputArg1,outputArg2] = emit_quats_to_unity(eci_to_body_tar, eci_to_body, eci_to_body_est)
%EMIT_QUATS_TO_UNITY Sends input quaternion values packaged in JSON to
%Unity sent over UDP

% Initializes the values (needed for initialization)
json_utf8 = uint8(zeros(1024, 1));
json_len = double(0); % Needed to inform Simulink of message size

s = struct;

% Creates a persistent UDP sender to use with repeated sends
persistent u;
if isempty(u)
    u = udpport;
end

% Needed to allow jsonencode to be run by the MATLAB engine (this is
% required as it allows jsonencode to be used with codegen)
coder.extrinsic('jsonencode');

% Sets the values in the struct. Note tha the single() usage converts the
% value representations from double-precision floating point numbers to
% single-precision (given that Unity only uses single-precision)

s.eci_to_body_tar = single(eci_to_body_tar);
s.eci_to_body = single(eci_to_body);
s.eci_to_body_est = single(eci_to_body_est);

% Produces the JSON data through serializing the struct
json_str = jsonencode(s);
json_len = strlength(json_str); % Finds the data size

% Moves this new data to the fixed size output in uint8 format
json_utf8(1:json_len) = json_str;

% Sends the json data to the Unity receiver
write(u, json_utf8, "uint8", "127.0.0.1", 7226);

end

