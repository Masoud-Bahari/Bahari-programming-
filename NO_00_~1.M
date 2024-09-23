
clear all
clc


Kini=0;
Ksteps=pi/(200);
Kfin=pi;

Line0p=0:Ksteps:1*pi;
Line_pi_zero=1*pi:-Ksteps:0;

zeross=0*Line0p;
ddd=size(Line0p,2);
Pconstant=pi*(ones(1,ddd));

LineN0X=-1*pi:Ksteps:0;

LineGNM=0:-Ksteps:-pi;



%Gamma-X path
kx1=zeross;
ky1=Line0p;
kz1=zeross;

%X-M path
kx2=Line0p;
ky2=Pconstant;
kz2=zeross;


%M-Gamma path
kx3=Line_pi_zero;
ky3=Line_pi_zero;
kz3=zeross;

% %X-Gamma path
%Negative parts

%(-X)-G path
kxN1=zeross;
kyN1=LineN0X;
kzN1=zeross;

%(-X)-G path
kxN2=LineGNM;
kyN2=LineGNM;
kzN2=zeross;


 KX=[kxN1,kx1,kx2,kx3,kxN2];
KY=[kyN1,ky1,ky2,ky3,kyN2];
KZ=[kzN1,kz1,kz2,kz3,kzN2];
 KxHelp=[kx1,kx1,kx1,kx1,kx1];
 
 StPs=size(kx1,2);
pok=size(KX,2);


    L=1;
    

tt=1;

%
%



 
% deltaP=Del3;
% delta0=Del0;

%
%Zeeman magnetic field 
Mx=0;
My=0;
Mz=0;%0.4;


%

%
%%Matrices
Sx=[        0           sqrt(3)/2            0           0;
        sqrt(3)/2               0               1           0;
                0                   1              0	sqrt(3)/2;
                0                   0          sqrt(3)/2	0;];

Sy=[        0	sqrt(3)/(2.*1i)	0	0;
-sqrt(3)/(2.*1i)	0	2/(2.*1i)	0;
0	-2/(2.*1i)	0	sqrt(3)/(2.*1i);
0	0	-sqrt(3)/(2.*1i)	0;];

Sz=[3/2	0	0	0;
        0	1/2	0	0;
        0	0	-1/2	0;
        0	0	0	-3/2;];

Iden=[1	0	0	0;
          0	1	0	0;
          0	0	1	0;
          0	0	0	1;];
      
      Zeeman=zeros(4,4);
%
op=Sz;

%for deltaP=0:1/100:1
    L1=1; L=1;
    N=80;


% 
for n=0:N-1
    L=1;
oo=1;
for ii=1:size(KX,2)
% m_y=m_x;

%m_x=m_x/D;
%%

%
Del3=1;%*(50/100);%abs(m_x);%abs(2*sin(m_x))+0.3;%1.5;%+0*1*((t 1i*sqrt(3))/(6*Kf*sqrt(pi)));
Del0=0;%100*(1/100)*Del3;

D=1;

mu=-6/D;


Lim1=2.0/D;
Lim2=-2.0/D;

LimIni=Lim2;
 LimFin=Lim1;
 
deltaP=Del3;
delta0=Del0;

%%
%
Alpha=-1;%-18.1/D;
% 4*Alpha+5*Beta
Beta=-0.3;%-17.5/D;
Gamma=Beta;%16.1/D;
delta=0;%-0.1/D;
%}
%

%{
D=1;%abs(-0.2/-18.1);%Del3;



% Lim1=2/D;   Lim2=-Lim1;

LimIni=Lim2;    LimFin=Lim1;  


Alpha=-0.2;
Beta=0.9669*Alpha;
Gamma=-0.92*Beta;
delta=0.0057*Beta;
 mu=-abs(0.1*Beta);
 
 Del3=abs(Alpha/-18.1);
Del0=0*(1/100)*Del3;
 
 deltaP=Del3;    delta0=Del0;
%}
beta=Beta;a=Alpha;gamma=Gamma;

