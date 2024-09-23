
clc
clear all

tic
S_mag=0;
%StrZeeman=0;
StrNoNmag=0;

a_ini=0;
b_fin=0.3;

tic
Lattice=100;
load('J:\2-Updated PhD investigations\1-PHD\1-Programing code\2-Matlab\NewSet.mat');
load('J:\2-Updated PhD investigations\1-PHD\1-Programing code\2-Matlab\SpectrumResolved.mat');

VJ=0*0.6;
SJX=0*0.2;
SJY=0*0.2;
SJZ=0*0.3;




JJJ=3;

%
Hd=zeros(4,4);         
Impurity=zeros(4,4);   HoffDL=zeros(4,4);HoffUR=zeros(4,4);Hd1=zeros(4,4);holeH=zeros(4,4);       hnormal=zeros(4,4);       
holUR=zeros(4,4);       holDL=zeros(4,4);       SpinSep=zeros(4,4);         SpinSing=zeros(4,4);
%
FF=1;
UNIT=1;








Del3=1.0; n=0;    Del0=(n*Del3);

Alpha=-1/Del3%-18.1/D;%-0.2;%-18.14/UNIT;%uu;%-0.4;
Beta=-0.05;%*-0.3/Del3%-17.5/D;%0.96*Alpha%-17.563/UNIT;%uu;%-0.4;
Gamma=Beta;%0*-1.5/Del3%16.1/D;%-0.92*Beta%Beta;%-1;%Beta/2;
Cf=1;bbeta=Beta;hbar=1;
% delta=0*abs(Beta)/UNIT;
delta=0;%-0.1/D;%0.005*Beta/UNIT
mu=-6.7/Del3%-10.8;%-5.2;%-4.8;%-5.7;
D=1;%this is unit





%}
m12=Alpha+Beta/4;
m32=Alpha+9*Beta/4;
% %'This is the localized states='
DiracPoint=(mu*(m12-m32)/(m12+m32))
 


PhasTransition_criticalValue_mu=4*Alpha+5*Beta

EsurfState=(mu*(m12-m32)/(m12+m32));


%GammaGamma  delta  mu  Del3 PhasTransition_criticalValue_mu     DiracPoint  m32 m12  Del0  n


Kini=0;
Ksteps=pi/(500);
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


%  KX=[kx1,kx2,kx3];
% KY=[ky1,ky2,ky3];
% KZ=[kz1,kz2,kz3];
%  KxHelp=[kx1,kx1,kx1];
 
 KX=[kxN1,kx1,kx2,kx3,kxN2];
KY=[kyN1,ky1,ky2,ky3,kyN2];
KZ=[kzN1,kz1,kz2,kz3,kzN2];
 KxHelp=[kx1,kx1,kx1,kx1,kx1];
 
 StPs=size(kx1,2);
pok=size(KX,2);
% [m_x,m_y] = meshgrid(F1:steps:F2,F1:steps:F2);
    L=1;
%for mu=-8:1/200:2

%     if FF~32
%for m_x=F1:steps:F2
for ii=1:size(KX,2)
% for m_y=F1:steps:F2
%if abs(m_x)~=0%This avoid localized states at k=0
%m_x=0;
m_y=0;

 kx=KX(ii);%0*m_x;
 ky=KY(ii);
% for iii=1:size(K_Kx,2)
% kx=K_Kx(1,iii);
% ky=K_Ky(1,iii);

%Alpha=-1;
%Beta=1*-0.05;

%%%%%%%%%%%%%
Mx=0;%*1*sin(uu1);
My=0;
Mz=0.00;%2*sin(uu);
%%%%%%%%%%%%%%%%%%%%%%%%%%%Pairing Pairing Pairing Pairing Pairing Pairing Pairing Pairing Pairing%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%Zeeman Exchange for the Electron blocks%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sx=[0	sqrt(3)/2	0	0;
sqrt(3)/2	0	1	0;
0	1	0	sqrt(3)/2;

0	0	sqrt(3)/2	0;];
Sy=[0	sqrt(3)/(2.*1i)	0	0;
                -sqrt(3)/(2.*1i)	0	2/(2.*1i)	0;
                0	-2/(2.*1i)	0	sqrt(3)/(2.*1i);
                0	0	-sqrt(3)/(2.*1i)	0;];

