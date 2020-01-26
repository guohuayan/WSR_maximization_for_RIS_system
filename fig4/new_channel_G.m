function G=new_channel_G(AP_angle,IRS_angle,G_sig,eb1,eb2,rho,N,M)
    G_sig=sqrt(1/(rho+1)).*G_sig+sqrt(rho/2/(rho+1)).*(randn(N,M)+1j.*randn(N,M));
    G=eb1.*ULA_fun( IRS_angle ,N)*(ULA_fun( AP_angle ,M))'+eb2.*G_sig;    
end

