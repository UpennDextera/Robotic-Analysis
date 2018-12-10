function trajectory = DexVelocitySim(q)

dt = 0.01;
[pos, ~] = FK(q);
e_pos = pos(5,:);
x_pos = [];
x_pos(end+1) = e_pos(1);

y_pos = [];
y_pos(end+1) = e_pos(2);

z_pos = [];
z_pos(end+1) = e_pos(1);

qdot = [10 10 0];
trajectory = [];
trajectory(end+1,:) = e_pos;

dexteraInitialize();
for t = 0:dt:1
    e_vel = Velocity_FK(q, qdot);
    
    dexteraSim(q);
    hold on;
    plot3(x_pos,y_pos,z_pos,'--','LineWidth',2);
    drawnow;
    
    e_pos = e_pos + transpose(e_vel(1:3)).*dt;
    x_pos(end+1) = e_pos(1);
    y_pos(end+1) = e_pos(2);
    z_pos(end+1) = e_pos(3);
    q = q + qdot.*dt;
    trajectory(end+1,:) = e_pos;
end