Sz=[3/2	0	0	     0;
                0	1/2	0	      0;
                0	0	-1/2   	 0;
                0	0	0	-3/2;];

Unit=       [1	0	0	     0;
                0	1	0	      0;
                0	0	1   	 0;
                0	0	0	1;];

% ooo=Sz;
            
            
            
Zeeman=Mx.*Sx+My.*Sy+Mz.*Sz;
%%%%%%%%%%%%%%%%%%%%%%%%%%Electron Blocks--Electron Blocks--Electron Blocks--Electron Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Electron Blocks--Electron Blocks--Electron Blocks--Electron Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha32=Alpha+((9/4)*bbeta);
alpha12=Alpha+((1/4)*bbeta);

a=Alpha+((3/4)*bbeta);
ap=Alpha+((7/4)*bbeta);

%%
rho1= (   (sqrt(3)/2)*(delta)  )/(2*1i);
rho2=-(   (sqrt(3)/2)*(delta)    )/(2*1i);


%%   Diagonal elements   
Hd(1,1)=a.*4*(     sin(kx/2).^2    +sin(ky/2).^2     )    +2*alpha32-mu;    
Hd(2,2)=ap.*4*(   sin(kx/2).^2    +sin(ky/2).^2     )    +2*alpha12-mu;   
Hd(3,3)=ap.*4*(   sin(kx/2).^2    +sin(ky/2).^2     )    +2*alpha12-mu;   
Hd(4,4)=a.*4*(     sin(kx/2).^2    +sin(ky/2).^2     )    +2*alpha32-mu;   
%%%%%%%%%%%%%%%%%%%%%%%%
Hd(1,3)=(sqrt(3)/2)*Beta*4*(   sin(kx/2).^2    -sin(ky/2).^2     )   -   1i*sqrt(3)*Gamma*(sin(ky)*sin(kx)) ;    
Hd(2,4)=(sqrt(3)/2)*Beta*4*(   sin(kx/2).^2    -sin(ky/2).^2     )   -   1i*sqrt(3)*Gamma*(sin(ky)*sin(kx)) ;   

Hd(3,1)=(sqrt(3)/2)*Beta*4*(   sin(kx/2).^2    -sin(ky/2).^2     )   +   1i*sqrt(3)*Gamma*(sin(ky)*sin(kx)) ;  
Hd(4,2)=(sqrt(3)/2)*Beta*4*(   sin(kx/2).^2    -sin(ky/2).^2     )   +   1i*sqrt(3)*Gamma*(sin(ky)*sin(kx)) ;  
%%%%%%%%%%%%%%%%%%%%%%%%%
%Impurity effects
%In general, you can generate N random numbers in the interval (a,b) with the formula r = a + (b-a).*rand(N,1).
%%
%Inversion breaking term
ASOC(1,2)=-(sqrt(3)/4)*delta*(sin(kx)+1i*sin(ky));
ASOC(2,1)=-(sqrt(3)/4)*delta*(sin(kx)-1i*sin(ky));
ASOC(1,4)=-(3/4)*delta*(sin(kx)-1i*sin(ky));
ASOC(4,1)=-(3/4)*delta*(sin(kx)+1i*sin(ky));
ASOC(2,3)=(3/4)*delta*(sin(kx)+1i*sin(ky));
ASOC(3,2)=(3/4)*delta*(sin(kx)-1i*sin(ky));
ASOC(3,4)=-(sqrt(3)/4)*delta*(sin(kx)+1i*sin(ky));
ASOC(4,3)=-(sqrt(3)/4)*delta*(sin(kx)-1i*sin(ky));

Hd1=Hd+ASOC+Zeeman;

