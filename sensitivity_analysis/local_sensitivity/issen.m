clc
clear
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
multi=[0.01 3];se=[2,1].*size(y0);isen=zeros(se);uzi=length(y0);
addpath(genpath('/home1/zhchen/program/czhprogram/local_sensitivity/'))
load('sent.mat')
N=10;
load('stable.mat');

%  y=y0;index=79;
%  y(index)=y0(index)*(1-1.01);
%  ssnt=runode(y,N,stable)
for lol=1:1:88
lol
for k0=1:10
    k0
    y=y0;index=lol;
    y(index)=y0(index)*(1-k0/10);%0.62
  %odk=idenboundin(index,y0,y);
    ssnt=runode(y,N,stable);
    if sum(ssnt==5)==0 
        for k=1:1:10
            k
            y=y0;index=lol;
            y(index)=y0(index)*(1-(k0-1)/10-k/100);%0.62
  %odk=idenboundin(index,y0,y);
            ssnt=runode(y,N,stable);
            if sum(ssnt==5)==0 || k==10
                for kk=1:2:10
                    kk
                    y(index)=y0(index)*(1-(k0-1)/10-(k-1)/100-kk/1000);
                    ssnt=runode(y,N,stable);
                    if sum(ssnt==5)==0
                        break
                    end
                end
                break
            end
        end
        break
    end
end
if k0<10
    delta=(k0-1)/10*100+(k-1)/100*100+(kk-1)/1000*100;
    y(index)=y0(index)*(1-delta/100);
    ssnt=runode(y,N,stable);
    if sum(ssnt==5)==0
      isen(1,index)=(k0-1)/10*100+(k-1)/100*100+(kk-2)/1000*100;
    else
       isen(1,index)=(k0-1)/10*100+(k-1)/100*100+(kk-1)/1000*100;
    end
else
    isen(1,index)=100;
end

end

  %while odk==0
  % y(index)=y(index)+y(index)*0.2
  % odk=idenboundin(index,y0,y);
  %end
  % isen(1,index)=y(index);
  % y=y0;
  
  % odk=y(index)*multi(2)
  %isen(1,index)=idenboundin(index,y0,y);
  %  while isen(1,index)==0
%y(index)=y(index)-y(index)*0.2
 %odk=idenboundin(index,y0,y);
  %  end
  %  isen(2,index)=y(index);

  %save('isen','isen')
%end 


