function odk=idenboundin(index,y0,yt)
odk=0;
a=yt(index);
y1=y0;y1(index)=a*(1+0.1);ok1=iden4ss(y1);
y2=y0;y2(index)=a*(1-0.1);ok2=iden4ss(y2);
if (a>=y0(index)&&(~ok1&&ok2))||(a<y0(index)&&(ok1&&~ok2)) 
 odk=1;
end
end