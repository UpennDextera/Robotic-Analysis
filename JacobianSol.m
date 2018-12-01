% function J = DexteracalcJacobian(q)
% d1 = q(1);
% q2 = q(2);
% q3 = q(3); 

syms d1 q2 q3 d0 l lg real

% % Dextera constants
% d0 = 60;
% l = 125; 
% lg = 75; 

%% FK Transforms 
%Frame 1 w.r.t Frame 0
T1 = [1  0  0  0;
      0  1  0  0;
      0  0  1  d0;
      0  0  0  1];
  
%Frame 2 w.r.t Frame 1          
T2 = [1  0  0   0;
      0  0 -1   0;
      0  1  0  d1;
      0  0  0   1];
  
%Frame 3 w.r.t Frame 2
T3 = [cos(q2+pi/2)   0  sin(q2+pi/2)  0;
      sin(q2+pi/2)   0 -cos(q2+pi/2)  0;
            0         -1       0          l;
            0          0       0          1];

%Frame 4 w.r.t Frame 3
T4 = [cos(q3+pi/2)  -sin(q3+pi/2)  0  lg*cos(q3+pi/2);
      sin(q3+pi/2)   cos(q3+pi/2)  0  lg*sin(q3+pi/2);
         0                  0          1           0;
         0                  0          0           1];

T0 = zeros(4,4,'sym');
T0(:,:,1) = T1;
T0(:,:,2) = T1*T2;
T0(:,:,3) = T1*T2*T3;
T0(:,:,4) = T1*T2*T3*T4;


%% ANGULAR VELOCITY JACOBIAN
% Approach: grab z vectors
Jw = zeros(3,3,'sym');
for i = 1:3
    Jw(:,i) = T0(1:3,3,i+1);
end


%% LINEAR VELOCITY JACOBIAN
% Approach: cross products
Jv = zeros(3,3,'sym');
for i = 1:3
    Jv(:,i) = cross(T0(1:3,3,i+1), T0(1:3,4,end)-T0(1:3,4,i+1));
end

%% Compose Jacobian Matrix and calc end effector velocities
J_CS = [Jv;Jw];


