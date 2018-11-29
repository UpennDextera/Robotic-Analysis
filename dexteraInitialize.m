function dexteraInitialize()
global arm q

arm.firstFrame = true;
arm.showGrippers = false;

% Home pose
q = [0,0,0,0,0,0];
dexteraSim(q);
end