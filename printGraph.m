function printGraph(T,Y,m,b,p,a,h,d,name)




hand=figure;

leg=[];

if m==true
    plot(T,Y(:,1),'m');
    leg=[leg,{'M'}];
    hold on
end
if b==true
    plot(T,Y(:,2),'b');
        leg=[leg,{'B'}];

    hold on
end
if p==true
    plot(T,Y(:,3),'k');
        leg=[leg,{'P'}];

    hold on
end
if a==true
    plot(T,Y(:,4),'Color',[.5977,.7969,0]);
        leg=[leg,{'A'}];

    hold on
end
if h==true
    plot(T,Y(:,5),'g');
        leg=[leg,{'H'}];

    hold on
end
if d==true
    plot(T,Y(:,6),'r');
        leg=[leg,{'D'}];

    hold on
end
legend(leg);

hold off

print(hand,'-djpeg',name);
end