%%Allan误差分析
DATA=importdata('MT_0360087A-001-000.txt');
N=length(DATA.data(:,1));
% for k=1:1:N
%     if abs(DATA3(k,1))>0.3
%         DATA3(k,1)=DATA3(k-1,1);
%     end
% end
Acc_X=mean(DATA.data(:,2));
Acc_Y=mean(DATA.data(:,3));
Acc_Z=mean(DATA.data(:,4));
Gro_X=mean(DATA.data(:,5));
Gro_Y=mean(DATA.data(:,6));
Gro_Z=mean(DATA.data(:,7));

y0=DATA.data(:,2)-Acc_X;
y1=DATA.data(:,3)-Acc_Y;
y2=DATA.data(:,4)-Acc_Z;
a1=DATA.data(:,5)-Gro_X;
a2=DATA.data(:,6)-Gro_Y;
a3=DATA.data(:,7)-Gro_Z;
[sigma1,tau1,Err1,R1]=avar(y0,0.01,'加速度计x轴',1);
[sigma2,tau2,Err2,R2]=avar(y1,0.01,'加速度计y轴',2);
[sigma3,tau3,Err3,R3]=avar(y2,0.01,'加速度计z轴',3);
[sigma4,tau4,Err4,R4]=avar(a1,0.01,'陀螺仪x轴',4);
[sigma5,tau5,Err5,R5]=avar(a2,0.01,'陀螺仪y轴',5);
[sigma6,tau6,Err6,R6]=avar(a3,0.01,'陀螺仪z轴',6);
