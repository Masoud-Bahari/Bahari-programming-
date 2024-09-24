clc;clear all;II=[1 0;    0 1];   IX=[0 1; 1 0];  IY=[0 -1i;  1i 0];  IZ=[1 0;    0 -1];L=1;    F_i=-0*0.35;  F_f=0.35;   Stp=20000;
a_Al=5.6;   mu_Al=0.17; a_Au=10;    mu_Au=0.75; lambda=1.1; F0=0.2; g=-8.45;    Z2=zeros(2,2);  ZZ=zeros(2,2);
%--Superconducting model--------
Delta=1*0.08;   DEL=[Delta*1i*IY,ZZ;    ZZ,ZZ];
%----Electron-holecomponents-----
eh=[eye(4),zeros(4,4);  zeros(4,4), -eye(4)];
%%
Ryd=13.605*10^(-3); valueInDiagram=0.12;
nx=0; ny=0; nz=0;% It can be nur null oder eins
mx=nx*(valueInDiagram*(Delta/Ryd))*(Ryd/Delta); my=ny*(valueInDiagram*(Delta/Ryd))*(Ryd/Delta); mz=nz*(valueInDiagram*(Delta/Ryd))*(Ryd/Delta);
magStr=valueInDiagram*Delta/(13.605*10^(-3));
for mx=-(Ryd/Delta):1/20:(Ryd/Delta)
    L=1;    BMag=mz*[IZ,ZZ; ZZ,IZ] + mx*[IX,ZZ; ZZ,IX]+ my*[IY,ZZ; ZZ,IY];
for kx=F_i:1/Stp:F_f
ky=0; AL=(a_Al*(kx.^2+ky.^2)-mu_Al)*II;
Au=(a_Au*(kx.^2+ky.^2)-mu_Au)*II+lambda*(ky*IX-kx*IY)+g*(  (ky.^3+ky*kx.^2)*IX-(kx.^3+kx*ky.^2)*IY);
CC=F0*(II);%F0*II;%+Fx*IX+Fy*IY+Fz*IZ;
HN=[AL, CC; CC',Au]+BMag;
%-----Hole counter part-------
Au_hole=(a_Au*(kx.^2+ky.^2)-mu_Au)*II+lambda*((-ky)*IX-(-kx)*IY)+g*(  -(ky.^3+ky*kx.^2)*IX-(-(kx.^3+kx*ky.^2))*IY);
HN_hole=[AL, CC; CC',Au_hole]+BMag;
 %-------------------------------------
 HBdG=[HN, DEL;DEL', -transpose(HN_hole')];
%-----------------------------------------------------
e_orb=[ -eye(2),zeros(2,2); zeros(2,2), eye(2)];    e_BdG=[e_orb,zeros(4,4); zeros(4,4),zeros(4,4)];
[Vbdg,E1]=eig(HBdG); [d_p,ind_p] = sort(diag(E1),'ascend');%the sorted result goes to d_p with their relative index as ind_p
Es_p = E1(ind_p,ind_p);% According to the above index of sorted eigenvalues, we present the diagonal matrix of sorted eigenvalues
Vs_p = Vbdg(:,ind_p);% Based the index, we rearrange the matrix of eigenvectoes
Out1(:,L)=kx*ones(8,1); Out2(:,L)=diag(Es_p);   Out3(:,L)=diag(real(Vs_p'*eh*Vs_p));    Out4(:,L)=diag(real(Vs_p'*e_BdG*Vs_p));
X1(1,L)=kx; X2(1,L)=ky; ORB(:,L)=round(diag(real(Vs_p'*e_BdG*Vs_p)),2);     L=L+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X_1=Out1(:);X_2=Out2(:);X_3=Out3(:);X_4=Out4(:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%load('E:\Dropbox (University of Wuerzburg)\Masoud Baharis files\Privat\2-(The main) PhD Report\0-Programing codes\2-Updated PhD investigations\1-PHD\1-Programing code\3-Project with Philipp\2-Matlab\Al_Au.mat');
figure(235); hold on;scatter(X_1,X_2,7,X_4,'filled');hold on; m=colorbar('Location','NorthOutside','FontSize',13);
m.YTick = [0 1 2];m.YTickLabel = {'Holes','Aluminum', 'Gold'};caxis([-1 1]);  box on;xlim([F_i  F_f]);   ylim([-1 1]);   yline(0,'--k');
xline(0.2958,'-k'); xline(-0.2958,'-k'); yline(  -0.079927 ,'k-');  yline(  0.079927 ,'k-');
xlabel('Momentum (k)');ylabel('Energy');title('Excitation spectrum of heterostructure composed of 6 layer Aluminum and gold')
end