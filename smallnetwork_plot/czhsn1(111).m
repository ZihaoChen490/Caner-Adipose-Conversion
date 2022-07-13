
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
%{
y=[ 4 0.8 0.2 0.1 0.02 1 0.01 0.01 2 900,...  %1-10
    0.2 40 0.8 100 40 4 100 2 2 4,...         %11-20
    2 2 2 2 2 2 2000 2000 800 600,...         %21-30
    600 100 1200 800 800  2 2 2 2   ];  %31-39
%}
%{
y=[ 1.9, 0.014, 0.011, 5.9e-4, 0.085, 0.16, 5.3e-4, 1.6e-3, 0.32, 144.0,...
    0.032, 57.0, 0.38, 433.0, 57.0, 1.9, 47.0, 0.95, 0.95, 0.07,...
    2.8, 0.32, 2.8, 0.11, 8.5, 0.95, 111.0, 322.0, 133.0, 32.0,...
    32.0, 16.0, 199.0, 133.0, 1100, 0.035, 0.32, 0.035, 0.32];
%} 
%{
 y=[ 4, 1, 1, 1, 0.01, 0.01, 0.01, 0.01, 80, 200,...
    2, 50, 0.8, 50, 50.0, 2, 200, 2, 2, 2,...
    3, 2, 3, 2, 2, 2, 100, 100, 800, 1000,...
    1000, 100, 100, 200, 1100, 100, 0.5, 0.5, 10];
%}
%{
%0812
y=[1.9	1.4	 1	1	0.01	0.16	0.04  0.04	3	144,...
    0.032	57	5 100	40	4	80	4	2	4,...
    2	2    4	2	2	2	100	100	 1000 	1500,...
    1500	1540	 2000   3000	1000	4.3	 1	0.8	1.5  0.1,...
    6000 6 2 2000 2];
%}
y=[1.4	1.4	 1.4	1.4 	0.16	0.16	0.16  0.16	3	144,...
    0.032	57	5 100	40	4	80	4	2	4,...
    2	2    4	2	2	2	100	100	 1000 	1500,...
    1500	1540	 2000   3000	1000	4.3	 1	0.05	1.5  0.1,...
    6000 6 2 2000 2];
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
    xi(1,:)=randperm(2500,nbatch);
   % xi(1,:)=randperm(2500,nbatch);
    xi(2,:)=0;
%xi(1,:)=B(randperm(numel(B),nbatch));
xi(3,:)=0;
%xi(2,:)=B(randperm(numel(B),nbatch));
xi(4,:)=0;
x=xi;
ff=zeros(num,nbatch);
for j=1:nstep
     ff=Force1(nstep,x,y);
       for i=1:num
         xnew(i,:)=x(i,:)+h.*ff(i,:);
         x(i,:)=xnew(i,:);
% length(find(xnew<0))

      end
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

for i=1:num
 YJ(i,ii,:)=round(x(i,:));
end


%TT=TT';
%}

ii=ii+1
%{
%set(gca,'XTick',[0 3000 6000 9000 12000 15000]);
plot(TT,Y(:,1,1),'r')
legend('MEK')
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