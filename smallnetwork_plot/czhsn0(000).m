
global num;
num=4;
d1=1.05;
d2=0.95;
YY=[];
YJ=[];
N=40;
ii=1;
T=2000;
h=0.01;
gg=0;
nstep=T/h;
nbatch=1;
a=10;
m=10;
n=2;
d=0.3;
l=800;
%{
µ¥ÎÈÌ¬
y=[a	a	 a	a	d	d	d  d	3 	144,...      %1-10
    0.03	57	5 100	40	4	80	4	n	4,...     %11-20
    n	n    n	n	n	n	200	200	 1000 	1500,...  %21-30
    1500 1500 2000  3000 1000  4.3 4.3 0.01 1.5  0.1,... %31-40
    6000 6 2 2000 2];         %41-50
%}
%{
%2ÎÈÌ¬0918
y=[a	a	 a	a	d	d	d  d	m 	40,...      %1-10
    m	m	m  m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	800	800	 1000 	1500,...  %21-30
    800 800 800  3000 1000  4.3 20 0.01 1.5  m,... %31-40
    4000 2 2 2000 2];         %41-50
%}
%{
%µ¥ÎÈÌ¬
y=[a	a	 a	a	d	d	d  d	15 	30,...      %1-10
    0.03	15	15 15	15	15	15	4	n	4,...     %11-20
    n	n    n	n	n	n	200	200	 200 	200,...  %21-30
    200 200 200  200 200  4.3 1.5 0.01 1.5  0.2,... %31-40
    200 6 2 200 2];         %41-50
%}
%{
czh777
y=[a	a	 a	a	d	d	d  d	m 	80,...      %1-10
    m	m	m  m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	800	800	 800 	800,...  %21-30
    800 800 800  800 800  4.3 20 0.01 1.5  m,... %31-40
    l n m l 4];         %41-50
%}
%{
%´æÅÌ,½Ó½üoscillµÄË«ÎÈÌ¬1
y=[a  a	 a	a	d	d	d  d	m 	20,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 800 	l,...  %21-30
   l  l  l  1500 l  4 20 0.01 1.5  m,... %31-40
   1700 n m 2000 4];         %41-50
%}
%{
%´æÅÌ,½Ó½üoscillµÄË«ÎÈÌ¬2
y=[a  a	 a	a	d	d	d  d	m 	20,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  1.9 20 0.01 1.5  m,... %31-40
   l n m 1000 4];         %41-50
%}
%{
´æÅÌ,×î½Ó½üoscillµÄË«ÎÈÌ¬
y=[a  a	 a	a	d	d	d  d	m 	40,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  1.6 20 0.01 1.5  m,... %31-40
   l n m 800 4];         %41-50
%}
y=[a  a	 a	a	d	d	d  d	m 	80,...      %1-10
   m  m	 m  m	m	m	m	4	n	4,...     %11-20
   n  n  n	n	n	n	l	l	 l 	l,...  %21-30
   l  l  l  l l  1.6 20 0.01 1.5  m,... %31-40
   l n m l 4];         %41-50
%}
%A=randperm(2000);
A=[d1,d2];
B=[0:10:1000];
out=0;


for ii=1:N
x=randi(2500,num,nbatch);
ff=zeros(num,nbatch);
for j=1:nstep
     ff=Force000(nstep,x,y);
     x=x+h*ff;
     %{
       st=1/h;   
        if mod(j,st)==0
            for i=1:num
              Y(j/st,i,:)=x(i,:);
              TT(j/st)=j*h;
            end
        end
       %}
     
       
end

 YJ(:,ii,:)=round(x);
ii

%TT=TT';
%}

%{
%set(gca,'XTick',[0 3000 6000 9000 12000 15000]);
%plot(TT,Y(:,1,1),'r')
%legend('MEK')
plot(TT,Y(:,2,1),'b')
legend('ERK')
%plot(TT,Y(:,1,1),'c',TT,Y(:,2,1),'b',TT,Y(:,3,1),'g',TT,Y(:,4,1),'r')
%legend('MEK','ERK','C/EBP¦Á','PPAR¦Ã')
xlabel('h');ylabel('rel');
hold on
%}
end
YJ=reshape(YJ,num,[])
for g=15:num
 if length(unique(YJ(g,:)))>1
%if YJ(g,1)>300
    out=1;
     xlswrite('result2.xlsx',YJ)
% elseif length(unique(YJ(2,:)))>2
%    out=1;
%  xlswrite('result2.xlsx',YJ)
end
end
for g=1:num
 length(unique(YJ(g,:)))
end
%{
if out==1
    break
end
end
%}