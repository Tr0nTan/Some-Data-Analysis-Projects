% event
function [check, isterminal, direction] = event1(t,y)
direction = [];
isterminal = 1;
check = double(y(2)<167400000*0.0005);
end