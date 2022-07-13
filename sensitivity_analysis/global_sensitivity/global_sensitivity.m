global num nbatch;
num=16;nbatch=1;YJ=[];
N=2000;
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

%addpath(genpath('/home1/zhchen/program/czhprogram/global_sensitivity'))
%

for lol=1:1:uzi
    lol
   y=y0;
   lgd1=multi(1)*y0(lol);
   y(lol)=lgd1; 
   runode(y,N,lol,1);
   lgd2=multi(2)*y0(lol);
   y(lol)=lgd2; 
   runode(y,N,lol,-1);
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