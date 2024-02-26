function z_k = meas_gps_pos_vel(x_kprev, params)
%MEAS_GPS_POS_VEL Estimates GPS position and velocity measurements by only
%passing through the state vector
    r_kprev = x_kprev(1:3);
    v_kprev = x_kprev(4:6);

    z_k = [r_kprev ; v_kprev];
end