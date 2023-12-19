function [regAvgMeFix1,regAvgMeFix2,regAvgLi] = experimentOnlineLinear(T,previewHorizon,numMonte,typeSystem,wMag,n,m)
    strInd = 0;
    regAvgMeFix1 = zeros(previewHorizon,T);
    regAvgMeFix2 = zeros(previewHorizon,T);
    regAvgLi = zeros(previewHorizon,T);
    poleScale = 10^(-2);
    if(typeSystem == "pendulum")
%             [~,B,~] = LinearInvertedPendulumGenerator(poleScale);
%             sysDim = size(B);
%             n = sysDim(1);
%             m = sysDim(2);
        n = 4;
        m = 1;
    end
    parfor numExp = 1:numMonte
        warning('off',"all")
        %% Linear System onedim
        if(typeSystem == "pendulum")
            [A,B,K0] = LinearInvertedPendulumGenerator(poleScale);
        else
            [A,B,K0] = LinearRandomSystemGenerator(n,m,poleScale);
        end
            %% Linear Control Costs
            qrangeLower = 1;
            qrangeHigher = 10;
            rrangeLower = 1;
            rrangeHigher = 10;
            [Q,R] = LinearCostGenerator(qrangeLower,qrangeHigher,rrangeLower,rrangeHigher,n,m,T);
            d = dfind(A,B);
            w = wMag*randn(n,T);
            x0 = 10*rand(n,1);
        %% Online Control Result
        for W = strInd:previewHorizon-1
            for t = previewHorizon:T
                %% Onedim Linear
                [xNash,uNash] = onedimNash(Q,R,A,B,w,t,x0,n,m);
                [x1,u1] = onedimTrackingOL(A,B,Q,R,t,x0,n,m,w,W,K0);
                [x2,u2] = onedimOnestepOL(A,B,Q,R,t,x0,n,m,w,W,d);
                Qmax = (qrangeLower+qrangeHigher)*eye(n);
                Rmax = (rrangeLower+rrangeHigher)*eye(m);
                [x3,u3] = onedimLina(A,B,Q,R,t,x0,n,m,w,W,Qmax,Rmax);
                tempAdd = zeros(previewHorizon,T);
                tempAdd(W+1,t) = onedimRegret(x1,u1,xNash,uNash,Q,R,t);
                regAvgMeFix1 = regAvgMeFix1 + tempAdd;
                tempAdd(W+1,t) = onedimRegret(x2,u2,xNash,uNash,Q,R,t);
                regAvgMeFix2 = regAvgMeFix2 + tempAdd;
                tempAdd(W+1,t) = onedimRegret(x3,u3,xNash,uNash,Q,R,t);
                regAvgLi = regAvgLi + tempAdd;
            end
        end
    end
    regAvgMeFix1 = regAvgMeFix1./numMonte;
    regAvgMeFix2 = regAvgMeFix2./numMonte;
    regAvgLi = regAvgLi./numMonte;
end