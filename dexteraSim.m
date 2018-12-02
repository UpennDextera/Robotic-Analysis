function dexteraSim(q)

frameSize = 50; % end effector frame size
axisWidth = 2; % width of axes
lg = 75; % gripper length
C = [0.28 0 0.8]; % link color
C_joint = [0.64 0.64 0.64]; % joint color

global arm

[jPos, T0e] = FK(q);

o0 = [jPos(1,1) jPos(1,2) jPos(1,3)];
o1 = [jPos(2,1) jPos(2,2) jPos(2,3)];
o2 = [jPos(3,1) jPos(3,2) jPos(3,3)];
o3 = [jPos(4,1) jPos(4,2) jPos(4,3)];
o4 = [jPos(5,1) jPos(5,2) jPos(5,3)];

if(arm.firstFrame) %We need to create the plots
    clf; %Clear any previous plot
    xlabel('X (mm)')
    ylabel('Y (mm)')
    zlabel('Z (mm)')
    set(gca,'xtick',-1000:100:1000, 'ytick',-1000:100:1000,'ztick',-1000:100:1000)
    grid on
    view(80,20)
    
    axis equal vis3d
    xlim([-200 100]);
    ylim([-300 100]);
    zlim([-100 200]);
    
    arm.link1 = Cylinder(o0,o1,8,20,C,1,0);
    arm.link2 = Cylinder(o1,o2,8,20,C,1,0);
    arm.link3 = Cylinder(o2,o3,8,20,C,1,0);
    
    hold on;
    
    [x,y,z] = sphere(100);
    joint2 = surf((x*10)+o2(1),(y*10)+o2(2), (z*10)+o2(3),'FaceColor',C_joint,'EdgeColor','none');
    joint3 = surf((x*10)+o3(1),(y*10)+o3(2), (z*10)+o3(3),'FaceColor',C_joint,'EdgeColor', 'none');
    L = 18; % prismatic joint size (length of an edge)
    
    X_cube = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_cube = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_cube = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_cube = L*(X_cube-0.5) + o1(1);
    Y_cube = L*(Y_cube-0.5) + o1(2);
    Z_cube = L*(Z_cube-0.5) + o1(3);
    
    prismatic = patch(X_cube,Y_cube,Z_cube,C_joint); % draw prismatic joint
    
    Lx = 10;
    Ly = lg;
    Lz = 5;
    
    X_grip = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_grip = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_grip = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_grip1 = Lx*(X_grip-0.5) + o4(1);
    Y_grip1 = Ly*(Y_grip-0.5) + o4(2) + (lg/2);
    Z_grip1 = Lz*(Z_grip-0.5) + o4(3) + 5;
    
    X_grip2 = Lx*(X_grip-0.5) + o4(1);
    Y_grip2 = Ly*(Y_grip-0.5) + o4(2) + (lg/2);
    Z_grip2 = Lz*(Z_grip-0.5) + o4(3) - 5;
    
    grip1 = fill3(X_grip1,Y_grip1,Z_grip1,C); % draw gripper stand-in
    grip2 = fill3(X_grip2,Y_grip2,Z_grip2,C); 
    
    EExAxis = T0e(1:3,1)';
    rot = EExAxis;
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    EExAxis = frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    arm.EEx = line([T0e(1,4),T0e(1,4)-EExAxis(1)],[T0e(2,4),T0e(2,4)-EExAxis(2)],[T0e(3,4),T0e(3,4)-EExAxis(3)],'Color','r','LineWidth',axisWidth);
    arm.EEy = line([T0e(1,4),T0e(1,4)+EEyAxis(1)],[T0e(2,4),T0e(2,4)+EEyAxis(2)],[T0e(3,4),T0e(3,4)+EEyAxis(3)],'Color','g','LineWidth',axisWidth);
    arm.EEz = line([T0e(1,4),T0e(1,4)+EEzAxis(1)],[T0e(2,4),T0e(2,4)+EEzAxis(2)],[T0e(3,4),T0e(3,4)+EEzAxis(3)],'Color','b','LineWidth',axisWidth);
    
    rotate(grip1, rot, q(2)*180/pi, o4);
    rotate(grip2, rot, q(2)*180/pi, o4);
    
    l = light('Position',[0.4 0.4 0.9],'Style','infinite');
    lighting gouraud
    material shiny
    
    arm.firstFrame = false;
else
    
    arm.link1 = Cylinder(o0,o1,8,20,C,1,0);
    arm.link2 = Cylinder(o1,o2,8,20,C,1,0);
    arm.link3 = Cylinder(o2,o3,8,20,C,1,0);
    
    hold on;
    
    [x,y,z] = sphere(100);
    surf((x*10)+o2(1),(y*10)+o2(2), (z*10)+o2(3),'FaceColor',C_joint,'EdgeColor','none');
    surf((x*10)+o3(1),(y*10)+o3(2), (z*10)+o3(3),'FaceColor',C_joint,'EdgeColor', 'none');
    L = 18; % prismatic joint size (length of an edge)
    
    X_cube = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_cube = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_cube = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_cube = L*(X_cube-0.5) + o1(1);
    Y_cube = L*(Y_cube-0.5) + o1(2);
    Z_cube = L*(Z_cube-0.5) + o1(3);
    
    patch(X_cube,Y_cube,Z_cube,C_joint); % draw prismatic joint
    
    Lx = 10;
    Ly = lg;
    Lz = 5;
    
    X_grip = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_grip = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_grip = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_grip1 = Lx*(X_grip-0.5) + o4(1);
    Y_grip1 = Ly*(Y_grip-0.5) + o4(2) + (lg/2);
    Z_grip1 = Lz*(Z_grip-0.5) + o4(3) + 5;
    
    X_grip2 = Lx*(X_grip-0.5) + o4(1);
    Y_grip2 = Ly*(Y_grip-0.5) + o4(2) + (lg/2);
    Z_grip2 = Lz*(Z_grip-0.5) + o4(3) - 5;
    
    grip1 = fill3(X_grip1,Y_grip1,Z_grip1,C); % draw gripper stand-in
    grip2 = fill3(X_grip2,Y_grip2,Z_grip2,C); 
    
    l = light('Position',[0.4 0.4 0.9],'Style','infinite');
    lighting gouraud
    material shiny
    
    EExAxis = T0e(1:3,1)';
    rot = EExAxis;
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    EExAxis = frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    set(arm.EEx,'xdata',[T0e(1,4),T0e(1,4)-EExAxis(1)],'ydata',[T0e(2,4),T0e(2,4)-EExAxis(2)],'zdata',[T0e(3,4),T0e(3,4)-EExAxis(3)]);
    set(arm.EEy,'xdata',[T0e(1,4),T0e(1,4)+EEyAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEyAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEyAxis(3)]);
    set(arm.EEz,'xdata',[T0e(1,4),T0e(1,4)+EEzAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEzAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEzAxis(3)]);
    
    rotate(grip1, rot, q(2)*180/pi, o4);
    rotate(grip2, rot, q(2)*180/pi, o4);
end

drawnow
end