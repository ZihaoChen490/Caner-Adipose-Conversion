
function ok=iden4ss(yt)
N=15;key=[5     5     2     4     4     5     3     3     4     4     5     4     5     4     4     5];
ssnt=runode(yt,N);
a=sum(ssnt==5);
 if a
 ok=1
 else
 ok=0
 end
end