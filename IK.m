function [q, is_possible] = IK(o)
% Assume pose is reachable, check along the way
is_possible = 1;
q = [0,0,0];

% Arm constants in mm
d0 = 60; % base height (table to center of joint 1) 
l = 125;
lg = 75;

% Grippers frame origin
o_x = o(1);
o_y = o(2);
o_z = o(3);

q3 = asin((o_y+l)/lg) - pi/2;

if(mod(q3,pi) == 0)
  q2 = 0;
else
  q2 = acos(o_x/(lg*cos(q3+pi/2))) - pi/2;
end

q1 = o_z - d0 - lg*sin(q2+pi/2)*cos(q3+pi/2);

q = [q1 q2 q3];
end