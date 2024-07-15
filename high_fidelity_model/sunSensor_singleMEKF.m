function [q_n2m,P,delta_x] = sunSensor_singleMEKF(b,r_sun,P,R,q_n2m,delta_x)

    assert(isequal(size(b), [1 3]), 'Array b size is not [1 3].');
    assert(isequal(size(r_sun), [1 3]), 'Array r_sun size is not [1 3].');
    assert(isequal(size(P), [6 6]), 'Array P size is not [6 6].');
    assert(isequal(size(R), [1 1]), 'Array R size is not [1 1].');
    assert(isequal(size(q_n2m), [1 4]), 'Array q_n2m size is not [1 4].');
    assert(isequal(size(delta_x), [6 1]), 'Array delta_x size is not [6 1].');

    b_est = quatrotate_cgen(q_n2m,r_sun);
    b01 = b_est(1);
    b02 = b_est(2);
    b03 = b_est(3);

    H = [   0  -b03,  b02,  0,  0,  0;
          b03,    0, -b01,  0,  0,  0;
         -b02,  b01,    0,  0,  0,  0];

    if(abs(b(1)) > 10e-2)
        %H(1,:) = H(1,:)*sign(b01);
    else
        H(1,:) = zeros(1,6);
        b_est(1) = 0;
        %warning('The variable b1 is zero.');
    end
    if(abs(b(2)) > 10e-2)
        %H(2,:) = H(2,:)*sign(b02);
    else
        H(2,:) = zeros(1,6);
        b_est(2) = 0;
        %warning('The variable b2 is zero.');
    end
    if(abs(b(3)) > 10e-2)
        %H(3,:) = H(3,:)*sign(b03);
    else
        H(3,:) = zeros(1,6);
        b_est(3) = 0;
        %warning('The variable b3 is zero.');
    end

    if b_est == [0 0 0]
        %warning('The variable best is zero.');
    end

    S = H*P*transpose(H)+R^2*eye(3);
    
    K = P*transpose(H)/S;
    
    epsilon = (b - b_est);
    
    delta_x = delta_x + K*(epsilon'-H*delta_x);
    
    P = (eye(6) - K*H)*P;

end