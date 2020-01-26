function [ W,grt,fint ] = init_W( H,M,K,Pt,omega )
    W=H'/(H*H');
    W=W./sqrt(power_W( W ));
    for k0=1:K
    W(:,k0)=W(:,k0).*sqrt(Pt);
    end
    %%
    [ ~,grt,f0 ] = update_SINR( H,W,K,omega );
    %%
    while(1)
        %% update w£¬ beta 
        [ beta ] =upadte_beta( H,W,K,grt);
        [ W ] =update_beam_v2( H,K,M,grt,Pt,beta,omega );
        [ ~,grt,fint ] = update_SINR( H,W,K,omega );
        if abs(f0-fint)<1e-3
            break
        end
        f0=fint;
    end
end

