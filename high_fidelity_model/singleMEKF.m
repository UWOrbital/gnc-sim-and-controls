function [q_n2m,P,delta_x] = singleMEKF(b,r,P,R,q_n2m, delta_x)

    b_est = quatrotate(q_n2m,r);
    b01 = b_est(1);
    b02 = b_est(2);
    b03 = b_est(3);
    
    
    H = [   0  -b03,  b02,  0,  0,  0;
          b03,    0, -b01,  0,  0,  0;
         -b02,  b01,    0,  0,  0,  0];
    
    K = P*transpose(H)/(H*P*transpose(H)+R^2*eye(3));
    
    epsilon = (b - quatrotate(q_n2m,r));
    
    delta_x = delta_x + K*(epsilon'-H*delta_x);
    
    P = (eye(6) - K*H)*P;

end