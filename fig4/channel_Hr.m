function Hr=channel_Hr(User_angle,Hr_sig,eb1,eb2,K,N)
    Hr=zeros(K,N);
    for k0=1:K
        User_angle_k=User_angle(k0);
        hr_sig=Hr_sig(k0,:);
        hr=eb1.*(ULA_fun( User_angle_k ,N))'+eb2.*hr_sig;
        Hr(k0,:)=hr;
    end
end

