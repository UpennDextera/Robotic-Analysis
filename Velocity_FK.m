%Velocity_FK
function e_vel = Velocity_FK(q, qdot)
% Input: q - 1 x 3 vector of joint inputs [d1,q2,q3]
%        qdot - 1 x 3 vector of joint velocities [d1dot,q2dot,q3dot]

% Outputs:  e_vel - 6 x 1 vector of end effector velocities, where
%                    e_vel(1:3) are the linear velocity
%                    e_vel(4:6) are the angular velocity

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1 = q(1);
q2 = q(2);
q3 = q(3);

J = calcJacobian(d1,q2,q3);

% full-body velocity  = Jacobian * qdot
e_vel = J * transpose(qdot);

end