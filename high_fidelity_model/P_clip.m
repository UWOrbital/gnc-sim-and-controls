function [P] = P_clip(P,max)
    for i=1:36
        if abs(P(i)) > max
            P(i) = sign(P(i))*max;
        end
    end
end