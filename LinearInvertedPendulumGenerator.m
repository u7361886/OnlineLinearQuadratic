function [A,B,K0] = LinearInvertedPendulumGenerator(poleScale)
    M = 0.5;
    g = 9.8;
    l = 0.3;
    mass = 0.2;
    I = 0.006;
    b = 0.1;
    den = (I*(M+mass)+M*mass*l^2);
    a22 = -(I+mass*l^2)*b/den;
    a23 = mass^2*g*l^2/den;
    a42 = -mass*l*b/den;
    a43 = mass*g*l*(M+mass)/den;

    A = [0,1,0,0;0,a22,a23,0;0,0,0,1;0,a42,a43,0];
    B = [0;(I+mass*l^2)/den;0;mass*l/den];
    K0 = -place(A,B,rand(1,4)*poleScale);
end