m12=Alpha+Beta/4;
m32=Alpha+9*Beta/4;
% %'This is the localized states='
SURFEne(oo,1)=(abs(mu*(m12-m32)/(m12+m32)))/D;
SURFEne(oo,2)=(Del3*sqrt(3*mu./(4*Alpha+5*Beta)))/D;
SURFEne(oo,3)=SURFEne(oo,1)+SURFEne(oo,2);
SURFEne(oo,4)=SURFEne(oo,1)-SURFEne(oo,2);
oo=oo+1;
%%
 k_x=KX(ii);
 k_y=KY(ii);
%%%%%%%%-------The electron electron electron electron block of normal metal-------%%%%%%%%
%%
% k_x=1*k0;
% k_y=0*k0;
k_z=(2*pi*n)./N;%;
%%

kx=sin(k_x);
ky=sin(k_y);
kz=sin(k_z);

%%
%
Lx=2*(1-cos(k_x));%k^2
Ly=2*(1-cos(k_y));
Lz=2*(1-cos(k_z));
%%
kkk=Lx+Ly+Lz;
%%
 


hk=    (a*kkk)*Iden-mu*Iden+...
beta*(   Lx.*(Sx*Sx) + Ly.*(Sy*Sy)+Lz.*(Sz*Sz)   )+...
...
gamma*(  0*  kx.*kx.* (Sx*Sx)+ kx.*ky.* (Sx*Sy)+kx.*kz.* (Sx*Sz)+...
      ky.*kx.* (Sy*Sx)+0*ky.*ky.* (Sy*Sy)+ky.*kz.* (Sy*Sz)+...
      kz.*kx.* (Sz*Sx)+   kz.*ky.* (Sz*Sy)+0* kz.*kz.* (Sz*Sz)    )+...
      delta*(   kx.*(Sy*Sx*Sy-Sz*Sx*Sz) +  ky.*(Sz*Sy*Sz-Sx*Sy*Sx)   +     kz.*(Sx*Sz*Sx-Sy*Sz*Sy)       );

  

  
%%
%%%%%%%%-------The Hole Hole Hole Hole block of normal metal-------%%%%%%%%
%%We multipled the whole matrix and the linear momentum by a minus and we took the transpose of
%%the matrix
hkHole=-transpose(    (a*kkk)*Iden-mu*Iden+...
beta*(Lx.*(Sx*Sx)+ Ly.*(Sy*Sy)+Lz.*(Sz*Sz))+...
gamma*(  0*  kx.*kx.* (Sx*Sx)+ kx.*ky.* (Sx*Sy)+kx.*kz.* (Sx*Sz)+...
      ky.*kx.* (Sy*Sx)+0*ky.*ky.* (Sy*Sy)+ky.*kz.* (Sy*Sz)+...
      kz.*kx.* (Sz*Sx)+   kz.*ky.* (Sz*Sy)+0* kz.*kz.* (Sz*Sz)    )+...
      delta*(   (-kx).*(Sy*Sx*Sy-Sz*Sx*Sz) +  (-ky).*(Sz*Sy*Sz-Sx*Sy*Sx)   +     (-kz).*(Sx*Sz*Sx-Sy*Sz*Sy)       )  );

[V,EEE]=eig(hk);
EnergyBare(:,L1)=diag(EEE);   
%%

%%
%Spin Septet pairing 
k_p =kx+1i*ky;
k_n =kx-1i*ky;
% kz=1;
%%

%%
%
Septet=deltaP*[
(3/4)*k_n    (sqrt(3)/2)*kz   (sqrt(3)/4)*k_p   0;
(sqrt(3)/2)*kz     (3/4)*k_p   0    (-sqrt(3)/4)*k_n;
(sqrt(3)/4)*k_p     0  (-3/4)*k_n   (sqrt(3)/2)*kz;
0     (-sqrt(3)/4)*k_n   (sqrt(3)/2)*kz  (-3/4)*k_p;];
%}
%%
%{
Test=deltaP*[
0    1   0   0;
0     0   0   0;
0     0  0   0;
0     0   0  0;];
%}
%%
%Pairing singlet
%
Singlet=delta0*[
0   0   0   1;
0     0  -1 0  ;
0     1  0  0 ;
-1   0   0  0 ;];
%}
%%

