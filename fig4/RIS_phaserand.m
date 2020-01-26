%% Random phase scheme
close all
clear all

%% system parameters
load('user_channel.mat','K','N','M','ite','pd','ps','Hd_w','theta_init','AP_angle','IRS_angle',...
    'G_sig','User_angle','Hr_sig','eb1','eb2','path_d','path_i');
etai=1;
weight=1./((path_d));
weight=weight./sum(weight);
omega=weight;
snr_w=linspace(0,10,3);
rate_w=zeros(1,length(snr_w));
parfor s0=1:length(snr_w)
    %%
    fprintf('snr=%d\n',snr_w(s0));
    Pt=10.^(snr_w(s0)/10);  
    rate=zeros(1,ite);
    for t0=1:ite
        %%
        beta=zeros(1,K);
        Hd=pd.*Hd_w(:,:,t0);
        theta=theta_init(:,:,t0);
        Theta=diag(theta');
        %%
        G=channel_G(AP_angle,IRS_angle,G_sig(:,:,t0),eb1,eb2,N,M);
        Hr=ps.*channel_Hr(User_angle,Hr_sig(:,:,t0),eb1,eb2,K,N);
        %%
        H=Hd+Hr*Theta*G;
        [ ~,~,f1 ] = init_W( H,M,K,Pt,omega );
         rate(t0)=f1;
    end
    rate_w(s0)=mean(rate);
end
%%
figure
plot(snr_w,rate_w,'ro-');
save('down_IRS_phaserand.mat','snr_w','rate_w','M','K','N','omega');
 %%
 
 
 
 
 