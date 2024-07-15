function [d] = quad_dangle(q1,q2)

    qr = quatmultiply(q1, quatinv(q2));
    q0 = abs(qr(1));
    
    if q0 > 1
        q0 = 1;
    end
    
    d = 2*acosd(q0);

end