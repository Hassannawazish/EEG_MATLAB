frequency=250; 
time=1/frequency;
[s, h]= sload('B0201T.gdf'); 
c3=s(:,1);
c4=s(:,3);
w=size(c3);
events= size(h.EVENT.TYP, 1); 
for i=1:events
          if h.EVENT.TYP(i)== 32766
            a(i)=i;
          end
end
b=a>0;d=a(b);e=d(1,[2:end]);Totalruns=length(e);
disp('Total Number of runs are ');disp(Totalruns);
for i=1:events
          if h.EVENT.TYP(i)== 769
              f(i)=i;
          end
end
g=f>0;
hh=f(g);
TLtrails=length(hh);
disp('Total Number of Left class trails are ');disp(TLtrails);
j=hh+1;
CLposition=h.EVENT.POS(hh);
CLEposition=h.EVENT.POS(j);
for i=1:events
          if h.EVENT.TYP(i)== 770
              kk(i)=i;
          end
end
LL=kk>0;mm=kk(LL);TRtrails=length(mm);
disp('Total Number of Right class trails are');disp(TRtrails);
nn=mm+1;oo=nn<events;classrightpos=h.EVENT.POS(mm);
pp=nn(oo);qq=w;classrightendpos=h.EVENT.POS(pp);
for i=1:TRtrails
    if i==TRtrails
    C3R{i}=c3(classrightpos(i):qq(1));
    C4R{i}=c4(classrightpos(i):qq(1));
    C3L{i}=c3(CLposition(i):CLEposition(i)-1);
    C4L{i}=c4(CLposition(i):CLEposition(i)-1);
    else
    C3R{i}=c3(classrightpos(i):classrightendpos(i)-1);
    C4R{i}=c4(classrightpos(i):classrightendpos(i)-1);
    C3L{i}=c3(CLposition(i):CLEposition(i)-1);
    C4L{i}=c4(CLposition(i):CLEposition(i)-1);
    end
end
