function dx = cov_snlc0(t,x,y)
global num;
num=4;
D=1.4;
nbatch=1;
%{
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  1.6 20 0.01 1.5  m,... %31-40
   l n m l 4];         %41-50
%}

%%lead in the parameters

g_MEK=y(1);g_ERK=y(2);g_CEBP=y(3);g_PPAR=y(4);k_MEK=y(5);k_ERK=y(6);k_CEBP=y(7);k_PPAR=y(8);lambda_EM=y(9);lambda_ME=y(10);
lambda_EE=y(11);lambda_MC=y(12);lambda_PC=y(13);lambda_EC=y(14);lambda_MP=y(15);lambda_CP=y(16);lambda_EP=y(17);n_EM=y(18);n_ME=y(19);n_EE=y(20);
n_MC=y(21);n_PC=y(22);n_EC=y(23); n_MP=y(24);n_CP=y(25);n_EP=y(26);MEK_MC=y(27);MEK_MP=y(28);MEK0_ME=y(29);ERK0_EC=y(30);
ERK0_EP=y(31);CEBP0_CP=y(32);PPAR_PC=y(33);ERK0_EM=y(34);ERK0_EE=y(35);TGF=y(36);rkip=y(37);MEKi=y(38);Rosi=y(39);lambda_EEi=y(40);
ERK0_EEi=y(41);n_EEi=y(42);lambda_MM=y(43);MEK0_MM=y(44);n_MM=y(45);
%%lead in the parameters

MEK=x(1,:);ERK=x(2,:);CEBP=x(3,:);PPAR=x(4,:);

dx(1,:)=g_MEK.*TGF.*Hs(MEK,MEK0_MM,lambda_MM,n_MM)-k_MEK.*MEK.*rkip.*MEKi.*Hs(ERK,ERK0_EM,lambda_EM,n_EM);
dx(2,:)=g_ERK.*Hs(MEK,MEK0_ME,lambda_ME,n_ME).*Hs(ERK,ERK0_EE,lambda_EE,n_EE)-k_ERK.*ERK.*Rosi.*Hs(ERK,ERK0_EEi,lambda_EEi,n_EEi);
dx(3,:)=g_CEBP.*Rosi.*Hs(MEK,MEK_MC,lambda_MC,n_MC).*Hs(PPAR,PPAR_PC,lambda_PC,n_PC)-k_CEBP.*Hs(ERK,ERK0_EC,lambda_EC,n_EC).*CEBP.*TGF;
dx(4,:)=g_PPAR.*Rosi.*Hs(MEK,MEK_MP,lambda_MP,n_MP).*Hs(CEBP,CEBP0_CP,lambda_CP,n_CP)-k_PPAR.*Hs(ERK,ERK0_EP,lambda_EP,n_EP).*PPAR;

%jacobian matrix
A(1,1,:)=g_MEK.*TGF.*hs(MEK,MEK0_MM,lambda_MM,n_MM)-k_MEK.*rkip.*MEKi.*Hs(ERK,ERK0_EM,lambda_EM,n_EM);
A(1,2,:)=-k_MEK.*MEK.*rkip.*MEKi.*hs(ERK,ERK0_EM,lambda_EM,n_EM);
A(2,1,:)=g_ERK.*hs(MEK,MEK0_ME,lambda_ME,n_ME).*Hs(ERK,ERK0_EE,lambda_EE,n_EE);
A(2,2,:)=g_ERK.*Hs(MEK,MEK0_ME,lambda_ME,n_ME).*hs(ERK,ERK0_EE,lambda_EE,n_EE)-k_ERK.*ERK.*Rosi.*hs(ERK,ERK0_EEi,lambda_EEi,n_EEi)-k_ERK.*Rosi.*Hs(ERK,ERK0_EEi,lambda_EEi,n_EEi);
A(3,1,:)=g_CEBP.*Rosi.*hs(MEK,MEK_MC,lambda_MC,n_MC).*Hs(PPAR,PPAR_PC,lambda_PC,n_PC);
A(3,2,:)=-k_CEBP.*hs(ERK,ERK0_EC,lambda_EC,n_EC).*CEBP.*TGF;
A(3,3,:)=-k_CEBP.*Hs(ERK,ERK0_EC,lambda_EC,n_EC).*TGF;
A(3,4,:)=g_CEBP.*Rosi.*Hs(MEK,MEK_MC,lambda_MC,n_MC).*hs(PPAR,PPAR_PC,lambda_PC,n_PC);
A(4,1,:)=g_PPAR.*Rosi.*hs(MEK,MEK_MP,lambda_MP,n_MP).*Hs(CEBP,CEBP0_CP,lambda_CP,n_CP);
A(4,2,:)=-k_PPAR.*hs(ERK,ERK0_EP,lambda_EP,n_EP).*PPAR;
A(4,3,:)=g_PPAR.*Rosi.*Hs(MEK,MEK_MP,lambda_MP,n_MP).*hs(CEBP,CEBP0_CP,lambda_CP,n_CP);
A(4,4,:)=-k_PPAR.*Hs(ERK,ERK0_EP,lambda_EP,n_EP);

% variance
x_sig = reshape(x(num+1:end), num, num);
dx = [dx(:); reshape(x_sig * A' + A * x_sig + 2 * D* eye(num), num*num, nbatch)];



function H=Hs(X,X0,lambda,n)
H=(1+lambda.*(X./X0).^n)./(1+(X./X0).^n);

function h=hs(X,X0,lambda,n)
h=(lambda.*n.*(X./X0).^(n - 1))./(X0.*((X./X0).^n + 1)) - (n.*(lambda.*(X./X0).^n + 1).*(X./X0).^(n - 1))./(X0.*((X./X0).^n + 1).^2);
