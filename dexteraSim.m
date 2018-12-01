function dexteraSim(q)

jointSize = 20;
frameSize = 100;
linkWidth = 2;
shadowWidth = 2;
axisWidth = 2;
gripperLineWidth = 3;

global arm

[jointPositions, T0e] = FK(q);

if(arm.firstFrame) %We need to create the plots
    clf; %Clear any previous plot
    xlabel('X (mm)')
    ylabel('Y (mm)')
    zlabel('Z (mm)')
    set(gca,'xtick',-1000:100:1000, 'ytick',-1000:100:1000,'ztick',-1000:100:1000)
    grid on
    view(80,20)
    
    axis equal vis3d
    xlim([-300 300]);
    ylim([-300 300]);
    zlim([-355.6 584]);
    
    arm.links = line(jointPositions(:,1),jointPositions(:,2),jointPositions(:,3),'color',[0.2,0.2,0.2],'LineWidth',linkWidth);
    hold on;
    
%     arm.shadow = line(jointPositions(:,1),jointPositions(:,2),zeros(size(jointPositions,1),1),'color',[0.5,0.5,0.5],'LineWidth',shadowWidth);
    
    arm.frameOrigins = scatter3(jointPositions(:,1),jointPositions(:,2),jointPositions(:,3),jointSize,'MarkerEdgeColor','none','MarkerFaceColor',[0,0,0]);
    
    EExAxis = T0e(1:3,1)';
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    EExAxis = -frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    arm.EEx = line([T0e(1,4),T0e(1,4)+EExAxis(1)],[T0e(2,4),T0e(2,4)+EExAxis(2)],[T0e(3,4),T0e(3,4)+EExAxis(3)],'Color','r','LineWidth',axisWidth);
    arm.EEy = line([T0e(1,4),T0e(1,4)+EEyAxis(1)],[T0e(2,4),T0e(2,4)+EEyAxis(2)],[T0e(3,4),T0e(3,4)+EEyAxis(3)],'Color','g','LineWidth',axisWidth);
    arm.EEz = line([T0e(1,4),T0e(1,4)+EEzAxis(1)],[T0e(2,4),T0e(2,4)+EEzAxis(2)],[T0e(3,4),T0e(3,4)+EEzAxis(3)],'Color','b','LineWidth',axisWidth);
    
    if(arm.showGrippers)
        g = q(3) + 8; %Gripper width
        l = 30; % Gripper length
        gripperPoints(1,:) = [g/2,0,l];
        gripperPoints(2,:) = [g/2,0,0];
        gripperPoints(3,:) = [-g/2,0,0];
        gripperPoints(4,:) = [-g/2,0,l];
        gripperPoints = jointPositions(5,:)' + T0e(1:3,1:3) * [gripperPoints]';
        gripperPoints = gripperPoints';
        arm.gripperOne = line(gripperPoints(:,1),gripperPoints(:,2),gripperPoints(:,3),'color',[0,0,0],'LineWidth',gripperLineWidth);
    end
    arm.firstFrame = false;
else 
    set(arm.links,'xdata',jointPositions(:,1),'ydata',jointPositions(:,2),'zdata',jointPositions(:,3));
    
    set(arm.shadow,'xdata',jointPositions(:,1),'ydata',jointPositions(:,2));
    
    set(arm.frameOrigins,'xdata',jointPositions(:,1),'ydata',jointPositions(:,2),'zdata',jointPositions(:,3));
    
    EExAxis = T0e(1:3,1)';
    EEyAxis = T0e(1:3,2)';
    EEzAxis = T0e(1:3,3)';
    EExAxis = frameSize*EExAxis;
    EEyAxis = frameSize*EEyAxis;
    EEzAxis = frameSize*EEzAxis;
    set(arm.EEx,'xdata',[T0e(1,4),T0e(1,4)+EExAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EExAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EExAxis(3)]);
    set(arm.EEy,'xdata',[T0e(1,4),T0e(1,4)+EEyAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEyAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEyAxis(3)]);
    set(arm.EEz,'xdata',[T0e(1,4),T0e(1,4)+EEzAxis(1)],'ydata',[T0e(2,4),T0e(2,4)+EEzAxis(2)],'zdata',[T0e(3,4),T0e(3,4)+EEzAxis(3)]);
    
    if(arm.showGrippers)
        g = q(6)+ 8; %Gripper width plus a bit for the physical size
        l = 30; % Gripper length
        gripperPoints(1,:) = [g/2,0,l];
        gripperPoints(2,:) = [g/2,0,0];
        gripperPoints(3,:) = [-g/2,0,0];
        gripperPoints(4,:) = [-g/2,0,l];
        gripperPoints = jointPositions(5,:)' + T0e(1:3,1:3) * [gripperPoints]';
        gripperPoints = gripperPoints';
        set(arm.gripper,'xdata',gripperPoints(:,1),'ydata',gripperPoints(:,2),'zdata',gripperPoints(:,3));
    end
    
end

drawnow
end