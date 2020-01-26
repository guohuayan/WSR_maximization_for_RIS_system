function [ A,L ] = Proxlinear_beam_para( H,K,M,beta )
    A=zeros(M,M);
    for k0=1:K
        tmp=abs(beta(k0))^2*H(k0,:)'*H(k0,:);
        A=A+tmp;
    end
    L=2*norm(A, 'fro' );
end