%%
hpairing=Septet+Singlet;%hpairingSinglet;%;
%hpairing=hpairingSinglet;


Hbdg=[(hk+ Zeeman), hpairing;
  transpose(conj( hpairing)),( hkHole-transpose(Zeeman))];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SOrting the eigenvales and the eigenvectors for sure
%{
[Vbdg,E1]=eig(Hbdg);
[d_p,ind_p] = sort(diag(E1));%the sorted result goes to d_p with their relative index as ind_p
Es_p = E1(ind_p,ind_p);% According to the above index of sorted eigenvalues, we present the diagonal matrix of sorted eigenvalues
Vs_p = Vbdg(:,ind_p);% Based the index, we rearrange the matrix of eigenvectoes
%}
% EeE=real(eig(Hbdg));
Energ(:,L,tt)=real(eig(Hbdg))/D;
xx(:,L,tt)=L*ones(size(Energ,1),1);
L=L+1;
end
tt=tt+1;
end
%%


% Lim1=0.35/D;
% Lim2=-0.35/D;

%  F1=0;
%  F2=1;
LimIni=Lim2;
 LimFin=Lim1;
 
siz=4;
Xax(:,1)=xx(:);
Xax(:,2)=Energ(:);
%
%hFig=figure('name',append('\delta=',num2str(delta)) );
% KKK=F1:steps:F2;
% figure
% % set('Units','Points','InnerPosition',[0 0 350 700])
% plot(1:size(Energ,2),Energ(1,:),'r-')
% ylim([Lim2-0.1 Lim1+0.1]);
%  xlim([F1-0.1 F2+0.1]);
% hFig=figure(3)
figure(3)
hold on
%set(hFig,'Units','Points','InnerPosition',[0 0 650 1200])
%
for y=1:size(xx,3)
for i=1:size(xx,1)
plot(xx(i,:,y),Energ(i,:,y),'color', [0 0 0 0.01], 'LineWidth', 2)
% 
%plot(xx(i,:,y),Energ(i,:,y),'k-')
hold on
end
end
finall=size(KX,2);
LimIni=-2;
LimFin=2;
%hold on
ylim([LimIni-0.025 LimFin+0.025]);
xlim([0-10 finall+10]);
box on%  set(gca,'XTick',-pi:pi:pi) 
% set(gca,'XTickLabel',{'-X','0','X'})
%hold on
xmd1= 0:StPs:pok;

set(gca,'XTick',xmd1)
xticklabels({'-X','\Gamma','X','M','\Gamma','-M'})

xline(0,'-k');%-X
xline(StPs,'-k');%\Gamma
xline(2*StPs,'-k');%X
xline(3*StPs,'-k');%M
xline(4*StPs,'-k');%\Gamma
xline(5*StPs,'-k');%-M
%}
%{
ylim([LimIni LimFin]);xlim([-F2 F2]);
% ylim([LimIni-0.01 LimFin+0.01]);xlim([-F2-g F2+g]);
set(hFig,'Units','Points','InnerPosition',[0 0 350 700])

plot(transpose(xx(1,:,1)),SURFEne(:,1),'-b','Linewidth',0.1)
hold on
plot(transpose(xx(1,:,1)),-SURFEne(:,1),'-b','Linewidth',0.1)
hold on
plot(transpose(xx(1,:,1)),SURFEne(:,3),'-r','Linewidth',0.1)
hold on
plot(transpose(xx(1,:,1)),SURFEne(:,4),'-r','Linewidth',0.1)
hold on
plot(transpose(xx(1,:,1)),-SURFEne(:,3),'-r','Linewidth',0.1)
hold on
plot(transpose(xx(1,:,1)),-SURFEne(:,4),'-r','Linewidth',0.1)

ylim([LimIni LimFin]);xlim([-F2 F2]);
%}
%  xline(-18.1,'-b');
%  xlabel('\Delta')
% hFig=figure
% set(hFig,'Units','Points','InnerPosition',[0 0 350 700])
% scatter(Xax(:,1),Xax(:,2),siz, 'filled')
% ylim([Lim2-0.1 Lim1+0.1]);
%  xlim([F1-0.1 F2+0.1]);
