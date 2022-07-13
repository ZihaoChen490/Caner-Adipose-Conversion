%
addpath(genpath('/home1/zhchen/program/czhprogram/czhsn/'));
num=4;nbatch=1;a=10;
n=2;d=0.3;l=800;m=10;u=0.2;N=50;h=0.003;T=2000;
nstep=T/h;st=0.1/h;U={};
RNG=100;
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  0.1 20 0.01 1.5  m,... %31-40
   l n m l 4];         %41-50
%}
stepx=0.06;
stepy=0.7;
tes=0
while tes<=RNG
    tes=tes+1
for ii=1:N
    ii
x=randi(3000,num+num*num,nbatch);
ff=zeros(num+num*num, nbatch);
for j=1:nstep
     ff=cov_snlc0(nstep,x,y);
     x=x+h*ff;
%     if mod(j,st)==0
 %       for i=1:num
  %      Y{ii}(j/st,i,:)=x(i,:);  
   %      TT(ii,j/st)=j*h;
    %    end
     %  Y{ii}(j/st,num+1:num+num,:)=diag(reshape(x(num+1:num+num*num,:),num,num));
    % end
end
YJ(:,ii,:)=x;
end
YJ
ssnt=[];
for g=1:num
 ssnt(g)=length(unique(round(YJ(g,:))))
end
ssn=ssnt(3);
d1=3;d2=3;clen=4000;p=zeros(clen);
weight=zeros(1,ssn);x_ss=zeros(num+num*num,ssn);
cov_ss=zeros(ssn,num,num);sig_ss=zeros(num,ssn);
at=0.2;a2=0.1;temp=1;P1=[];
%at=20000;
for ig=1:N
        if ~ismember(round(YJ(3,ig)),round(x_ss(3,:)))
         x_ss(:,temp)=YJ(:,ig);
       cov_ss(temp,:,:) = reshape(YJ(num+1:end,ig), num, num);
       sig_ss(:,temp)=abs(diag(squeeze(cov_ss(temp,:,:))));
       temp=temp+1;
        end
        weight(1,find(x_ss(3,:)==YJ(3,ig)))= weight(1,find(x_ss(3,:)==YJ(3,ig)))+1;
end
%wei=weight./sum(weight);
wei=ones(1,length(weight));
for j=1:4000
    P1(j,1:num,:)=real(exp(-power(j.*stepy-x_ss(1:num,:),2)./2./sig_ss./at)./sqrt(2.*pi.*sig_ss.*at));
end
%}

Pt=sum(P1,1);Pd=P1./Pt;

  for i=1:clen
  for k=1:temp-1
  p(i)=p(i)+wei(1,k).*Pd(i,d1,k);
if p(i)<=1e-75    p(i)=1e-75; end
 end
 end
U{tes}=-log(p);
dt=sum(1*(isnan(U{tes}(1,:))));
if dt
    y(36)=y(36);
    tes=tes-1
  %  sig=max(U{tes-1}(:,1))-min(U{tes-1}(:,1));
  %  U{tes}=normrnd(U{tes-1},stepx*sig/400);
else
xlb(tes)=y(36);
y(36)=y(36)+stepx
end
end
save U
%}