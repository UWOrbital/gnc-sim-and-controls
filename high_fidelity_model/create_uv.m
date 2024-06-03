function [st1,st2] = create_uv(r_sat_com,r_sat_com_ax1,r_sat_com_ax2,q_sat_com)
st1 = 0;
st2 = 0;

q_sat_com_reshape = reshape(q_sat_com,[1 4]);
r_sat_com_reshape = reshape(r_sat_com, [1 3]);

r_ref_com = quatrotate(q_sat_com_reshape,r_sat_com_reshape);

st1 = dot(r_ref_com,r_sat_com_ax1);
st2 = dot(r_ref_com,r_sat_com_ax2);

end