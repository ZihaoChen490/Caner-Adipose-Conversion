%
YJ=[];Y=[];TT=[];num=4;nbatch=1;a=10;
n=2;d=0.3;l=800;m=10;u=0.2;N=40;h=0.005;T=2000;
nstep=T/h;st=0.1/h;
y=[a  a	 a	a  d  d	 d  d  m 	80,...      %1-10
   m  m	 m  m  m  m	 m	4  n	4,...     %11-20
   n  n  n	n  n  n	 l	l  l 	l,...  %21-30
   l  l  l  l  l  4.6 20 0.01 0.5  m,... %31-40
   l n m l 4];         %41-50
%{
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  0.1 20 0.01 2.7115  m,... %31-40
   l n m l 4];         %41-50
%}
%{
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  1.6084 20 0.01 2.7115  m,... %31-40
   l n m l 4];         %41-50
%}
for ii=1:N
x=randi(4000,num+num*num,nbatch);
ff=zeros(num+num*num, nbatch);
for j=1:nstep
     ff=cov_snlc0(nstep,x,y);
     x=x+h*ff;
           if mod(j,st)==0
        for i=1:num
         Y(ii,j/st,i,:)=x(i,:);
         TT(ii,j/st)=j*h;
        end
       Y(ii,j/st,num+1:num+num,:)=diag(reshape(x(num+1:num+num*num,:),num,num));
      end
 %         Y(ii,nstep,1:num,:)=x(1:num,:);
 %         Y(ii,nstep,num+1:num+num,:)=diag(reshape(x(num+1:num+num*num,:),num,num));
 %         TT(ii,nstep)=j*h;
end
YJ(:,ii,:)=x;
ii

end
%}
YJ=reshape(YJ,num+num*num,[]);
ssnt=[];
for g=1:num
 ssnt(g)=length(unique(round(YJ(g,:))))
end

%{
figure(1);
plot(TT,Y(:,5,1),'r',TT,Y(:,6,1),'b')
legend('MEK','ERK')
%plot(TT,Y(:,1,1),'c',TT,Y(:,2,1),'b',TT,Y(:,3,1),'g',TT,Y(:,4,4),'r')
%legend('MEK','ERK','C/EBP¦Á','PPAR¦Ã')
%xlabel('h');ylabel('rel');
%}
%{
for g=1:num
 ssn=length(unique(round(YJ(g,:))))
 end
%}
for g=1:num
 ssn=length(unique(round(YJ(g,:))))
 end
%
