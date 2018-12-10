%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
syms d0 l real
syms q1 q2 q3 lg real

%Frame 1 w.r.t Frame 0
T1 = [1  0  0  0;
      0  1  0  0;
      0  0  1  d0;
      0  0  0  1];
  
%Frame 2 w.r.t Frame 1          
T2 = [1  0  0   0;
      0  0 -1   0;
      0  1  0  q1;
      0  0  0   1];
  
%Frame 3 w.r.t Frame 2
T3 = [cos(q2+pi/2)   0  sin(q2+pi/2)  0;
      sin(q2+pi/2)   0 -cos(q2+pi/2)  0;
            0        1       0          l;
            0        0       0          1];

%Frame 4 w.r.t Frame 3
T4 = [cos(q3+pi/2)  -sin(q3+pi/2)  0  lg*cos(q3+pi/2);
      sin(q3+pi/2)   cos(q3+pi/2)  0  lg*sin(q3+pi/2);
         0                  0          1           0;
         0                  0          0           1];
     
T0e = T1*T2*T3*T4;
pos = T0e(1:3,4);

J1 = diff(pos,q1);
J2 = diff(pos,q2);
J3 = diff(pos,q3);

J(1:3,1) = J1;
J(1:3,2) = J2;
J(1:3,3) = J3;

%Frame 1 w.r.t Frame 0 is I
R01 = [1 0 0;
       0 1 0;
       0 0 1];
   
%Frame 2 w.r.t Frame 1 
R12 = [1 0  0;
       0 0 -1;
       0 1  0];
          
%Frame 3 w.r.t Frame 2          
R23 = [cos(q2+(pi/2)) 0  sin(q2+(pi/2));   
       sin(q2+(pi/2)) 0 -cos(q2+(pi/2)); 
              0       1             0];

%Frame 4 w.r.t Frame 3
R34 = [cos(q3+(pi/2)) -sin(q3+(pi/2)) 0;  
       sin(q3+(pi/2))  cos(q3+(pi/2)) 0;
              0          0            1];
          
R02 = R01*R12;
R03 = R01*R12;%*R23;
R04 = R01*R12*R23*R34;

J4 = R02(1:3,3);
J5 = R03(1:3,3);
J6 = R04(1:3,3);

J(4:6,1) = J4*0;
J(4:6,2) = J5;
J(4:6,3) = J6;

Jacobian = J;
