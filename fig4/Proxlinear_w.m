function [ W,W_span,t_old,L_last ] = Proxlinear_w( beta,grt,W_span,W_last,t_old,L_last,H,K,M,Pt,omega )
    [ A,L ] = Proxlinear_beam_para( H,K,M,beta );
    [ W ] =Proxlinear_beam_v2( W_span,H,K,M,grt,Pt,beta,omega,A,L );
    t=0.5*(1+sqrt(1+4*t_old^2));
    step_min=(t_old-1)/t;
    t_old=t;
    step=min(step_min,0.9999*sqrt(L_last/L));
    L_last=L;
    W_span=W+step*(W-W_last);
%     W_last=W;
end

