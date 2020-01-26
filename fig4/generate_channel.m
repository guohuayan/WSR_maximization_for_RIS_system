%% Generate the channel coefficients
close all
clear all

%%
load('user_pathloss.mat','K','Lu','Ld');
%%
noise=-170+10*log10(180*1e3);
path_d=10.^((-noise-Ld)/10);
path_i=10.^((-noise-Lu)/10);
%%
ite=1e2;
%%
N=100;
M=4;
%%
pd=sqrt(path_d);
pd=repmat(pd.',1,M);
ps=sqrt(path_i);
ps=repmat(ps.',1,N);
%% theta_init, channel Hd
Hd_w=zeros(K,M,ite);
theta_init=zeros(N,1,ite);
for j0=1:ite 
    Hd=sqrt(1/2).*(randn(K,M)+1j.*randn(K,M));
    theta=exp(1j.*rand(N,1).*2.*pi);
    %%
    Hd_w(:,:,j0)=Hd;
    theta_init(:,:,j0)=theta;
end
%%
eb=10;
eb2=1/(1+eb);
eb1=1-eb2;
eb1=sqrt(eb1);
eb2=sqrt(eb2);
%% channel G
AP_angle=rand(1,1);
IRS_angle=rand(1,1);
G_sig=zeros(N,M,ite);
for i0=1:ite
    G_sig(:,:,i0)=sqrt(1/2).*(randn(N,M)+1j.*randn(N,M));
end
%% channel Hr_w
User_angle=rand(1,K);
Hr_sig=zeros(K,N,ite);
for i0=1:ite
    Hr_sig(:,:,i0)=sqrt(1/2).*(randn(K,N)+1j.*randn(K,N));
end
%%
save('user_channel.mat','K','N','M','ite','pd','ps','Hd_w','theta_init','AP_angle','IRS_angle',...
    'G_sig','User_angle','Hr_sig','eb1','eb2','path_d','path_i');








