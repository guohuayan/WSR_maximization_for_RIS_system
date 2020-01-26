%% compute the pathloss according to the users' locations
close all
clear all

load('user_location.mat','K','Pt','Lroom','Wroom','R');
%% 
AP=[0,0];
%%
IRS=[200,0];
d_g=sqrt(sum(abs(AP-IRS).^2));
L_g=path_LOS( d_g );
%% IRS-assist link
Lu=zeros(1,K);
for k0=1:K
    pt=Pt(k0,:)-IRS;
    du=sqrt(sum(abs(pt).^2));
    Lu(k0)=path_LOS( du );
end
Lu=Lu+L_g;
%% direct link
Ld=zeros(1,K);
for k0=1:K
    pt=Pt(k0,:)-AP;
    dk=sqrt(sum(abs(pt).^2));
    Ld(k0)=path_NLOS( dk );
%     Ld_test(k0)=path_LOS( dk );
end
Lu-Ld
%%
save('user_pathloss.mat','K','Lu','Ld');