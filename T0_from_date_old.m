function [T0] = T0_from_date(year, month, day)
    T0 = (jd_from_datetime(year, month, day, 0, 0, 0) - 2451545) / 36525;
end