%%  Upper right off-diagonal block     
HoffUR(1,1)=-alpha32;
HoffUR(2,2)=-alpha12;  
HoffUR(3,3)=-alpha12;   
HoffUR(4,4)=-alpha32; 

HoffUR(1,2)=sqrt(3)*(Gamma/(2*1i))*(       sin(kx)-1i*sin(ky)    );
HoffUR(2,1)=sqrt(3)*(Gamma/(2*1i))*(       sin(kx)+1i*sin(ky)    );

HoffUR(3,4)=-sqrt(3)*(Gamma/(2*1i))*(       sin(kx)-1i*sin(ky)    );
HoffUR(4,3)=-sqrt(3)*(Gamma/(2*1i))*(       sin(kx)+1i*sin(ky)    );


%Inversion breaking terms
HoffUR(1,3)=rho1;           HoffUR(2,4)=rho2;        
HoffUR(3,1)=rho1;     HoffUR(4,2)=rho2;
%%  Lower left off-diagonal block     
HoffDL(1,1)=-alpha32;  
HoffDL(2,2)=-alpha12;    
HoffDL(3,3)=-alpha12;  
HoffDL(4,4)=-alpha32;

HoffDL(1,2)=-sqrt(3)*(Gamma/(2*1i))*(       sin(kx)-1i*sin(ky)    );
HoffDL(2,1)=-sqrt(3)*(Gamma/(2*1i))*(       sin(kx)+1i*sin(ky)    ); 
HoffDL(3,4)=sqrt(3)*(Gamma/(2*1i))*(       sin(kx)-1i*sin(ky)    );  
HoffDL(4,3)=sqrt(3)*(Gamma/(2*1i))*(       sin(kx)+1i*sin(ky)    );   
%%
%Inversion breaking terms
HoffDL(1,3)=-rho1;           HoffDL(2,4)=-rho2;            
HoffDL(3,1)=-rho1;     HoffDL(4,2)=-rho2;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Spin Septet Pairing--Spin Septet Pairing--Spin Septet Pairing%%%%%%%%%%%%%%%%%%%%%%%%%%
switch JJJ
    case 3
