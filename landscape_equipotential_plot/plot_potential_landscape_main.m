%
YJ=[];Y=[];TT=[];num=4;nbatch=1;a=10;xlb=[];U={};
n=2;d=0.3;l=800;m=10;u=0.2;N=15;h=0.005;T=2000;
nstep=T/h;st=0.1/h;
RNG=30;
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  0.1 20 0.01 1.5  m,... %31-40
   l n m l 4];         %41-50
%}
for tes=1:RNG
    
for ii=1:N
    ii
x=randi(3000,num+num*num,nbatch);
ff=zeros(num+num*num, nbatch);
for j=1:nstep
     ff=cov_snlc0(nstep,x,y);
     x=x+h*ff;
     if mod(j,st)==0
        for i=1:num
         Y{ii}(j/st,i,:)=x(i,:);  
         TT(ii,j/st)=j*h;
        end
       Y{ii}(j/st,num+1:num+num,:)=diag(reshape(x(num+1:num+num*num,:),num,num));
     end
end
YJ(:,ii,:)=x;
end
ssnt=[];
for g=1:num
 ssnt(g)=length(unique(round(YJ(g,:))))
end
ssn=max(ssnt);
d1=1;d2=2;clen=1500;p=zeros(clen);
weight=zeros(1,ssn);x_ss=zeros(num+num*num,ssn);
cov_ss=zeros(ssn,num,num);sig_ss=zeros(num,ssn);
a1=600;a2=0.1;temp=1;P1=[];
for ig=1:N
        if ~ismember(round(YJ(1,ig)),round(x_ss(1,:)))
         x_ss(:,temp)=YJ(:,ig);
       cov_ss(temp,:,:) = reshape(YJ(num+1:end,ig), num, num);
       sig_ss(:,temp)=diag(squeeze(cov_ss(temp,:,:)));
       temp=temp+1;
        end
        weight(1,find(x_ss(1,:)==YJ(1,ig)))= weight(1,find(x_ss(1,:)==YJ(1,ig)))+1;
end
wei=weight./sum(weight);
for j=1:1500
    P1(j,1:num,:)=exp(-power(j*1-x_ss(1:num,:),2)/2./sig_ss/a)./sqrt(2*pi.*sig_ss*a);
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
xlb(tes)=y(36);
y(36)=y(36)+0.2
end
%}