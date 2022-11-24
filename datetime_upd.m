function [new_datetime] = datetime_upd(init_datetime, secs_from_start)

% the datetime format is provided as a 6 value array
% year, month, day, hour, minute, second

% adds the seconds from start of simulation to seconds
new_datetime(6) = init_datetime(6) + secs_from_start;

% computes the new seconds and minutes with carry over
new_datetime(5) = init_datetime(5) + floor(new_datetime(6) / 60);
new_datetime(6) = mod(new_datetime(6), 60);

% computes the new minutes and hours with carry over
new_datetime(4) = init_datetime(4) + floor(new_datetime(5) / 60);
new_datetime(5) = mod(new_datetime(5), 60);

% computes the new hours and days with carry over
new_datetime(3) = init_datetime(3) + floor(new_datetime(4) / 24);
new_datetime(4) = mod(new_datetime(4), 24);

% computes the new days and months with carry over
new_datetime(2) = init_datetime(2) + floor(new_datetime(3) / (275/9));

% NOTE: the floor here is specifically needed to prevent a recurring
% decimal from occurring here due to using an average number of days per
% month of 275/9 (this also caps days in a month to 30)
new_datetime(3) = floor(mod(new_datetime(3), (275/9)));

% computes the new months and years with carry over

% for calculations, shifts first month to 0
new_datetime(2) = new_datetime(2) - 1;

new_datetime(1) = init_datetime(1) + floor(new_datetime(2) / 12);

% done with calculations, restores first month to 1
new_datetime(2) = mod(new_datetime(2), 12) + 1;

end