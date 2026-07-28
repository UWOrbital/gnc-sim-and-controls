% This program will slowly increase the seconds fed into datetime_upd to
% verify that the function is working as intended. This is not a formal
% unit test but rather just a testing script.

max_secs = 1000;

secs = 1:max_secs;
out = zeros(max_secs, 6);

init_datetime = [2001, 12, 30, 23, 58, 43];

for i=secs
    out(i, :) = datetime_upd(init_datetime, i);
end