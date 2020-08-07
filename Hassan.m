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
for i=1:TRtrails
    ac3CL{i}=bandpass(C3L{i},[8 12],frequency);            %alpha and beta signals of all trails for c3 and c4
    ac3CR{i}=bandpass(C3R{i},[8 12],frequency);
    ac4CL{i}=bandpass(C4L{i},[8 12],frequency);
    ac4CR{i}=bandpass(C4R{i},[8 12],frequency);
    bc3CL{i}=bandpass(C3L{i},[14 30],frequency);
    bc3CR{i}=bandpass(C3R{i},[14 30],frequency);
    bc4CL{i}=bandpass(C4L{i},[14 30],frequency);
    b4CR{i}=bandpass(C4R{i},[14 30],frequency);
end
 for i=1:TRtrails                                         %Average power of all trails
APAc3CL(i)=(1/length(ac3CL{1,i}))*sum(ac3CL{1,i}.^2);
APAc3CR(i)=(1/length(ac3CR{1,i}))*sum(ac3CR{1,i}.^2);
AVAc4CL(i)=(1/length(ac4CL{1,i}))*sum(ac4CL{1,i}.^2);
AVAc4CR(i)=(1/length(ac4CR{1,i}))*sum(ac4CR{1,i}.^2);
AVBc3CL(i)=(1/length(bc3CL{1,i}))*sum(bc3CL{1,i}.^2);
AVBc3CR(i)=(1/length(bc3CR{1,i}))*sum(bc3CR{1,i}.^2);
AVBc4CL(i)=(1/length(bc4CL{1,i}))*sum(bc4CL{1,i}.^2);
AVBc4CR(i)=(1/length(b4CR{1,i}))*sum(b4CR{1,i}.^2);
 end
  for i=1:TRtrails                                        %K and R value calculations
      k1=c3(CLposition(1)-1);
      RALc3(i)=(1/k1+1)*(APAc3CL(i));
      k2=c3(classrightpos(i)-1);
      RARc3(i)=(1/k2+1)*(APAc3CR(i)); 
      k3=c4(CLposition(i)-1);
      RALc4(i)=(1/k3+1)*(AVAc4CL(i));
      k4=c4(classrightpos(i)-1);
      RARc4(i)=(1/k4+1)*(AVAc4CR(i));     
      k5=c3(CLposition(i)-1);
      RBLc3(i)=(1/k5+1)*(AVBc3CL(i));
      k6=c3(classrightpos(i)-1);
      RBRc3(i)=(1/k6+1)*(AVBc3CR(i));
      k8=c4(CLposition(i)-1);
      RBLc4(i)=(1/k8+1)*(AVBc4CL(i));
      k8=c4(classrightpos(i)-1);
      RBRc4(i)=(1/k6+1)*(AVBc4CR(i));
  end
   for i=1:TRtrails
     ERA_c3ACL(i)=((APAc3CL(i)-RALc3(i))/RALc3(i))*100;
     ERA_c3ACR(i)=((APAc3CR(i)-RARc3(i))/RARc3(i))*100;
     ERA_c4ACL(i)=((AVAc4CL(i)-RALc4(i))/RALc4(i))*100;
     ERA_c4ACR(i)=((AVAc4CR(i)-RARc4(i))/RARc4(i))*100;
     ERA_c3BCL(i)=((AVBc3CL(i)-RBLc3(i))/RBLc3(i))*100;
     ERA_c3BCR(i)=((AVBc3CR(i)-RBRc3(i))/RBRc3(i))*100;
     ERA_c4BCL(i)=((AVBc4CL(i)-RBLc4(i))/RBLc4(i))*100;
     ERA_c4BCR(i)=((AVBc4CR(i)-RBRc4(i))/RBRc4(i))*100;
   end
  for i=1:TRtrails
  time1(i)=CLposition(i).*time;
  time2(i)=classrightpos(i).*time;
  end
figure(1)
plot(APAc3CL,'k.-');xlabel('Number of trails');ylabel('Average Power');title('AlphaClassLefttrails for C3');
figure(2)
plot(APAc3CR,'k.-');xlabel('Number of trails');ylabel('Average Power');title('AlphaClassRighttrails for C3');
figure(3)
plot(AVAc4CL,'k.-');xlabel('Number of trails');ylabel('Average Power');title('AlphaClassLefttrails for C4');
figure(4)
plot(AVAc4CR,'k.-');xlabel('Number of trails');ylabel('Average Power');title('AlphaClassRighttrails for C4');
figure(5)
plot(AVBc3CL,'r.-');xlabel('Number of trails');ylabel('Average Power');title('BetaClassLefttrails for C3');
figure(6)
plot(AVBc3CR,'r.-');xlabel('Number of trails');ylabel('Average Power');title('BetaClassRighttrails for C3');
figure(7)
plot(AVBc4CL,'r.-');xlabel('Number of trails');ylabel('Average Power');title('BetaClassLefttrails for C4');
figure(8)
plot(AVBc4CR,'r.-');xlabel('Number of trails');ylabel('Average Power');title('BetaClassRighttrails for C4');
% figure(9)
% plot(time1,ERA_c4ACL,'k.-');xlabel('Time');ylabel('ERS/ERA');title('AlphaClassLefttrails for C3');hold on
% axis([0 time1(ERA_c4ACL) -1000 1000]);
% plot(time1,zeros(size(time1)),':r') %+ use krna hai