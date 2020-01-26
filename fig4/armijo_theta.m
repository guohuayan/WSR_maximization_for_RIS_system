function [ theta,f1,m ] = armijo_theta( Ltheta,dir,f0,phi0, grad,grt,W,W_span,t_old,L_last,K,M,Pt,omega,Hd,Hr,G)
    m=0;
    rhom=0.95;
    rho0=1/Ltheta*100;    
    len=-real(grad'*dir);
%     len=-real(grad'*dir);
    sig=0.4;
    while(1)
        rho=rho0*rhom^m;
        phi=phi0-rho*grad;
        x=exp(1j.*phi);
        [f1,~,~,~,~,~,~,~,~ ] = fun_theta_package(grt,x,W,W_span,t_old,L_last,K,M,Pt,omega,Hd,Hr,G);
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

