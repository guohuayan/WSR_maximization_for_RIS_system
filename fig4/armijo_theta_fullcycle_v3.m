function [ theta,f1,m,W_new,beta,grt ] = armijo_theta_fullcycle_v3( Ltheta,dir,f0,phi0, grad,grt,W,K,M,Pt,omega,Hd,Hr,G)
    m=0;
    rhom=0.95;
    rho0=1/Ltheta*100;    
    len=-real(grad'*dir);
    sig=0.4;
    while(1)
        rho=rho0*rhom^m;
        phi=phi0-rho*grad;
        x=exp(1j.*phi);
        [f1,W_new,beta,grt] = par_fun_B(x,W,K,M,Pt,omega,Hd,Hr,G);
        if (f1-f0)>=sig*rho*len
            break
        end
        if (rho)<1/Ltheta/10
            break
        end
        m=m+1;
    end
    theta=x;
end

