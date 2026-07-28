function [P, q_n2m,beta,hat_omega] = fullMEKF(P, q_n2m, beta, omega, ref_ss, mes_ss, use_sun_sensor, ref_mag, mes_mag, ...
                                            use_magnometer, ref_aam, mes_aam, use_ang_acc_magentorquer, use_ang_vel, ...
                                            mes_var_ss, mes_var_mg, mes_var_aam, min_angle_ss, dt, use_steve_mode, steve_ref, steve_mes)

    arguments (Input)
        P (6,6) double
        q_n2m (1,4) double
        beta (1,3) double
        omega (1,3) double
        ref_ss (1,3) double
        mes_ss (1,3) double
        use_sun_sensor (1,1) double %boolean
        ref_mag (1,3) double
        mes_mag (1,3) double
        use_magnometer (1,1) double %boolean
        ref_aam (1,3) double
        mes_aam (1,3) double
        use_ang_acc_magentorquer (1,1) double %boolean
        use_ang_vel (1,1) double %boolean
        mes_var_ss (1,1) double
        mes_var_mg (1,1) double
        mes_var_aam (1,1) double
        min_angle_ss (1,1) double
        dt  (1,1) double
        use_steve_mode  (1,1) double %boolean
        steve_ref (1,3) double
        steve_mes (1,3) double
    end

    arguments (Output)
        P (6,6) double
        q_n2m (1,4) double
        beta (1,3) double
        hat_omega (1,3) double
    end

    hat_omega = zeros(1, 3);
    hat_omega(1) = omega(1);% - beta(1);
    hat_omega(2) = omega(2);% - beta(2);
    hat_omega(3) = omega(3);% - beta(3);

    if use_ang_vel
        x_extra = [0, hat_omega];
        dot_q_n2m = 0.5*quatmultiply(q_n2m,x_extra);

        q_n2m = q_n2m + dot_q_n2m*dt;
        q_n2m = q_n2m/norm(q_n2m);

        w = [ 0  -hat_omega(3),  hat_omega(2);
              hat_omega(3),    0, -hat_omega(1);
             -hat_omega(2),  hat_omega(1),    0];
    else
        w = zeros(3);
    end
    

    %initialize
    delta_x = zeros(6,1);

    %loop over measurment vectors

    %magnometer
        if use_magnometer
            [q_n2m,P,delta_x] = singleMEKF(mes_mag,ref_mag,P,mes_var_mg,q_n2m,delta_x);
            %P = P_clip(P,1000);
        end    
    
    %sun sensor
        if use_sun_sensor
            [q_n2m,P,delta_x] = singleMEKF(mes_ss,ref_ss,P,mes_var_ss,q_n2m,delta_x);
            %P = P_clip(P,1000);
        end

        %steve mode
        if use_steve_mode 
            %[q_n2m,P,delta_x] = singleMEKF(steve_mes,steve_ref,P,0.1,q_n2m,delta_x);
            %P = P_clip(P,1000);
        end

        %angular velocity with accelerometer
        if use_ang_acc_magentorquer
            %[q_n2m,P,delta_x] = singleMEKF(mes_aam,ref_aam,P,mes_var_aam,q_n2m,delta_x);
            %P = P_clip(P,1000);
        end

    %reset
    x_extra = [0 , delta_x(1:3)'];

    q_n2m = q_n2m + (0.5*quatmultiply(q_n2m,x_extra));
    q_n2m = q_n2m/norm(q_n2m);

    beta = beta + delta_x(4:6)';

    if max(abs(delta_x(4:6))) > 10
        %disp("Oh no")
        %delta_x(4:6)
    end

    for i=1:3
        if abs(beta(i)) > 1
            beta(i) = sign(beta(i));
        end
    end

    %propagation
    propagateState = true;

    if propagateState

        G = [-eye(3), zeros(3);
             zeros(3), eye(3)];

        Q = [1^2*eye(3), zeros(3);
             zeros(3), 1^2*eye(3)]; %this is wrong

        F = [-w, eye(3);
             zeros(3), zeros(3)];

        dot_P = F*P + P*F'+G*Q*G';
        P = P + dot_P*dt;
        P = P_clip(P,1000);

    end

end