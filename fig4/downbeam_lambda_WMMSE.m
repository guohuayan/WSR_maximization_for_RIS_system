function [W]=downbeam_lambda_WMMSE(A,H,K,M,kav,lambda)
    W=zeros(M,K);
    A=A+lambda.*eye(M);
    A=A^(-1);
    for k0=1:K
        W(:,k0)=kav(k0)*A*H(k0,:)';
    end
end

