function is_in_shadow = is_in_shadow(earth_to_sun_unit,sat_to_earth)
    if dot(earth_to_sun_unit,sat_to_earth) < 0
        is_in_shadow = 0;
        return
    end


    earthRadius = 6371000;
    % sat_to_earth is vector in meters
    dist_from_shadow_centre = norm(cross(sat_to_earth, earth_to_sun_unit));

    is_in_shadow = (dist_from_shadow_centre <= earthRadius);
end