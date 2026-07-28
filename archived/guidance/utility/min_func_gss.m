function [x] = min_func_gss(func, init_x_lower, init_x_upper, conv_crit)
%MIN_FUNC Implements golden-section search to find local minimum of the
%provided function between initial bounds provided.

% this is the golden constant ratio
PHI = (1 + sqrt(5)) / 2;

% sets the initial bounds
x_lower = init_x_lower;
x_upper = init_x_upper;

while true
    % requires 2 values to detect whether a minimum has occurred
    d = (PHI - 1)*(x_upper - x_lower);
    x1 = x_lower + d;
    x2 = x_upper - d;

    f_x1 = func(x1);
    f_x2 = func(x2);
   
    if f_x1 < f_x2
        % x1 is the new current minimum and therefore everything on the 
        % left of x2 can be dropped (as x1 > x2 therefore higher values 
        % to left of x2)

        x_old = x_lower;
        x_lower = x2;

        % disp(["new x_lower: ", x_lower])

        % uses relative convergence criterion
        if abs(x_old - x_lower) / x_old < conv_crit
            x = x_lower; % closest value to actual minimum
            break;
        end
    else
        % f_x1 >= f_x2

        % x2 is the new current minimum and therefore everything on the
        % right of x1 can be dropped (as x1 > x2 therfore higher values to
        % right of x1)

        x_old = x_upper;
        x_upper = x1;

        % disp(["new x_upper: ", x_upper])

        % uses relative convergence criterion
        if abs(x_old - x_upper) / x_old < conv_crit
            x = x_upper; % closest value to actual minimum
            break;
        end
    end

end
