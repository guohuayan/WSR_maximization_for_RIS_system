%% without the RIS
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
rate_w=zeros(1,length(snr_w));
for s0=1:length(snr_w)
    %%
    fprintf('snr=%d\n',snr_w(s0));
    Pt=10.^(snr_w(s0)/10);  % power constraint
    rate=zeros(1,ite);
    parfor t0=1:ite
        H=pd.*Hd_w(:,:,t0);
        %% init
        W=H'/(H*H');
        W=W./sqrt(power_W( W ));
        for k0=1:K
            W(:,k0)=W(:,k0).*sqrt(Pt);
        end
        [ gr,grt,f0 ] = update_SINR( H,W,K,omega );
         f1=0;
         %%
         while(1)
             %% update w£¬ beta update
              W_old=W;
             [ beta ] =upadte_beta( H,W,K,grt);
             [ W ] =update_beam_v2( H,K,M,grt,Pt,beta,omega );
             [ gr,grt,f1 ] = update_SINR( H,W,K,omega );
             if (f0-f1)>1e-3
                 fprintf('error!\n');
%                  pause
             end
             if abs(f0-f1)<1e-3
                 break
             end
             f0=f1;
         end
         rate(t0)=f1;
    end
    rate_w(s0)=mean(rate);
end
%%
figure
plot(snr_w,rate_w,'ro-');
grid on
save('down_without_IRS.mat','snr_w','rate_w','M','K','omega');
 %%
 
 
 
 
 