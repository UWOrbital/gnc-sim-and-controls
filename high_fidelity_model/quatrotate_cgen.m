function v = quatrotate_cgen(q,v)

assert(isequal(size(q), [1 4]), 'Array q size is not [1 4].');
assert(isequal(size(v), [1 3]), 'Array v size is not [1 3].');

q0 = q(1);
q1 = q(2);
q2 = q(3);
q3 = q(4);

M = zeros(3);

M(1,1) = 1 - 2*q2^2 - 2*q3^2;
M(1,2) = 2*(q1*q2 + q0*q3);
M(1,3) = 2*(q1*q3 - q0*q2);
M(2,1) = 2*(q1*q2 - q0*q3);
M(2,2) = 1 - 2*q1^2 - 2*q3^2;
M(2,3) = 2*(q2*q3 + q0*q1);
M(3,1) = 2*(q1*q3 + q0*q2);
M(3,2) = 2*(q2*q3 - q0*q1);
M(3,3) = 1 - 2*q1^2 - 2*q2^2;

v = (M*(v'))';
end