function odk=idenboundin(index,y0,a,b)
    y1=y0;y1(index)=a;ok1=iden4ss(y1);
    y2=y0;y2(index)=b;ok2=iden4ss(y2);
if (ok1&&~ok2)||(~ok1&&ok2)
    odk=1;
else
    odk=0;
end
end