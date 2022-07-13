
function ok=iden4ss(yt)
N=40;key=[5     5     2     4     4     5     3     3     4     4     5     4     5     4     4     5];
ssnt=runode(yt,N);
 if isequal(ssnt,key)
 ok=1
 else
 ok=0;
 end
end