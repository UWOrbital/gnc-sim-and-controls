function [jd] = jd_from_datetime(year, month, day, hour, minute, second)

    % note that on days with a leap second, second / 61 should be used
    % instead of second / 60 -> implement this eventually or is needed?

    jd = 1721013.5 + 367*year - fix(7/4 * fix((month + 9) / 12)) + ...
        fix(275 * month / 9) + day + ...
        (60*hour + minute + second / 60) / 1440;


end