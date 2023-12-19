function showComparisons(LiReg, TrackingReg, OnestepReg)
    dim = size(LiReg,1)*size(LiReg,2);
    disp("Tracking = "+string(sum((LiReg-TrackingReg)>=0,"all")/dim))
    disp("Onestep = "+string(sum((LiReg-OnestepReg)>=0,"all")/dim))
    fprintf("\n")
end