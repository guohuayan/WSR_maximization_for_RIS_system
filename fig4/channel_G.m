function G=channel_G(AP_angle,IRS_angle,G_sig,eb1,eb2,N,M)
    G=eb1.*ULA_fun( IRS_angle ,N)*(ULA_fun( AP_angle ,M))'+eb2.*G_sig;
end

