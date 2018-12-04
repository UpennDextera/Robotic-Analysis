%Velocity_FK
function e_vel = Velocity_FK(q, qdot)
% Input: q - 1 x 3 vector of joint inputs [d1,q2,q3]
%        qdot - 1 x 3 vector of joint velocities [d1dot,q2dot,q3dot]
 
% Outputs:  e_vel - 6 x 1 vector of end effector velocities, where
%                    e_vel(1:3) are the linear velocity
%                    e_vel(4:6) are the angular velocity
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1 = q(1);
q2 = q(2);
q3 = q(3);
lg = 75;

J(1,:) = [0, -lg*cos(q3 + pi/2)*sin(q2 + pi/2), -lg*cos(q2 + pi/2)*sin(q3 + pi/2)];
J(2,:) = [0, 0, lg*cos(q3 + pi/2)];
J(3,:) = [1, lg*cos(q2 + pi/2)*cos(q3 + pi/2), -lg*sin(q2 + pi/2)*sin(q3 + pi/2)];
J(4,:) = [0, sin(q2 + pi/2), sin(q2 + pi/2)];
J(5,:) = [ -1, 0, 0];
J(6,:) = [0, -cos(q2 + pi/2), -cos(q2 + pi/2)];

% full-body velocity  = Jacobian * qdot
e_vel = J * transpose(qdot);
 
end