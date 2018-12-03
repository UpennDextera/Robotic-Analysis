function trajectory = DexVelocitySim(q)

dt = 0.1;
[pos, T0e] = FK(q);
e_pos = pos(5,:);
x_pos = [];
y_pos = [];
z_pos = [];
qdot = [10 0 0];
trajectory = [];
trajectory(end+1,:) = e_pos;

dexteraInitialize();
for t = 0:dt:10
   %for angle = 0:0.1:(2*pi)
    e_vel = velocity_FK(q, qdot);
    %e_vel = [10*cos(angle) 10*sin(angle) 0 0 0 0];
    %qdot = IK_velocity(q,e_vel);
    x_pos(end+1) = e_pos(1);
    y_pos(end+1) = e_pos(2);
    z_pos(end+1) = e_pos(3);
    
    dexteraSim(q);
    hold on;
    plot3(x_pos,y_pos,z_pos,'--','LineWidth',2);
    drawnow;
    
    e_pos = e_pos + transpose(e_vel(1:3)).*dt;
    q = q + qdot.*dt;
    trajectory(end+1,:) = e_pos;
    %end
end
