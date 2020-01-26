function [f1,grt,beta,W,W_span,t_old,L_last ] = fun_theta_obj(grt,H,W,W_span,t_old,L_last,K,M,Pt,omega)
    [ beta ] =upadte_beta( H,W,K,grt);
     %%
     [ W,W_span,t_old,L_last ] = Proxlinear_w( beta,grt,W_span,W,t_old,L_last,H,K,M,Pt,omega );
     [ ~,grt,f1 ] = update_SINR( H,W,K,omega );
     %          [ grt ] = update_alpha( beta,H,W,omega,K);
     %%
    [ beta ] =upadte_beta( H,W,K,grt);
end