SpinSepDiagonal(1,1)= (3/4)*Del3*(       sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(2,2)= (3/4)*Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(3,3)=-(3/4)*Del3*(       sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(4,4)=-(3/4)*Del3*(       sin(kx)+1i*sin(ky)    );

SpinSepDiagonal(1,3)=   (sqrt(3)/4)*Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(3,1)=   (sqrt(3)/4)*Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(2,4)=- (sqrt(3)/4)*Del3*(        sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(4,2)=- (sqrt(3)/4)*Del3*(        sin(kx)-1i*sin(ky)    );



SpinSepUR(1,2)=(sqrt(3)/(4*1i))*Del3;
SpinSepUR(2,1)=(sqrt(3)/(4*1i))*Del3;  
SpinSepUR(3,4)=(sqrt(3)/(4*1i))*Del3;
SpinSepUR(4,3)=(sqrt(3)/(4*1i))*Del3;

SpinSepDL(1,2)=-(sqrt(3)/(4*1i))*Del3;
SpinSepDL(2,1)=-(sqrt(3)/(4*1i))*Del3;  
SpinSepDL(3,4)=-(sqrt(3)/(4*1i))*Del3;
SpinSepDL(4,3)=-(sqrt(3)/(4*1i))*Del3;

% %%%%%%%%%%%%%%%%%%%%%%%%%%Spin Singlet Pairing--Spin Singlet Pairing--Spin Singlet Pairing%%%%%%%%%%%%%%%%%%%%%%%%%%
SpinSing(1,4)=Del0;       SpinSing(3,2)=Del0; 
SpinSing(2,3)=-Del0;     SpinSing(4,1)=-Del0;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%Spin Triplet Pairing--Spin Triplet Pairing--Spin Triplet Pairing%%%%%%%%%%%%%%%%%%%%%%%%%%
% SpinTriplet(1,3)=(sqrt(3)/(2*1i*a))*Del1;           SpinTriplet(3,1)=(sqrt(3)/(2*1i*a))*Del1;
% SpinTriplet(2,2)=(1/(-1i*a))*Del1;                     SpinTriplet(3,3)=(1/(-1i*a))*Del1;
% SpinTriplet(2,4)=(sqrt(3)/(2*1i*a))*Del1;             SpinTriplet(4,2)=(sqrt(3)/(2*1i*a))*Del1;
% %%%%%%%%%%%%%%%%%%%%%%%%%% Spin xy j=2 L=1 and S=3 %%%%%%%%%%%%%%%%%%%%%%%%%%
   case 2
SpinSepDiagonal(1,1)= (-5*sqrt(3))   *Del3*(       sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(2,2)= (sqrt(3))        *Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(3,3)=(sqrt(3))         *Del3*(       sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(4,4)= (-5*sqrt(3))*Del3*(       sin(kx)+1i*sin(ky)    );

SpinSepDiagonal(1,3)=  Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(3,1)=  Del3*(       sin(kx)+1i*sin(ky)    );
SpinSepDiagonal(2,4)=  Del3*(        sin(kx)-1i*sin(ky)    );
SpinSepDiagonal(4,2)=  Del3*(        sin(kx)-1i*sin(ky)    );


SpinSepUR(1,2)=(5/(2*1i))*Del3;
SpinSepUR(2,1)=(5/(2*1i))*Del3;  
SpinSepUR(3,4)=-(5/(2*1i))*Del3;
SpinSepUR(4,3)=-(5/(2*1i))*Del3;

SpinSepDL(1,2)=-(5/(2*1i))*Del3;
SpinSepDL(2,1)=-(5/(2*1i))*Del3;  
SpinSepDL(3,4)=(5/(2*1i))*Del3;
SpinSepDL(4,3)=(5/(2*1i))*Del3;


case 322
SpinSepDiagonal(1,2)=-4*Del3;
SpinSepDiagonal(3,4)=-4*Del3;
SpinSepDiagonal(2,1)=4*Del3;
SpinSepDiagonal(4,3)=4*Del3;


SpinSepUR(1,2)=2*Del3;
SpinSepUR(3,4)=2*Del3;  
SpinSepUR(2,1)=-2*Del3;
SpinSepUR(4,3)=-2*Del3;

SpinSepDL(1,2)=2*Del3;
SpinSepDL(3,4)=2*Del3;  
SpinSepDL(2,1)=-2*Del3;
SpinSepDL(4,3)=-2*Del3;


end
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%

%%   Diagonal elements 

nn=1;


holeH(1,1)=  a.*4*(   sin(  ((-1)^nn).*kx/2).^2      +  sin(  ((-1)^nn).*ky/2).^2    )        + 2*alpha32-mu;    
holeH(2,2)=ap.*4*(   sin(  ((-1)^nn).*kx/2).^2      +  sin(  ((-1)^nn).*ky/2).^2    )        +2*alpha12-mu;   
holeH(3,3)=ap.*4*(   sin(  ((-1)^nn).*kx/2).^2      +  sin(  ((-1)^nn).*ky/2).^2    )        +2*alpha12-mu;   
holeH(4,4)= a.* 4*(   sin(  ((-1)^nn).*kx/2).^2      +  sin(  ((-1)^nn).*ky/2).^2    )        +2*alpha32-mu;   
%%%%%%%%%%%%%%%%%%%%%%%%
holeH(1,3)=(sqrt(3)/2)*Beta*4*(   sin(  ((-1)^nn).*kx/2).^2    -sin(    ((-1)^nn).*ky/2).^2     )  -  1i*sqrt(3)*Gamma*(sin(    ((-1)^nn).*ky   )*sin(   ((-1)^nn).*kx)  ) ;    
holeH(2,4)=(sqrt(3)/2)*Beta*4*(   sin(   ((-1)^nn).*kx/2).^2    -sin(  ((-1)^nn).*ky/2).^2     )   -  1i*sqrt(3)*Gamma*(sin(    ((-1)^nn).*ky   )*sin(   ((-1)^nn).*kx)  ) ;   

holeH(3,1)=(sqrt(3)/2)*Beta*4*(   sin(    ((-1)^nn).*kx/2).^2    -sin(    ((-1)^nn).*ky/2).^2     )  +  1i*sqrt(3)*Gamma*(sin(    ((-1)^nn).*ky   )*sin(   ((-1)^nn).*kx)  ) ;   
holeH(4,2)=(sqrt(3)/2)*Beta*4*(   sin(   ((-1)^nn).*kx/2).^2    -sin(    ((-1)^nn).*ky/2).^2     )   +  1i*sqrt(3)*Gamma*(sin(    ((-1)^nn).*ky   )*sin(   ((-1)^nn).*kx)  ) ;   
%%%%%%%%%%%%%%%%%%%%%%%%%
%here only kx and ky replace by its negative sign
hnormal=holeH-ASOC+Zeeman;
%Note that the minus in ASOC is due to minus k in BDG for linear k

%%  Upper right off-diagonal block     
holUR(1,1)=-alpha32;
holUR(2,2)=-alpha12;  
holUR(3,3)=-alpha12;   
holUR(4,4)=-alpha32; 

holUR(1,2)=sqrt(3)*(Gamma/(2*1i))*(       sin(   ((-1)^nn).*kx)-1i*sin(   ((-1)^nn).*ky)    );
holUR(2,1)=sqrt(3)*(Gamma/(2*1i))*(       sin(   ((-1)^nn).*kx)+1i*sin(   ((-1)^nn).*ky)    );

holUR(3,4)=-sqrt(3)*(Gamma/(2*1i))*(       sin(   ((-1)^nn).*kx)-1i*sin(   ((-1)^nn).*ky)    );
holUR(4,3)=-sqrt(3)*(Gamma/(2*1i))*(       sin(   ((-1)^nn).*kx)+1i*sin(   ((-1)^nn).*ky)    );



holUR(1,3)=rho1;           holUR(2,4)=rho2;        
holUR(3,1)=rho1;     holUR(4,2)=rho2;
%%  Lower left off-diagonal block     
holDL(1,1)=-alpha32;  
holDL(2,2)=-alpha12;    
holDL(3,3)=-alpha12;  
holDL(4,4)=-alpha32;

holDL(1,3)=-rho1;           holDL(2,4)=-rho2;            
holDL(3,1)=-rho1;           holDL(4,2)=-rho2;

holDL(1,2)=-sqrt(3)*(Gamma/(2*1i))* (    sin(  ((-1)^nn).*kx)-  1i*sin(   ((-1)^nn).*ky)    );
holDL(2,1)=-sqrt(3)*(Gamma/(2*1i))* (    sin(  ((-1)^nn).*kx)+ 1i*sin(   ((-1)^nn).*ky)    ); 
holDL(3,4)=sqrt(3)*(Gamma/(2*1i))*(    sin(  ((-1)^nn).*kx)-  1i*sin(   ((-1)^nn).*ky)    );  
holDL(4,3)=sqrt(3)*(Gamma/(2*1i))*(    sin(  ((-1)^nn).*kx)+ 1i*sin(    ((-1)^nn).*ky)    );   





%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Holes Blocks--Holes Blocks--Holes Blocks--Holes Blocks%%%%%%%%%%%%%%%%%%%%%%%%%%

zer=zeros(4,4);
Elec = cell(Lattice);
hole = cell(Lattice);

PairingSep=cell(Lattice);

SpinZ=cell(Lattice);
SpinX=cell(Lattice);
SpinY=cell(Lattice);
Vahed=cell(Lattice);




[m,n] = size(Elec );
% Zeros of the cell arrays
%Note that the filling by a(i) goes vertically from column by column.
for i=1:m*n
    
Elec{i}=zer;
hole{i}=zer;
PairingSep{i}=zer;
SpinZ{i}=zer;
SpinX{i}=zer;
SpinY{i}=zer;

Vahed{i}=zer;


end

%filling the cell arrays with block Hamiltonians
for i=1:Lattice
% Diagonal blocks of the Normal Metal with impurity
Impurity(1,1)=a_ini+ (b_fin-a_ini).*rand(1,1); % rand(1,1) returns a single uniformly distributed random number in the interval (0,1). The overal introduce random numbers in the interval (a_ini,b_fin)
Impurity(2,2)=a_ini+ (b_fin-a_ini).*rand(1,1); % rand(1,1) returns a single uniformly distributed random number in the interval (0,1). The overal introduce random numbers in the interval (a_ini,b_fin)
Impurity(3,3)=a_ini+ (b_fin-a_ini).*rand(1,1); % rand(1,1) returns a single uniformly distributed random number in the interval (0,1). The overal introduce random numbers in the interval (a_ini,b_fin)
Impurity(4,4)=a_ini+ (b_fin-a_ini).*rand(1,1); % rand(1,1) returns a single uniformly distributed random number in the interval (0,1). The overal introduce random numbers in the interval (a_ini,b_fin)


S_chem=StrNoNmag*(a_ini+ (b_fin-a_ini).*rand(1,1));
%RandDist_zeeman*Sz: this is zeeman field randomly to each atoms  RandDist_zeeman=StrZeeman*(a_ini+ (b_fin-a_ini).*rand(1,1));  
%Unit*RandDist_Nonmagnetic: Magnetic impurity effect
%S_magnetic*Impurity: Magnetic impurity effect


impJ=VJ.*Unit.*(a_ini+ (b_fin-a_ini).*rand(1,1))+SJX.*Sx.*(a_ini+ (b_fin-a_ini).*rand(1,1))+SJY.*Sy.*(a_ini+ (b_fin-a_ini).*rand(1,1))+SJZ.*Sz.*(a_ini+ (b_fin-a_ini).*rand(1,1));
Elec{i,i}=Hd1+S_mag*Impurity+S_chem*Unit+impJ;
PairingSep{i,i}=SpinSepDiagonal+SpinSing;
hole{i,i}=hnormal+S_mag*Impurity+S_chem*Unit+impJ;
%Off diagonal blocks of the Normal metal Hamiltonian (Electron and hole blocks)
SpinZ{i,i}=Sz;
SpinX{i,i}=Sx;
SpinY{i,i}=Sy;
Vahed{i,i}=Unit;

if i+1<=Lattice
%%   Electrons 
Elec{i,i+1}=HoffUR;
Elec{i+1,i}=HoffDL;
%%
%Hole states
hole{i,i+1}=holUR;
hole{i+1,i}=holDL;
%% Pairing
% PairingSep{i,i+1}=SpinSep;
% PairingSep{i+1,i}=-SpinSep;
PairingSep{i,i+1}=SpinSepUR;
PairingSep{i+1,i}=SpinSepDL;
end
%%%%%%%%%%%%%%%%%%
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HamiltonianElec =Cf*cell2mat(Elec);
HamiltonianHole=Cf*cell2mat(hole);

HamiltonianPairingUR=cell2mat(PairingSep);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HBdG=[HamiltonianElec,                                  HamiltonianPairingUR;
    conj(transpose(HamiltonianPairingUR)) ,      -transpose(HamiltonianHole)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Electrons=[    cell2mat(Vahed),   zeros(4*Lattice,4*Lattice);
    zeros(4*Lattice,4*Lattice),  zeros(4*Lattice,4*Lattice)];


SzBdG=[    cell2mat(SpinZ),   zeros(4*Lattice,4*Lattice);
   zeros(4*Lattice,4*Lattice),  zeros(4*Lattice,4*Lattice)];

SxBdG=[    cell2mat(SpinX),   zeros(4*Lattice,4*Lattice);
   zeros(4*Lattice,4*Lattice),  zeros(4*Lattice,4*Lattice)];
% 
% SxHoles=[    zeros(4*Lattice,4*Lattice),   zeros(4*Lattice,4*Lattice);
%                       zeros(4*Lattice,4*Lattice),  -cell2mat(SpinX)];

                  
  SxHoles=[    cell2mat(SpinY),   zeros(4*Lattice,4*Lattice);
      zeros(4*Lattice,4*Lattice),   zeros(4*Lattice,4*Lattice)];
  %}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [V,EEE]=eig(HBdG);          
%Energ(:,L)=diag(EEE);   'smallestabs',
[V,EEE]=eig(HBdG);%eigs(HBdG,50,  'smallestabs');%eig(HBdG);%eig(HBdG);%,'Tolerance',7e-2,'Tolerance',1e-5
[d_p,ind_p] = sort(diag(EEE));%the sorted result goes to d_p with their relative index as ind_p
%Es_p = EEE(ind_p,ind_p);% According to the above index of sorted eigenvalues, we present the diagonal matrix of sorted eigenvalues
Vs_p2 = V(:,ind_p);% Based the index, we rearrange the matrix of eigenvectoes
Vs_p=Vs_p2;%(dindx);

EeEe=d_p/D;



Energ(:,L)=d_p/D;%EeEe(dindx);
IPR(:,L)=transpose(log(sum((conj(Vs_p).*Vs_p).^2))./log(8*Lattice));
xx(:,L)=L*ones(size(Energ,1),1);
yy(:,L)=L*ones(size(Energ,1),1);


L=L+1;
end
%%
%end
% end
%LimIni=0.7; LimFin=2.;
% LimIni=-0.2; LimFin=0.2;
% F1=-0.1;F2=0.1;
% siz=60;
load('J:\2-Updated PhD investigations\1-PHD\1-Programing code\2-Matlab\IPR_IPR.mat');

Xax(:,1)=xx(:);
Xax(:,2)=yy(:);
Xax(:,3)=Energ(:);
IPR_local=IPR(:);%/abs(min(IPR(:)));


%  hold on



%{
% LimIni=0.72;    LimFin=0.74;      

siz=10;
load('J:\2-Updated PhD investigations\1-PHD\1-Programing code\2-Matlab\IPR_IPR.mat');
hold on
 hFig=figure(3)%randperm(99999,1))
set(hFig,'Units','Points','InnerPosition',[0 0 650 1200])
scatter(Xax(:,1),Xax(:,3),siz,IPR_local, 'filled')

 colormap(IPR_IPR);
 ss=-abs(max(IPR_local)/min(IPR_local));
caxis([-1 ss])

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


 
 
 
 Oo1=Xax(:,1);
Oo2=Xax(:,3);
Oo3=IPR_local;
IDX_IPR=find(IPR_local>=-0.58 & IPR_local<=0);
U1=Oo1(IDX_IPR);U2=Oo2(IDX_IPR);U3=Oo3(IDX_IPR);
[d_pp,indx_p] = sort(Oo3(IDX_IPR));

%figure(4)
hFig=figure(randperm(99999,1))
% hold on
scatter(U1,U2,8,U3, 'filled')
 colormap(IPR_IPR);
 ss=-abs(max(IPR_local)/min(IPR_local));
caxis([-1 ss])
 hold on
 for i=1:size(Energ,1)%min(kij):max(kij)%
 plot(xx(i,:),Energ(i,:),'k-','LineWidth', 0.1)%^,-xx(i,:),Energ(i,:),'k-')
 hold on
 end
 finall=size(KX,2);
LimIni=-1.5;
LimFin=1.5;
%hold on


ylim([min(Energ,[],'all')-0.025 max(Energ,[],'all')+0.025]);
% ylim([LimIni-0.025 LimFin+0.025]);
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


set(hFig,'Units','Points','InnerPosition',[0 0 1500 1200])

OO=datestr(now, 'yyyymmdd_HHMMSS');
 randomName = ['fig_' OO];
 
saveas(hFig,randomName,'fig')
saveas(hFig,randomName,'png')
randomFileName = ['workspace_' OO '.mat'];
save(randomFileName);