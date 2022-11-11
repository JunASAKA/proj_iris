
function [posit_x] = positivization(x,type,i)
    if type == 1  % 极小
        posit_x = min2Max(x);
    elseif type == 2
        posit_x = mid2Max(x,best);
    elseif type == 3  % 区间
        a = input('Bottom Bound: ');
        b = input('Up Bound: ');
        posit_x = inter2Max(x,a,b);
    else
        disp('ERROR: 2')
    end
end
