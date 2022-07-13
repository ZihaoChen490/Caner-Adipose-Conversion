function df=Force000(t,x,y)

g_MEK=y(1);g_ERK=y(2);g_CEBP=y(3);g_PPAR=y(4);k_MEK=y(5);k_ERK=y(6);k_CEBP=y(7);k_PPAR=y(8);lambda_EM=y(9);lambda_ME=y(10);
lambda_EE=y(11);lambda_MC=y(12);lambda_PC=y(13);lambda_EC=y(14);lambda_MP=y(15);lambda_CP=y(16);lambda_EP=y(17);n_EM=y(18);n_ME=y(19);n_EE=y(20);
n_MC=y(21);n_PC=y(22);n_EC=y(23); n_MP=y(24);n_CP=y(25);n_EP=y(26);MEK_MC=y(27);MEK_MP=y(28);MEK0_ME=y(29);ERK0_EC=y(30);
ERK0_EP=y(31);CEBP0_CP=y(32);PPAR_PC=y(33);ERK0_EM=y(34);ERK0_EE=y(35);TGF=y(36);rkip=y(37);MEKi=y(38);Rosi=y(39);lambda_EEi=y(40);
ERK0_EEi=y(41);n_EEi=y(42);lambda_MM=y(43);MEK0_MM=y(44);n_MM=y(45);
%%lead in the parameters

MEK=x(1,:);ERK=x(2,:);CEBP=x(3,:);PPAR=x(4,:);

%df(1,:)=g_MEK*TGF*Hs(MEK,rkip0_rM,lambda_rM,n_rM)-k_MEK*MEK*MEKi*Hs(ERK,ERK0_EM,lambda_EM,n_EM);
%{
df(1,:)=g_MEK.*TGF.*Hs(MEK,MEK0_MM,lambda_MM,n_MM)-k_MEK.*MEK.*rkip.*MEKi.*Hs(ERK,ERK0_EM,lambda_EM,n_EM);
df(2,:)=g_ERK.*Hs(MEK,MEK0_ME,lambda_ME,n_ME).*Hs(ERK,ERK0_EE,lambda_EE,n_EE)-k_ERK.*ERK.*Rosi.*Hs(ERK,ERK0_EEi,lambda_EEi,n_EEi);
df(3,:)=g_CEBP.*Rosi.*Hs(MEK,MEK_MC,lambda_MC,n_MC).*Hs(PPAR,PPAR_PC,lambda_PC,n_PC)-k_CEBP.*Hs(ERK,ERK0_EC,lambda_EC,n_EC).*CEBP.*TGF;
df(4,:)=g_PPAR.*Rosi.*Hs(MEK,MEK_MP,lambda_MP,n_MP).*Hs(CEBP,CEBP0_CP,lambda_CP,n_CP)-k_PPAR.*Hs(ERK,ERK0_EP,lambda_EP,n_EP).*PPAR;
%}
df(1,:)=g_MEK.*TGF.*(1+lambda_MM.*(MEK./MEK0_MM).^n_MM)/(1+(MEK/MEK0_MM).^n_MM)-k_MEK.*MEK.*rkip.*MEKi.*(1+lambda_EM.*(ERK/ERK0_EM).^n_EM)/(1+(ERK/ERK0_EM).^n_EM);
df(2,:)=g_ERK*(1+lambda_ME*(MEK./MEK0_ME).^n_ME)/(1+(MEK/MEK0_ME).^n_ME)*(1+lambda_EE*(ERK/ERK0_EE)^n_EE)/(1+(ERK/ERK0_EE)^n_EE)-k_ERK*ERK*Rosi*(1+lambda_EEi*(ERK./ERK0_EEi).^n_EEi)/(1+(ERK/ERK0_EEi).^n_EEi);
df(3,:)=g_CEBP.*Rosi.*(1+lambda_MC*(MEK./MEK_MC).^n_MC)/(1+(MEK/MEK_MC).^n_MC).*(1+lambda_PC*(PPAR./PPAR_PC).^n_PC)/(1+(PPAR/PPAR_PC).^n_PC)-k_CEBP.*(1+lambda_EC*(ERK./ERK0_EC).^n_EC)/(1+(ERK/ERK0_EC).^n_EC)*CEBP.*TGF;
df(4,:)=g_PPAR.*Rosi.*(1+lambda_MP*(MEK./MEK_MP).^n_MP)/(1+(MEK/MEK_MP).^n_MP)*(1+lambda_CP*(CEBP./CEBP0_CP).^n_CP)/(1+(CEBP/CEBP0_CP).^n_CP)-k_PPAR.*(1+lambda_EP*(ERK./ERK0_EP).^n_EP)/(1+(ERK/ERK0_EP).^n_EP)*PPAR;

function H=Hs(X,X0,lamda,n)
H=(1+lamda.*(X./X0).^n)/(1+(X./X0).^n);