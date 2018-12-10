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
    ylim([-400 100]);
    zlim([-100 200]);
    
    arm.link1 = Cylinder(o0,o1,8,20,C,1,0);
    arm.link2 = Cylinder(o1,o2,8,20,C,0,0);
    arm.link3 = Cylinder(o2,o3,8,20,C,0,0);
    arm.gripper1 = Cylinder(o3+[3 3 3],o4+[3 3 3],3,20,'r',0,0);
    arm.gripper2 = Cylinder(o3-[3 3 3],o4-[3 3 3],3,20,'r',0,0);
    
    hold on;
    
    [x,y,z] = sphere(100);
    arm.joint2 = surf((x*10)+o2(1),(y*10)+o2(2), (z*10)+o2(3),'FaceColor',C_joint,'EdgeColor','none');
    arm.joint3 = surf((x*10)+o3(1),(y*10)+o3(2), (z*10)+o3(3),'FaceColor',C_joint,'EdgeColor', 'none');
    L = 18; % prismatic joint size (length of an edge)
    
    X_cube = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_cube = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_cube = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_cube = L*(X_cube-0.5) + o1(1);
    Y_cube = L*(Y_cube-0.5) + o1(2);
    Z_cube = L*(Z_cube-0.5) + o1(3);
    
    arm.prismatic = patch(X_cube,Y_cube,Z_cube,C_joint); % draw prismatic joint 
    
    EExAxis = T0e(1:3,1)';
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    EExAxis = frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    arm.EEx = line([T0e(1,4),T0e(1,4)-EExAxis(1)],[T0e(2,4),T0e(2,4)-EExAxis(2)],[T0e(3,4),T0e(3,4)-EExAxis(3)],'Color','r','LineWidth',axisWidth);
    arm.EEy = line([T0e(1,4),T0e(1,4)+EEyAxis(1)],[T0e(2,4),T0e(2,4)+EEyAxis(2)],[T0e(3,4),T0e(3,4)+EEyAxis(3)],'Color','g','LineWidth',axisWidth);
    arm.EEz = line([T0e(1,4),T0e(1,4)+EEzAxis(1)],[T0e(2,4),T0e(2,4)+EEzAxis(2)],[T0e(3,4),T0e(3,4)+EEzAxis(3)],'Color','b','LineWidth',axisWidth);
    
    l = light('Position',[0.4 0.4 0.9],'Style','infinite');
    lighting gouraud
    material shiny
    
    arm.firstFrame = false;
else
    delete(arm.link1);
    delete(arm.link2);
    delete(arm.link3);
    delete(arm.gripper1);
    delete(arm.gripper2);
    delete(arm.prismatic);
    delete(arm.joint2);
    delete(arm.joint3);
    arm.link1 = Cylinder(o0,o1,8,20,C,1,0);
    arm.link2 = Cylinder(o1,o2,8,20,C,0,0);
    arm.link3 = Cylinder(o2,o3,8,20,C,0,0);
    arm.gripper1 = Cylinder(o3+[3 3 3],o4+[3 3 3],3,20,'r',0,0);
    arm.gripper2 = Cylinder(o3-[3 3 3],o4-[3 3 3],3,20,'r',0,0);
    
    hold on;
    
    [x,y,z] = sphere(100);
    arm.joint2 = surf((x*10)+o2(1),(y*10)+o2(2), (z*10)+o2(3),'FaceColor',C_joint,'EdgeColor','none');
    arm.joint3 = surf((x*10)+o3(1),(y*10)+o3(2), (z*10)+o3(3),'FaceColor',C_joint,'EdgeColor', 'none');
    L = 18; % prismatic joint size (length of an edge)
    
    X_cube = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
    Y_cube = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
    Z_cube = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];
    
    X_cube = L*(X_cube-0.5) + o1(1);
    Y_cube = L*(Y_cube-0.5) + o1(2);
    Z_cube = L*(Z_cube-0.5) + o1(3);
    
    arm.prismatic = patch(X_cube,Y_cube,Z_cube,C_joint); % draw prismatic joint 
    
    l = light('Position',[0.4 0.4 0.9],'Style','infinite');
    lighting gouraud
    material shiny
    
    EExAxis = T0e(1:3,1)';
    rot2 = EExAxis;
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    rot3 = EEzAxis;
    EExAxis = frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    set(arm.EEx,'xdata',[T0e(1,4),T0e(1,4)+EExAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EExAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EExAxis(3)]);
    set(arm.EEy,'xdata',[T0e(1,4),T0e(1,4)+EEyAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEyAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEyAxis(3)]);
    set(arm.EEz,'xdata',[T0e(1,4),T0e(1,4)+EEzAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEzAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEzAxis(3)]);
    
end

drawnow
end