function z_k  = meas_gps_pos(x_kprev, params)
%MEAS_GPS_POS Estimates only GPS position measurements by only passing
%through the state vector
    z_k = x_kprev(1:3);
end