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
snr=0;
Pt=10.^(snr/10); 
it=1e2;
rate_w=zeros(ite,it);
start=zeros(1,ite);
error_Ellipsoid=0;
beamforming_error=0;
armijo_w=zeros(ite,it);
rho=0.5;
parfor t0=1:ite
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
     %%
     flag=0;
     grad_old=zeros(N,1);
     L_old=0;
     rate_f=0;
     x0=zeros(N,1);
     for con0=1:it
         step=1;
         gstep=(con0)^(-501/1000);
         %%
         theta=diag(Theta');
         Hd_t=sqrt(1/(rho+1)).*Hd_w(:,:,t0)+sqrt(rho/(rho+1)/2).*(randn(K,M)+1j.*randn(K,M));
         Hd_t=pd.*Hd_t;
         G_t=new_channel_G(AP_angle,IRS_angle,G_sig(:,:,t0),eb1,eb2,rho,N,M);
         Hr_t=ps.*new_channel_Hr(User_angle,Hr_sig(:,:,t0),eb1,eb2,rho,K,N);
         H=Hd_t+Hr_t*Theta*G_t;
         %%
         [ ~,~,f0 ] = update_SINR( H,W,K,omega );
        [ft,W,beta,grt] = par_fun_B(theta,W,K,M,Pt,omega,Hd_t,Hr_t,G_t);
        if ft<f0
            fprintf('beam error!\n');
            pause
        end
        [ Qx,qx,theta ] = surface_U_v_direct( W,Hd_t,Hr_t,Theta,G_t,N,K,grt,beta );
        theta_old=theta;
        %%
        U=-Qx;v=qx;
        phi0=angle(theta_old);
        x0=(1-step).*x0+step*phi0;
        x_theta=exp(1j.*x0);
        grad=real((2*U*x_theta-2*v).*(-1j.*conj(x_theta)));
        %%
        grad_old=(1-gstep).*grad_old+gstep.*grad;
        %%
        dir=-grad_old;
        [ Ltheta ] = SCA_phi_step_para( -Qx,qx,N, x_theta );
        L_old=(1-gstep).*L_old+gstep.*Ltheta;
         [ ~,~,f0 ] = update_SINR( H,W,K,omega );
        [ theta,f1,armijo_w(t0,con0),W,beta,grt ] = armijo_theta_fullcycle_v3( L_old,dir,f0,x0, grad_old,grt,W,K,M,Pt,omega,Hd_t,Hr_t,G_t);
        if f1<f0
            fprintf('theta error!\n');
            error_Ellipsoid=error_Ellipsoid+1;
%             pause
        end
        Theta=diag(theta');
        rate_f=(1-gstep).*rate_f+gstep.*f1;
         %%
         rate_tmp(con0)=rate_f;           
     end
     rate_w(t0,:)=rate_tmp;
end
rate_w=mean(rate_w);
start=mean(start);
rate_w=[start rate_w];
%%
fprintf('error Ellipsoid=%d\n',error_Ellipsoid);
fprintf('error beamforming=%d\n',beamforming_error);
%%
figure
plot(0:it,rate_w,'r-');
save('converge_stochastic_phi_rho_05_v3.mat','it','rate_w','M','K','N','omega','rho');
 %%
 armijo_w=mean(armijo_w);
 figure
 plot(1:it, armijo_w,'r-');
 grid on
 
 
 
 