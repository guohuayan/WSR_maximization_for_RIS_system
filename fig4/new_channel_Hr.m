function Hr=new_channel_Hr(User_angle,Hr_sig,eb1,eb2,rho,K,N)
    Hr=zeros(K,N);
    for k0=1:K
        User_angle_k=User_angle(k0);
        hr_sig=Hr_sig(k0,:);
        hr_sig=sqrt(1/(rho+1)).*hr_sig+sqrt(rho/2/(rho+1)).*(randn(1,N)+1j.*randn(1,N));
        hr=eb1.*(ULA_fun( User_angle_k ,N))'+eb2.*hr_sig;
        Hr(k0,:)=hr;
    end
end

