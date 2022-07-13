
global num;
num=4;
d1=1.05;
d2=0.95;
YY=[];
YJ=[];
N=40;
ii=1;
T=2000;
nbatch=1;
h=0.005;
a=10;
n=2;
d=0.3;
l=800;
m=10;
u=0.2;
nstep=T/h;
%{
Oscill1
y=[a	a	 a	a	d	d	d  d	m 	80,...      %1-10
    m	m	m  m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	800	800	 800 	800,...  %21-30
    800 800 800  800 800  4.3 20 0.01 1.5  m,... %31-40
    l n m l 4];         %41-50
%}
y=[a	a	 a	a	d	d	d  d	m 	80,...      %1-10
    m	m	m  m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	800	800	 800 	800,...  %21-30
    800 800 800  800 800  4.3 20 0.01 1.5  m,... %31-40
    l n m l 4];         %41-50
%{
    Oscill2
    y=[a	a	 a	a	d	d	d  d	m 	50,...      %1-10
    m	m	m  m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	800	800	 800 	800,...  %21-30
    800 800 800  800 800  4.3 20 0.01 1.5  m,... %31-40
    l n m l n];         %41-50
%}
%A=randperm(2000);
A=[d1,d2];
B=[0:10:1000];
out=0;
%{
for n=1:300
    YJ=[];
n
ii=1;
for l=1:num
%y(39)=y(39)+n*0.01;
y(l)=y(l)*A(ceil(rand*2))^n;
%y(29)=y(29)*A(ceil(rand*2))^n;
%y(38)=y(38)*A(ceil(rand*2))^n;
%y(35)=y(35)*A(ceil(rand*2))^n;
%y(34)=y(34)*A(ceil(rand*2))^n;
end
%}

while ii<=N
    xi=zeros(num,nbatch);
    xi(1,:)=randperm(3000,nbatch);
   % xi(1,:)=randperm(2500,nbatch);
    xi(2,:)=0;
%xi(1,:)=B(randperm(numel(B),nbatch));
xi(3,:)=0;
%xi(2,:)=B(randperm(numel(B),nbatch));
xi(4,:)=0;
x=xi;
ff=zeros(num,nbatch);
for j=1:nstep
     ff=Force777(nstep,x,y);
       for i=1:num
         xnew(i,:)=x(i,:)+h.*ff(i,:);
         x(i,:)=xnew(i,:);
% length(find(xnew<0))

      end
     %
       st=1/h;   
        if mod(j,st)==0
            for i=1:num
              Y(j/st,i,:)=x(i,:);
              TT(j/st)=j*h;
            end
        end
       %}
     
       
end

for i=1:num
 YJ(i,ii,:)=round(x(i,:));
end


%TT=TT';
%}

ii=ii+1
%
%set(gca,'XTick',[0 3000 6000 9000 12000 15000]);
plot(TT,Y(:,1,1),'r',TT,Y(:,2,1),'b')
legend('MEK','ERK')
%plot(TT,Y(:,1,1),'c',TT,Y(:,2,1),'b',TT,Y(:,3,1),'g',TT,Y(:,4,1),'r')
%legend('MEK','ERK','C/EBP¦Á','PPAR¦Ã')
xlabel('h');ylabel('rel');
%}
end
YJ=reshape(YJ,num,[])
for g=1:num
 if length(unique(YJ(3,:)))>2
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