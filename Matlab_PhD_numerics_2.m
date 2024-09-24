%%%% Here you find a piece of code written for generating isotropy of the finite energy Cooper pairing. The outcome represents circular nodes as a function of momentum.
clc;clear all;II=[1 0;    0 1];   IX=[0 1; 1 0];  IY=[0 -1i;  1i 0];  IZ=[1 0;    0 -1];
L=1;    F_i=-0.35;  F_f=0.35;   Stp=600;
%%
a_Al=5.6;   mu_Al=0.17; a_Au=10;    mu_Au=0.75; lambda=1.1; F0=0.2; g=-8.45;Z2=zeros(2,2);ZZ=zeros(2,2);
%--Superconducting model--------
Delta=0*0.08;DEL=[Delta*1i*IY,ZZ; ZZ,ZZ]; eh=[eye(4),zeros(4,4); zeros(4,4), -eye(4)];
mz=0*13.605*10^(-3); mx=0*13.605*10^(-3); BMag=mz*[IZ,ZZ; ZZ,IZ] + mx*[IX,ZZ; ZZ,IX];
for ky=F_i:1/Stp:F_f        
for kx=F_i:1/Stp:F_f
AL=(a_Al*(kx.^2+ky.^2)-mu_Al)*II; Au=(a_Au*(kx.^2+ky.^2)-mu_Au)*II+lambda*(ky*IX-kx*IY)+g*(  (ky.^3+ky*kx.^2)*IX-(kx.^3+kx*ky.^2)*IY);
CC=F0*(II);  HN=[AL, CC; CC',Au]+BMag;
%-----Hole counter part-------
Au_hole=(a_Au*(kx.^2+ky.^2)-mu_Au)*II+lambda*((-ky)*IX-(-kx)*IY)+g*(  -(ky.^3+ky*kx.^2)*IX-(-(kx.^3+kx*ky.^2))*IY);
HN_hole=[AL, CC; CC',Au_hole]+BMag; HBdG=[HN, DEL; DEL', -transpose(HN_hole)];
%-----------------------------------------------------
e_orb=[ eye(2),zeros(2,2); zeros(2,2), 2*eye(2)]; e_BdG=[e_orb,zeros(4,4); zeros(4,4),-eye(4)];
[vv,ee]=eig(HN); [dd,indx] = sort(diag(ee),'ascend'); e_e = ee(indx,indx); ee_ee(:,L)=diag(e_e);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%        
[Vbdg,E1]=eig(HBdG); [d_p,ind_p] = sort(diag(E1),'ascend');Es_p = E1(ind_p,ind_p);Vs_p = Vbdg(:,ind_p); Orbital=diag(real(Vs_p'*e_BdG*Vs_p));
X1(1,L)=kx; X2(1,L)=ky;     XX(1,L)=kx; YY(1,L)=ky;
E_E(:,L)=diag(Es_p);    ORB(:,L)=round(Orbital,2); L=L+1;
end
end
%%%%%%%%%%%%%%%%%%%
m_1=1; m3=1; m_2=1; m4=1; m5=1; m6=1;
Rx_1(:,:,1)=-2*ones(1,size(E_E,2));Rx_1(:,:,2)=-2*ones(1,size(E_E,2)); Rx_1(:,:,3)=-2*ones(1,size(E_E,2));
Ry_1(:,:,1)=-2*ones(1,size(E_E,2));Ry_1(:,:,2)=-2*ones(1,size(E_E,2));Ry_1(:,:,3)=-2*ones(1,size(E_E,2));
Rz_1(:,:,1)=-2*ones(1,size(E_E,2));Rz_1(:,:,2)=-2*ones(1,size(E_E,2));Rz_1(:,:,3)=-2*ones(1,size(E_E,2));
for ii=1:size(E_E,2)
if sign(sign(ORB(1,ii))*sign(ORB(2,ii)))==-1
Rx_1(1,m_1,1)=X1(1,ii);Ry_1(1,m_1,1)=YY(1,ii);Rz_1(1,m_1,1)=round(abs(E_E(1,ii)-E_E(2,ii)),5);m_1=m_1+1;
end
if sign(sign(ORB(2,ii))*sign(ORB(3,ii)))==-1
Rx_1(1,m_2,2)=X1(1,ii);Ry_1(1,m_2,2)=YY(1,ii);Rz_1(1,m_2,2)=round(abs(E_E(2,ii)-E_E(3,ii)),5);m_2=m_2+1;
end
if sign(sign(ORB(3,ii))*sign(ORB(4,ii)))==-1
Rx_1(1,m3,3)=X1(1,ii);Ry_1(1,m3,3)=YY(1,ii);Rz_1(1,m3,3)=round(abs(E_E(3,ii)-E_E(4,ii)),5);m3=m3+1;
end
if sign(sign(ORB(1,ii))*sign(ORB(3,ii)))==-1
Rx_1(1,m4,4)=X1(1,ii);Ry_1(1,m4,4)=YY(1,ii);Rz_1(1,m4,4)=round(abs(E_E(1,ii)-E_E(3,ii)),5);m4=m4+1;
end
if sign(sign(ORB(1,ii))*sign(ORB(4,ii)))==-1
Rx_1(1,m5,5)=X1(1,ii);Ry_1(1,m5,5)=YY(1,ii);Rz_1(1,m5,5)=round(abs(E_E(1,ii)-E_E(4,ii)),5);m5=m5+1;
end
if sign(sign(ORB(2,ii))*sign(ORB(4,ii)))==-1
Rx_1(1,m6,6)=X1(1,ii);Ry_1(1,m6,6)=YY(1,ii);Rz_1(1,m6,6)=round(abs(E_E(2,ii)-E_E(4,ii)),5);m6=m6+1;
end
end
fnf_x=[Rx_1(:,:,1),Rx_1(:,:,2),Rx_1(:,:,3),Rx_1(:,:,4),Rx_1(:,:,5),Rx_1(:,:,6)];fnf_y=[Ry_1(:,:,1),Ry_1(:,:,2),Ry_1(:,:,3),Ry_1(:,:,4),Ry_1(:,:,5),Ry_1(:,:,6)];fnf_z=[Rz_1(:,:,1),Rz_1(:,:,2),Rz_1(:,:,3),Rz_1(:,:,4),Rz_1(:,:,5),Rz_1(:,:,6)];
for ii=1:6
x{ii}=Rx_1(:,:,ii);y{ii}=Ry_1(:,:,ii);z{ii}=Rz_1(:,:,ii);
end
for ii=1:6
ix{ii}=find(abs(z{ii})<1/1000);
end
figure(555)
for u=1:6
hold on; plot(     x{u}(ix{u})    ,      y{u}(ix{u})    ,'g.'); hold on;    xlim([F_i  F_f]);  ylim([F_i  F_f]);
end
xlabel('Momentum (k)');ylabel('Isotropy of FE pairing');title('Finite energy superconducting nodes in heterostructure composed of 6 layer Aluminum and gold')
