 
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