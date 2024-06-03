function [P, q_n2m,beta,hat_omega] = fullMEKF(P,q_n2m,beta,omega, ref_ss, mes_ss, use_sun_sensor, ref_mag, mes_mag, ...
                                            use_magnometer, ref_aam, mes_aam, use_ang_acc_magentorquer, use_ang_vel, mes_var_ss, mes_var_mg, mes_var_aam, dt, use_steve_mode, steve_ref, steve_mes)
    delta_x = zeros(6,1);

    G = [-eye(3), zeros(3);
    zeros(3), eye(3)];

    Q = [mes_var_ss^2*eye(3), zeros(3);
    zeros(3), mes_var_mg^2*eye(3)];

    %sun sensor
    if use_sun_sensor
    [q_n2m,P,delta_x] = singleMEKF(mes_ss,ref_ss,P,mes_var_ss,q_n2m,delta_x);
    end

    %magnometer
    if use_magnometer
    [q_n2m,P,delta_x] = singleMEKF(mes_mag,ref_mag,P,mes_var_mg,q_n2m,delta_x);
    end

    %steve mode
    if use_steve_mode 
        steve_mes_reshape = reshape(steve_mes,[1 3]);
        steve_ref_reshape = reshape(steve_ref,[1 3]);
        [q_n2m,P,delta_x] = singleMEKF(steve_mes_reshape,steve_ref_reshape,P,0.1,q_n2m,delta_x);
    end
    
    %angular velocity with accelerometer
    %if use_ang_acc_magentorquer
    %[q_n2m,P,delta_x] = mekf(mes_aam,ref_aam,P,mes_var_aam,q_n2m,delta_x);
    %end


    x_extra = [0 ; delta_x(1:3)]';

    q_n2m = q_n2m + (0.5*quatmultiply(q_n2m,x_extra));
    q_n2m = q_n2m/norm(q_n2m);

    hat_omega = zeros(3,1);
    if use_ang_vel
        %beta = beta + delta_x(4:6);
        hat_omega(1) = omega(1) - beta(1);
        hat_omega(2) = omega(2) - beta(2);
        hat_omega(3) = omega(3) - beta(3);
    end

    x_extra = [0; hat_omega]';
    dot_q_n2m = 0.5*quatmultiply(q_n2m,x_extra);

    q_n2m = q_n2m + dot_q_n2m*dt;
    q_n2m = q_n2m/norm(q_n2m);

    w = [ 0  -hat_omega(3),  hat_omega(2);
          hat_omega(3),    0, -hat_omega(1);
         -hat_omega(2),  hat_omega(1),    0];
    
    F = [-w, eye(3);
        zeros(3), zeros(3)];

    dot_P = F*P + P*F'+G*Q*G';

    P = P + dot_P*dt;

end