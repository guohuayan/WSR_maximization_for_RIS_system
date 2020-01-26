function yA=sum_rate_direct_egrad(x,A,B,omega,K,N,AA)
    tmp=zeros(K,K);
    for i0=1:K
        for k0=1:K
            tmp(i0,k0)=abs(x'*A(:,:,i0,k0)+B(i0,k0))^2;
        end
    end
    vA=zeros(N,1,K);
    for k0=1:K
        Bt=zeros(N,1);
        for i0=1:K
            Bt=Bt+AA(:,:,i0,k0)*x+(A(:,:,i0,k0)*B(i0,k0)');
        end
        Bt2=Bt-AA(:,:,k0,k0)*x-(A(:,:,k0,k0)*B(k0,k0)');
        tmp1=sum(tmp(:,k0));
        tmp2=tmp1-tmp(k0,k0);
        vA(:,:,k0)=2*omega(k0)*(Bt./(tmp1+1)-Bt2./(tmp2+1));
    end
    yA=-sum(vA,3);
end

