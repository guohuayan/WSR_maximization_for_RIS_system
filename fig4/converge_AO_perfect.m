%% One need to download the Manopt toolbox from https://www.manopt.org/
close all
clear all

%% system parameters
load('user_channel.mat','K','N','M','ite','pd','ps','Hd_w','theta_init','AP_angle','IRS_angle',...
    'G_sig','User_angle','Hr_sig','eb1','eb2','path_d','path_i');
etai=1;
weight=1./((path_d));
weight=weight./sum(weight);
omega=weight;
%%
snr_w=linspace(0,10,3);
s0=1;
Pt=10.^(snr_w(s0)/10);
it=1e2;
rate_w=zeros(ite,it);
start=zeros(1,ite);
error_Ellipsoid=0;
beamforming_error=0;
parfor t0=1:ite
    %%
    rate_tmp=zeros(1,it);
    W_old=zeros(M,K);
    beta=zeros(1,K);
    %%
    Hd=pd.*Hd_w(:,:,t0);
    theta=theta_init(:,:,t0);
    Theta=diag(theta');
    %%
    G=channel_G(AP_angle,IRS_angle,G_sig(:,:,t0),eb1,eb2,N,M);
    Hr=ps.*channel_Hr(User_angle,Hr_sig(:,:,t0),eb1,eb2,K,N);
    %%
    H=Hd+Hr*Theta*G;
    %% init
    [ W,grt,f0 ] = init_W( H,M,K,Pt,omega );
     start(t0)=f0;
     f1=0;
     fout=f0;
     for con0=1:it
         %% update w
         while(1)
             %% update w£¬ beta ¸üÐÂ
              W_old=W;
             [ W ] = downlink_beam_WMMSE_v2( H,W_old,K,M,omega,Pt );
             [ ~,~,f1 ] = update_SINR( H,W,K,omega );
             if (f0-f1)>1e-4
                 fprintf('error!\n');
             end
             if abs(f0-f1)<1e-3
                 break
             end
             f0=f1;
         end
        [ theta, test1,test3] = man_opt_theta_direct( W,Hd,Hr,Theta,G,N,K,omega );
          Theta=diag(theta');
        %%
        H=Hd+Hr*Theta*G;
         %%
         [ ~,~,f1 ] = update_SINR( H,W,K,omega );
         f0=f1;
         rate_tmp(con0)=f1;
         fout=f0;
     end
     rate_w(t0,:)=rate_tmp;
end
rate_w=mean(rate_w);
start=mean(start);
rate_w=[start rate_w];
%%
% error_Ellipsoid
% beamforming_error
figure
plot(0:it,rate_w,'r-');
save('converge_A2_manopt_WMMSE_n5.mat','it','rate_w','M','K','N','omega');
 %%
 
 
 
 
 