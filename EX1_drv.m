clear all
close all
clc

%% Run Parameters

% Set lambda and f
g = 3; 
b = 0;
str1 = num2str(g);
str2 = num2str(b);
% set t, x and initial temperature
tvals = linspace(0, 10, 4001); %need this many (4001) for stability
xvals = linspace(0, 1, 21);
init = abs(0.2*(sin(pi*xvals)) + .1*(sin(8*pi*xvals))); %IC's 
Nx = length(xvals); Nt = length(tvals);
bdry = [0 0]; % boundary conditions


%% solve PDE using finite differences - Open-Loop
ctrol =1;
[uvalsol, uxol] = EX1(xvals, tvals, init, g, b, bdry, ctrol);

%% solve PDE using finite differences - Closed-Loop
ctrcl =2;
[uvalscl, uxcl] = EX1(xvals, tvals, init, g, b, bdry, ctrcl);
%% plot results for U(x,t)

h1= figure(1);
set(gcf, 'Position', [200, 100, 1200, 800]);
subplot(2,2,1),surf(xvals, tvals, uvalsol(:,:),...
'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
xlabel('x'), ylabel('t [s]'), zlabel('u(x,t)');
title([ 'Open Loop:   g = ' str1, ' ,   b = ' str2])
view([50,29])

subplot(2,2,2),surf(xvals, tvals, uvalscl(:,:),...
'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
xlabel('x'), ylabel('t [s]'), zlabel('u(x,t)');
title([ 'Closed Loop:   g = ' str1, ' ,   b = ' str2])
view([50,29])

%% plot control u(1,t)
subplot(2,2,[3,4]),plot(tvals,uvalscl(:,Nx))
xlabel('t [s]');
ylabel('u(1,t)');
grid on