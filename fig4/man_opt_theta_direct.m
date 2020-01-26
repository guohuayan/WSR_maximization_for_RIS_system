function [ theta, cost_old,cost_new] = man_opt_theta_direct( W,Hd,Hr,Theta,G,N,K,omega )
    A=zeros(N,1,K,K);
    for i0=1:K
         for k0=1:K
             atp=diag(Hr(k0,:))*G*W(:,i0);
             A(:,:,i0,k0)=atp;
         end
    end
    AA=zeros(N,N,K,K);
    for i0=1:K
         for k0=1:K
             AA(:,:,i0,k0)=A(:,:,i0,k0)*A(:,:,i0,k0)';
         end
    end
    theta=diag(Theta');
    B=Hd*W;
    B=B.';
    %%
    cost_old= sum_rate_direct(theta,A,B,omega,K);
    problem.M = complexcirclefactory(N);
    problem.cost  = @(x) sum_rate_direct(x,A,B,omega,K);
    problem.egrad = @(x) sum_rate_direct_egrad(x,A,B,omega,K,N,AA);      % notice the 'e' in 'egrad' for Euclidean
    options.verbosity=0;
    options.stopfun = @mystopfun;
    [theta, cost_new, ~, ~] = conjugategradient(problem,theta,options);
end

