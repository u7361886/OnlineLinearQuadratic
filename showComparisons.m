function showComparisons(LiReg, TrackingReg, JingtaoReg)
    dim = size(LiReg,1)*(size(LiReg,2)-size(LiReg,1));
    arr1 = LiReg-TrackingReg;
    arr2 = LiReg-JingtaoReg;
    arr3 = TrackingReg-JingtaoReg;
    disp("Tracking = "+string(sum((arr1(:,size(LiReg,1):end))>=0,"all")/dim))
%     disp("Onestep = "+string(sum((LiReg-OnestepReg)>=0,"all")/dim))
    disp("Jingtao = "+string(sum(arr2(:,size(LiReg,1):end)>=0,"all")/dim))
    disp("Tracking vs. Jingtao = "+string(sum((arr3(:,size(LiReg,1):end))>=0,"all")/dim))
    fprintf("\n")
end