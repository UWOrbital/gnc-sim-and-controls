function [q_n2m,P,delta_x] = singleMEKF(b,r,P,R,q_n2m, delta_x)

    assert(isequal(size(b), [1 3]), 'Array b size is not [1 3].');
    assert(isequal(size(r), [1 3]), 'Array r_sun size is not [1 3].');
    assert(isequal(size(P), [6 6]), 'Array P size is not [6 6].');
    assert(isequal(size(R), [1 1]), 'Array R size is not [1 1].');
    assert(isequal(size(q_n2m), [1 4]), 'Array q_n2m size is not [1 4].');
    assert(isequal(size(delta_x), [6 1]), 'Array delta_x size is not [6 1].');

    b_est = quatrotate_cgen(q_n2m,r);
    b01 = b_est(1);
    b02 = b_est(2);
    b03 = b_est(3);
    
    
    H = [   0  -b03,  b02,  0,  0,  0;
          b03,    0, -b01,  0,  0,  0;
         -b02,  b01,    0,  0,  0,  0];

    S = H*P*transpose(H)+R^2*eye(3);
    
    K = P*transpose(H)/S;
    
    epsilon = (b - quatrotate_cgen(q_n2m,r));
    
    delta_x = delta_x + K*(epsilon'-H*delta_x);
    
    P = (eye(6) - K*H)*P;

end