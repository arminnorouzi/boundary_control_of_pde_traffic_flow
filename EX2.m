function [u, u_1] = EX2(x, t, init, f, lam, bdry,ctr)
Nt = length(t);
Nx = length(x);
dx = mean(diff(x));
dt = mean(diff(t));
r = dt/dx;
u = zeros(Nt,Nx);
u(1,:) = init;     %Initial value u(x,0)
u(:,1) = bdry(1);  %Boundary value u(x1,t)
u(:,Nx) = bdry(2); %Boundary value u(xn,t)
u_1 = zeros(Nt);
lam_y2 = zeros(Nt);


    for j=1:Nt-1

    u(j+1,1:Nx-1) = (r*(u(j,2:Nx)-u(j,1:Nx-1)))...
        +(dt*sum(f*exp(lam*(x(Nx-1) - x(1:Nx-1))).*u(j,1:Nx-1)))/(Nx-1)+u(j,1:Nx-1);

    lam_y2 = sqrt(f*(1- (x)));
    u_1 =  sum(-f*x(1:Nx-1) .* exp(lam*(1-x(1:Nx-1))) .* besseli(1,lam_y2(1:Nx-1)) ...
        ./ lam_y2(1:Nx-1) .* u(j,1:Nx-1))/Nx;


        if ctr == 1;
            u(j+1,Nx) = 0;
        else
            u(j+1,Nx) = u_1;
        end

    end