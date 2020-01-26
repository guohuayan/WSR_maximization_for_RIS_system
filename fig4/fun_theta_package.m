function [f1,grt,beta,W,W_span,t_old,L_last,H,Theta ] = fun_theta_package(grt,theta,W,W_span,t_old,L_last,K,M,Pt,omega,Hd,Hr,G)
    Theta=diag(theta');
    H=Hd+Hr*Theta*G;
    [f1,grt,beta,W,W_span,t_old,L_last ] = fun_theta_obj(grt,H,W,W_span,t_old,L_last,K,M,Pt,omega);
end


