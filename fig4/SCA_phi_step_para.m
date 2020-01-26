function [ L ] = SCA_phi_step_para( U,v,N, theta_old )
    %%
    Ut=abs(U);
    vt=abs(v);
    tmp1=0;
    for n0=1:N
        for i0=1:N
            if i0~=n0
                tmp1=tmp1+Ut(n0,i0)^2;
            end
        end
    end
    tmp2=0;
    for n0=1:N
        tmp2n=vt(n0);
        for i0=1:N
            if i0~=n0
                tmp2n=tmp2n+Ut(n0,i0);
            end
        end
        tmp2=tmp2+tmp2n^2;
    end
    tmp=tmp1+tmp2;
    L=2*sqrt(tmp);
end

