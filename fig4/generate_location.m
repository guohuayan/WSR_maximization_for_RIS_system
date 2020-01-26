%% generate new location for the K users
close all
clear all

K=4;
%%
Pt=zeros(K,2);
%%
Lroom=200;
Wroom=30;
k1=[1,0];
k2=[0,1];
R=10;
%%
for k0=1:K
    r=rand(1,1)*R;
    theta=rand(1,1)*2*pi;
    px=r*cos(theta);
    py=r*sin(theta);
    pt=[Lroom,Wroom]+px*k1+py*k2;
    Pt(k0,:)=pt;
end
%%
save('user_location.mat','K','Pt','Lroom','Wroom','R');
figure
plot(Pt(:,1),Pt(:,2),'ro');
xlim([Lroom-R,Lroom+R]);ylim([Wroom-R,Wroom+R]);
hold on
theta=linspace(0,1,100).*2.*pi;
hold on
plot(Lroom+R*cos(theta),Wroom+R*sin(theta),'r.')