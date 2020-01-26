function [f1,W,beta,grt] = par_fun_B(theta,W_old,K,M,Pt,omega,Hd,Hr,G)
    Theta=diag(theta');
    H=Hd+Hr*Theta*G;
    W_span=W_old; 
    [ ~,grt,f0 ] = update_SINR( H,W_old,K,omega );
    [ beta ] =upadte_beta( H,W_old,K,grt);
    while(1)               
        [ A,L ] = Proxlinear_beam_para( H,K,M,beta );
        [ W ] =Proxlinear_beam_v2( W_span,H,K,M,grt,Pt,beta,omega,A,L );
        W_span=W;%+step*(W-W_last);
        [ ~,grt,f1 ] = update_SINR( H,W,K,omega );
        [ beta ] =upadte_beta( H,W,K,grt);
        if abs(f0-f1)<1e-3
            break
        end
        f0=f1;
    end
end


