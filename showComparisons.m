function showComparisons(LiReg, TrackingReg, OnestepReg, JingtaoReg)
    dim = size(LiReg,1)*size(LiReg,2);
    disp("Tracking = "+string(sum((LiReg-TrackingReg)>=0,"all")/dim))
    disp("Onestep = "+string(sum((LiReg-OnestepReg)>=0,"all")/dim))
    disp("Jingtao = "+string(sum((JingtaoReg-OnestepReg)>=0,"all")/dim))
    fprintf("\n")
end