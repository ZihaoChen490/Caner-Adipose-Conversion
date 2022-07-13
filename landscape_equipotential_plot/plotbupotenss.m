%load('U');
%load('xlb');
h1=openfig('bu1.fig','reuse');
%open('bu2.fig');
%open('bu3.fig');
%open('bu4.fig');
lh = findall(h1, 'type', 'line');
xc = get(lh, 'xdata');  % extract x-coordinate value to a cell array from figure
yc = get(lh, 'ydata');  % extract y-coordinate value to a cell array from figure
%
x1=[];x2=[];
t=size(xc,1);
try
for i=1:t(1)
 x1(i,:)=xc{i,1};
end
catch
end
t2=size(x1,1);
 for i=t2(1)+2:t(1)
    x2(i,:)=xc{i,1} ;
 end
 
 y1=[];y2=[];
u=size(yc,1);
try
for i=1:u(1)
 y1(i,:)=yc{i,1};
end
catch
end
 u2=size(y1,1);
 for i=u2(1)+2:u(1)
    y2(i,:)=yc{i,1} ;
 end
 close(h1);
 %}
%
 figure(1)
line(x2(4320:8000,2),y2(4320:8000,2),'linestyle',':','LineWidth',1,'color','b')
%line(x2(6770:8000,2),y2(6770:8000,2),'linestyle',':','LineWidth',1,'color','b')
%line(x2(830:1000,2),y2(830:1000,2),'linestyle',':','LineWidth',1,'color','b')
%line(x2(1150:2000,2),y2(1150:2000,2),'linestyle',':','LineWidth',1,'color','b')
line(x1,y1,'linestyle',':','LineWidth',0.7,'color','b')
hold on
Up=[];
for jk=1:length(U)
    jk
   Up(jk,:)= U{jk}(:,1);
end
 %mesh([1:1:1500],[0.1:0.2:0.1+(20-1)*0.2],Up)
 contour([0.1:0.2:0.1+(20-1)*0.2],[1:1:1500],Up')
xlim([0,6])
ylim([0,1500])
%}
x_wen=[x2(4320:8000,2),y2(4320:8000,2)];
y_max=[7,1000];y_min=[0,0];
 step=(y_max-y_min)./size(x_wen,1);
[a1,a2]=meshgrid(y_min(1):step(1):y_max(1),y_min(2):step(2):y_max(2));
[s1,s2]=size(a1);
P=zeros(s1,s2);z=zeros(s1,s2);
n=1;t=1;

%{
chwen=[x_wen(1:20:2950,:) ;x_wen(2951:4:3193,:); x_wen(3193:1:3493,:)];
  for i=1:s1-2
   ch=[];
   if x_wen(i,2)>30
       %{
       o1=1;
       o2=1;
         if ge(x_wen(i,1),x_wen(i+1,1))
           o1=-1;
         end
          if ge(x_wen(i,2),x_wen(i+1,2))
             o2=-1;
          end
       %}
         ch(1,:)=linspace(x_wen(i,1),x_wen(i+1,1),60);
         ch(2,:)=linspace(x_wen(i,2),x_wen(i+1,2),60);
         chwen=[chwen;ch'];      
   end 
  end
%  
  x=[];y=[];z=[];xx=[];yy=[];zz=[];
   %     sig=reshape(sig,m,m)';
   r=[];r1=[];
sigma1 = [0.01 0.5;0.5 500];
N=50;

     for i=1:10:size(chwen)-1
         i
        for j=1:10:size(chwen)-1
            mu1 = [chwen(i,1) chwen(j,2)];
            r(:,:,t)=mvnrnd(mu1,sigma1,N);
        %    r1=[r1 mvnrnd(mu1,sigma1,N)];
           t=t+1;
        end
     end
     g1=0.1;
     g2=2;
 p=zeros(size(0:g1:7,2),size(0:g2:1000,2));
  
  for i=1:1:size(p,1)
      i
      for j=1:1:size(p,2)
           for k=1:t-1
               for l=1:N
               if (i-1)*g1<=r(l,1,k)&&r(l,1,k)<i*g1&&(j-1)*g2<=r(l,2,k)&&r(l,2,k)<j*g2
                  p(i,j)=p(i,j)+1; 
               end
               end
           end
      end
  end
  %sum(p)
  p=p/sum(sum(p));
  pss=-log(p);
 %    z=real(z);
 %    N=1000;  
 %    [xx yy]=meshgrid(linspace(min(x),max(x),N),linspace(min(y),max(y),N));
 %    zz=griddata(x,y,z,xx,yy);%根据原来的数据，插值为矩阵数据
     figure
line(x2(4320:8000,2),y2(4320:8000,2),'linestyle',':','LineWidth',1,'color','b')
hold on
%     imagesc([0:g1:7],[0:g2:1000],pss'); %用这句画能bai量分布图
 %    contour([0:g1:7],[0:g2:1000],pss');%用这句画能量分布的等值线图
     %{
        z=real(z);
[max_a,index]=max(z,[],1);
for i=1:size(lj,2)
[m1(i,:),n1(i,:)]=find(z==lj(i));
end
figure;
plot(m1,n1);
%}
  %}  
% subplot(4,3,1)
%P=P/sum(sum(P));
%figure(2)
%surf(a1,a2,-log(max(z,10^-100)));
%shading interp
%set(gca,'FontSize',12);
%xlabel('PC1','FontSize',15)
%ylabel('PC2','FontSize',15)
%zlabel('U','FontSize',15)

%{
h1=openfig('bu1.fig','reuse');
h2=openfig('bu2.fig','reuse');
h3=openfig('bu3.fig','reuse');
h4=openfig('bu4.fig','reuse');
%}
%{
figure
s1=subplot(221);
copyobj(get(get(h1,'Children'),'Children'),s1)
set(gca,'FontSize',16);
xlabel('TGF','FontSize',16),ylabel('MEK','FontSize',16);
title('A','FontSize',16);
xlim([0,6])
ylim([0,1100])
close(h1);

s2=subplot(222);
copyobj(get(get(h2,'Children'),'Children'),s2)
set(gca,'FontSize',16);
xlabel('TGF','FontSize',16),ylabel('ERK','FontSize',16);
title('B','FontSize',16);
xlim([0,6])
ylim([0,1200])
close(h2);

s3=subplot(223);
copyobj(get(get(h3,'Children'),'Children'),s3)
set(gca,'FontSize',16);
xlabel('TGF','FontSize',16),ylabel('CEBPa','FontSize',16);
title('C','FontSize',16);
xlim([0,6])
ylim([0,100])
close(h3);

s4=subplot(224);
copyobj(get(get(h4,'Children'),'Children'),s4)
set(gca,'FontSize',16);
xlabel('TGF','FontSize',16),ylabel('PPARg','FontSize',16);
title('D','FontSize',16);
xlim([0,6])
ylim([30,100])
close(h4);
%}