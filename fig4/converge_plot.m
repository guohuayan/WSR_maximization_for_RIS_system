close all
clear all

line=1.1;
it=1e4;
load('down_without_IRS.mat','snr_w','rate_w','M','K','omega');
rate=rate_w(1);
figure
plot(0:it,rate.*ones(1,it+1),'k-','LineWidth',line);
grid on
hold on
load('down_IRS_phaserand.mat','snr_w','rate_w','M','K','N','omega');
rate=rate_w(1);
plot(0:it,rate.*ones(1,it+1),'k--','LineWidth',line);
%%
load('converge_A2_manopt_WMMSE_n5.mat','it','rate_w','M','K','N','omega');
rate_w(1)
plot(0:it,rate_w,'b-','LineWidth',line);
load('converge_speed_step_phi_CG_n5.mat','it','rate_w','M','K','N','omega');
rate_w(1)
plot(0:it,rate_w,'r--','LineWidth',line);
load('converge_stochastic_phi_rho_01_v3.mat','it','rate_w','M','K','N','omega','rho');
plot(0:it,rate_w,'m-','LineWidth',line);
load('converge_stochastic_phi_rho_05_v3.mat','it','rate_w','M','K','N','omega','rho');
plot(0:it,rate_w,'m-.','LineWidth',1.5);
%%
xlim([0,8e1]);
ylim([0.55,0.95]);
ylabel('WSR'); xlabel('$I_O$','Interpreter','latex');
it=100;
ht=plot(0:it,-1.*ones(1,it+1),'r--',0:it,-1.*ones(1,it+1),'b-',...
    0:it,-1.*ones(1,it+1),'m-',0:it,-1.*ones(1,it+1),'m-.',...
    0:it,-1.*ones(1,it+1),'k--',0:it,-1.*ones(1,it+1),'k-',...
    'linewidth',1.3);
g=legend(ht,'Perfect, Algorithm 2','Perfect, AO', 'Imperfect, $\varrho=0.1$',...
    'Imperfect, $\varrho=0.5$','Random Phase', 'Without RIS');
set(g,'Interpreter','latex','Location','southeast','FontSize',10) ;