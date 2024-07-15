function [d] = vector_dangle(v1,v2)
d = dot(v1,v2)/(norm(v1)*norm(v2));
if abs(d) > 1
    d = sign(d);
end
d = acosd(d);
end