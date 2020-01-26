function [ Wopt ] =Proxlinear_beam_v2( W_span,H,K,M,grt,Pt,beta,omega,A,L )
    %% update W
    G=zeros(M,K);
    for k0=1:K
        G(:,k0)=2*sqrt(grt(k0))*beta(k0)*H(k0,:)'-2*A*W_span(:,k0);
    end
    G=-G;
    %%
    W=zeros(M,K);
    for k0=1:K
        W(:,k0)=(L*W_span(:,k0)-G(:,k0));
    end
    power=power_W( W );
    rho=Pt/power;
    Wopt=W.*sqrt(rho);
end

