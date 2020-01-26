function [ beta ] =upadte_beta( H,W,K,grt)
    Hc=H*W;
    He=abs(Hc).^2;
    %% update beta
    beta=zeros(1,K);
    for k0=1:K
         tmp=Hc(k0,:);
         tmpe=He(k0,:);
         beta(k0)=sqrt(grt(k0))*tmp(k0)/(sum(tmpe)+1);
    end
end

