function [jointPositions, T0e] = FK(q)

% Arm constants in mm
d0 = 60; % base height (table to center of joint 1) 
l = 125;
lg = 75;

%Frame 1 w.r.t Frame 0
T1 = [1  0  0  0;
      0  1  0  0;
      0  0  1  d0;
      0  0  0  1];
  
%Frame 2 w.r.t Frame 1          
T2 = [1  0  0   0;
      0  0 -1   0;
      0  1  0  q(1);
      0  0  0   1];
  
%Frame 3 w.r.t Frame 2
T3 = [cos(q(2)+pi/2)   0  sin(q(2)+pi/2)  0;
      sin(q(2)+pi/2)   0 -cos(q(2)+pi/2)  0;
            0         -1       0          l;
            0          0       0          1];

%Frame 4 w.r.t Frame 3
T4 = [cos(q(3)+pi/2)  -sin(q(3)+pi/2)  0  -lg*cos(q(3)+pi/2);
      sin(q(3)+pi/2)   cos(q(3)+pi/2)  0  -lg*sin(q(3)+pi/2);
         0                  0          1           0;
         0                  0          0           1];
  
%Position of Base
X(1,:) = [0 0 0 1];

%Position of First Joint (Prismatic)
X(2,:) = (T1*[0;0;0;1])';

%Position of Second Joint (Wrist Revolute 1)
X(3,:) = (T1*T2*[0;0;0;1])';

%Position of Third Joint (Wrist Revolute 2)
X(4,:) = (T1*T2*T3*[0;0;0;1])';

%Position of Grippers
X(5,:) = (T1*T2*T3*T4*[0;0;0;1])';

%Outputs the 5x3 of the locations of each joint in the Base Frame
jointPositions = X(:,1:3);

T0e = T1*T2*T3*T4;

end 

