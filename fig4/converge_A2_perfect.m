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
     W_span=W;
     W_last=W;
     [ ~,L_last ] = Proxlinear_beam_para( H,K,M,beta );
     %%
     flag=0;
     t_old=1;
     [ beta ] =upadte_beta( H,W,K,grt);
     for con0=1:it
        [ Qx,qx,theta ] = surface_U_v_direct( W,Hd,Hr,Theta,G,N,K,grt,beta );
        theta_old=theta;
        %%
        U=-Qx;v=qx;
        x0=theta_old;
        phi0=angle(x0);
        grad=real((2*U*x0-2*v).*(-1j.*conj(x0)));
        dir=-grad;
        [ Ltheta ] = SCA_phi_step_para( -Qx,qx,N, theta );
        [ theta,t3,armijo_w(t0,con0) ] = armijo_theta( Ltheta,dir,f0,phi0, grad,grt,W,W_span,t_old,L_last,K,M,Pt,omega,Hd,Hr,G);
        %%
        [f1,grt,beta,W,W_span,t_old,L_last,H,Theta ] = fun_theta_package(grt,theta,W,W_span,t_old,L_last,K,M,Pt,omega,Hd,Hr,G);
         %%
         rate_tmp(con0)=f1;
         f0=f1;             
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
save('converge_speed_step_phi_CG_n5.mat','it','rate_w','M','K','N','omega');
 %%
 armijo_w=mean(armijo_w);
 figure
 plot(1:it, armijo_w,'r-');
 grid on
 
 
 
 