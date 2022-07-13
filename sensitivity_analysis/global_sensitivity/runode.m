function ssnt=runode(y,N,index,a)
T=4000;h=0.005;nstep=T/h;num=16;nbatch=1;
for ii=1:N
x=randi(3000,num+num*num,nbatch);ff=zeros(num+num*num,nbatch);
for j=1:nstep
 ff=cov_i(nstep,x,y);     
           res=h*ff; 
 if norm(res(1:16),1)<1e-7
              j
              break
 end
          
 x=x+res; 
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

