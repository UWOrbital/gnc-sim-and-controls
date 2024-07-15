function r_ref_com_est = reverse_uv(r_sat_com,r_sat_com_ax1, ...
                                    r_sat_com_ax2,st1,st2)

r_ref_com_est_unshaped =  r_sat_com_ax1*st1 + r_sat_com_ax2*st2 ...
                         + r_sat_com*sqrt(1-st1^2-st2^2);

r_ref_com_est = reshape(r_ref_com_est_unshaped,[1 3]);

end