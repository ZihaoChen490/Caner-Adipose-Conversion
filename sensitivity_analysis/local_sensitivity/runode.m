function ssnt=runode(y,N,stable)
YJ=[];nbatch=1;T=2000;h=0.005;nstep=T/h;num=16;
for ii=1:N
    
x=randi(3000,num,nbatch); ff=zeros(num, nbatch);
if ii<6
x(1:num)=stable(1:num,ii);
end

for j=1:nstep
 ff=Force5i(nstep, x, y);       res=h.*ff;
 if norm(res(1:16),1)<1e-7
 break
 end
 x=x+res;
end
 YJ(:,ii,:)=x;
 for g=1:num
 ssnt(g)=length(unique(round(YJ(g,:))));    
 end
 if sum(ssnt==5)
     break
 end
end
YJ=reshape(YJ,num,[]);
end