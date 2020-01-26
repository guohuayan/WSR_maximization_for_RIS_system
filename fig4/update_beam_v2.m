function [ Wopt ] =update_beam_v2( H,K,M,grt,Pt,beta,omega )
%     Hc=H*W_old;
%     He=abs(Hc).^2;
    %% update W
    A=zeros(M,M);
    for k0=1:K
        tmp=abs(beta(k0))^2*H(k0,:)'*H(k0,:);
        A=A+tmp;
    end
    %% init
    lambda_min=0;
    lambda_max=real(sum(sum(A)));
    flag=0;
    while(1)
        [Wn]=downbeam_lambda(A,H,K,M,grt,beta,lambda_max);
        power=power_W( Wn );
        if power>Pt
            lambda_min=lambda_max;
            lambda_max=lambda_max*2;
        elseif power==Pt
            flag=1;
            break
        else
            break
        end
    end
    if flag~=1
        rho=Pt/power;
        Wopt=Wn.*sqrt(rho);
        [ ~,~,f0 ] = update_SINR( H,Wopt,K,omega );
        while(1)
%             [ lambda ] = update_lambda( lambda_min,lambda_max,A,M );
%             lambda=(lambda_min+lambda_max)/2;
            [ lambda,lambda_min ] = update_lambda_v2( lambda_min,lambda_max,A,M );
            [Wn]=downbeam_lambda(A,H,K,M,grt,beta,lambda);
            power=power_W( Wn );
            rho=Pt/power;
            Wn=Wn.*sqrt(rho);
            [ ~,~,f1 ] = update_SINR( H,Wn,K,omega );
            %%
            if power>Pt
                lambda_min=lambda;
            else
                lambda_max=lambda;
            end
            if f1>f0
                Wopt=Wn;
            end
            f0=f1;
            if abs(lambda_max-lambda_min)<1e-3 && abs(power-Pt)<1e-5 && abs(f1-f0)<1e-5
                break
            elseif abs(lambda_max-lambda_min)<1e-7 && lambda_min==0
                break
            end
        end
    end
end

