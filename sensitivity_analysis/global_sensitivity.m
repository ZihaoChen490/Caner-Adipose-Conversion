global num nbatch;
num=16;nbatch=1;YJ=[];
N=40;
a=10;n=2;d=0.3;l=800;m=10;u=0.2;
y0=[a	a	 a	a	d	d	d  d	u	 24,...      %1-10
    m	m	m m	m	m	m	4	n	4,...     %11-20
    n	n    n	n	n	n	l	l	 1000 	l,...  %21-30
    l l l  l l  4.3 l 0.02 1.5  m,... %31-40
   3000 4 2 2000 n l l l l l,...                 %41-50
    a a a a a a a a a a,...                           %51-60
    a a d d d d d d d d,...                             %61-70
    d d d d m m m m u u,...                      %71-80
    15 m m m u m m m m m,...                  %81-90
    15 m m m m m m m u m,...                  %91-100
    15 m u u m m u m 120 15,...               %101-110                 
    m m n n n n n n n n,...                           %111-120
    n n n n n n n n n n,...                             %121-130
    n n n n 4 n n n n n,...                             %131-140
    n n n n n n n n n n,...                             %141-150800
    l,l,l,l,l,l,l,l,l,l,...         %151-160
    l,l,l,l,l,l,l,l,l,l,...         %161-170
    l,l,l,l,20,l,l,l,l,l,...         %171-180
    l,l,l,l,u,n,l,m,n];                                       %181-190
multi=[1.1 0.9];
se=[2,1].*size(y0);sen=ones(se);uzi=length(y0);
addpath('/home1/zhchen/program/czhprogram/')
%
function main
for lol=108:1:uzi
    lol
   y=y0;
   lgd1=multi(1)*y0(lol);
   y(lol)=lgd1; 
   runode(y,N,lol,1);
   lgd2=multi(2)*y0(lol);
   y(lol)=lgd2; 
   runode(y,N,lol,-1);
end 
end
 
function [m, n]=findbound(index,y0,array)
whether_boundin=idenboundin(index,y0,array(1),array(2))
if whether_boundin
 m=array(1);n=array(2);
 while abs(m-n)>=y0(index)*0.001 
   rw=linspace(m,n,10);cnt=0;ojbk=0;
        while ~ojbk&&cnt<9
            cnt=cnt+1
            ojbk=idenboundin(index,y0,rw(cnt),rw(cnt+1))
        end
 m=rw(cnt)
 n=rw(cnt+1)
end
else
    m=0;n=0;
end
end



function ssnt=runode(y,N,index,a)
T=4000;h=0.005;nstep=T/h;num=16;nbatch=1;
for ii=1:N
x=randi(3000,num+num*num,nbatch);ff=zeros(num+num*num,nbatch);
for j=1:nstep
 ff=cov_i(nstep,x,y); x=x+h*ff;     
end
  YJ(:,ii,:)=x;
end
  for g=1:num
 ssnt(g)=length(unique(round(YJ(g,:))));    
  end
  ssn=ssnt(1);
  cal_path5i;
  filename=strcat(num2str(index),num2str(a))
  save(filename,'ycell');
end





function ok=iden4ss(yt)
N=40;key=[4     4     2     4     4     4     3     3     4     4     4     4     4     3     3     4];
ssnt=runode(yt,N);
 if isequal(ssnt,key)
 ok=1
 else
 ok=0;
 end
end

function odk=idenboundin(index,y0,a,b)
    y1=y0;y1(index)=a;ok1=iden4ss(y1);
    y2=y0;y2(index)=b;ok2=iden4ss(y2);
if (ok1&&~ok2)||(~ok1&&ok2)
    odk=1;
else
    odk=0;
end
end

%{
function otk=idenbound(index,y,y0)
dy=0.001;odk1=iden4ss(y);
if y(index)>y0(index)
    y(index)=y(index)+y0(index)*dy;
else
    y(index)=y(index)-y0(index)*dy;
end
odk2=iden4ss(y);
    if ~odk2&&odk1
        otk=1;
    else
       otk=0; 
    end
end
%}