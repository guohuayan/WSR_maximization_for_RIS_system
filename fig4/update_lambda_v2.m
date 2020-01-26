function [ lambda,lambda_min ] = update_lambda_v2( lambda_min,lambda_max,A,M )
    tmp=(lambda_min+lambda_max)/2;
    while(1)
        tA=A+tmp.*eye(M);
        if rank(tA)<M
            tmp=(tmp+lambda_max)/2;
            lambda_min=tmp;
        else
            break
        end
    end
    lambda=tmp;
end

