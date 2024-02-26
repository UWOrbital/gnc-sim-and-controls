function x_k = orbit_state_upd_grav(x_kprev, params)
%ORBIT_STATE_UPD_GRAV Estimates the next state vector based on the
%simplistic orbit governing equation

    dt = params(1);
    grav_param = params(2);

    r_kprev = x_kprev(1:3);
    v_kprev = x_kprev(4:6);

    r_k = r_kprev + v_kprev * dt;
    rmag_kprev = norm(r_kprev);
    v_k = v_kprev + grav_param / rmag_kprev^3 * r_kprev * dt;

    x_k = [r_k ; v_k];
end