function [q_n2m,P,delta_x] = SimpleSunSensor_SingleMEKF(b,r_sun,r_ssensor,P,R,q_n2m, delta_x)

    b_est = quatrotate_cgen(q_n2m,r_sun);
    b01 = b_est(1);
    b02 = b_est(2);
    b03 = b_est(3);

    r_ssensor = r_ssensor/norm(r_ssensor);
    b_est = dot(quatrotate_cgen(q_n2m,r_sun),r_ssensor);
    b_est = (b_est > cosd(85))*b_est;

    if b_est == 0
        warning('The variable b_est is zero.');
    end


    H = [   0  -b03,  b02,  0,  0,  0;
          b03,    0, -b01,  0,  0,  0;
         -b02,  b01,    0,  0,  0,  0];
    H = H.*r_ssensor';
    H = sum(H,1);

    minMag = cosd(85);

    if(b_est < minMag)
        H = zeros(1,6);
        b_est = 0;
    end
    
    K = P*transpose(H)/(H*P*transpose(H)+R^2);
    
    epsilon = (b - b_est);
    
    delta_x = delta_x + K*(epsilon'-H*delta_x);
    
    P = (eye(6) - K*H)*P;

end