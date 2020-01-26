function [W]=downbeam_lambda(A,H,K,M,grt,beta,lambda)
    W=zeros(M,K);
    A=A+lambda.*eye(M);
    A=A^(-1);
    for k0=1:K
        W(:,k0)=sqrt(grt(k0))*beta(k0)*A*H(k0,:)';
    end
end

