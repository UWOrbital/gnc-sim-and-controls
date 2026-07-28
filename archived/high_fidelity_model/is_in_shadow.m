function is_in_shadow = is_in_shadow(earth_to_sun_unit,sat_to_earth)
    if dot(earth_to_sun_unit,sat_to_earth) < 0
        is_in_shadow = 0;
        return
    end
    is_in_shadow = 1;


    %i dont get the logic here
    % earthRadius = 6371000;
    % % sat_to_earth is vector in meters
    % dist_from_shadow_centre = norm(cross(sat_to_earth, earth_to_sun_unit));
    % 
    % if dist_from_shadow_centre <= earthRadius
    %     is_in_shadow = 1;
    % else
    %     is_in_shadow = 0;
    % end
end