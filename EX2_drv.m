clear all
close all
clc

%% Run Parameters

% Set lambda and f
f = 1; 
lam = 1;
str1 = num2str(f);
str2 = num2str(lam);
% set t, x and initial condition
tvals = linspace(0, 12, 4001); %need this many (4001) for stability
xvals = linspace(0, 1, 21);
init = abs(0.2*(sin(pi*xvals)) + .1*(sin(8*pi*xvals))); %IC's 
Nx = length(xvals); Nt = length(tvals);
bdry = [0 0]; % boundary conditions

%% solve PDE using finite differences - Open-Loop
ctrol =1;
[uvalsol, uxol] = EX2(xvals, tvals, init, f, lam, bdry, ctrol);

%% solve PDE using finite differences - Closed-Loop
ctrcl =2;
[uvalscl, uxcl] = EX2(xvals, tvals, init, f, lam, bdry, ctrcl);
%% plot results for U(x,t)

h1= figure(1);
set(gcf, 'Position', [200, 100, 1200, 800]);
subplot(2,2,1),surf(xvals, tvals, uvalsol(:,:),...
'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
xlabel('x'), ylabel('t [s]'), zlabel('u(x,t)');
title([ 'Open Loop:   f = ' str1, ' ,   \lambda = ' str2])
view([50,29])

subplot(2,2,2),surf(xvals, tvals, uvalscl(:,:),...
'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
xlabel('x'), ylabel('t [s]'), zlabel('u(x,t)');
title([ 'Closed Loop:   f = ' str1, ' ,   \lambda = ' str2])
view([50,29])

%% plot control u(1,t)
subplot(2,2,[3,4]),plot(tvals,uvalscl(:,Nx))
xlabel('t [s]');
ylabel('u(1,t)');
grid on