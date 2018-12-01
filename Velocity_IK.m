%Velocity_IK 
function qdot = Velocity_IK(q, e_vel)
% Input: q - 1 x 3 vector of joint inputs [d1,q2,q3]
%        e_vel - 6 x 1 vector of end effector velocities, where
%                    e_vel(1:3) are the linear velocity
%                    e_vel(4:6) are the angular velocity

% Output: qdot - 1 x 3 vector of joint velocities [d1dot,q2dot,q3dot]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
d1 = q(1);
q2 = q(2);
q3 = q(3);

J = calcJacobian(d1,q2,q3);

% get qdot, (psuedo-inverse jacobian * vel of end effector)
qdot = (J\transpose(e_vel))';

end