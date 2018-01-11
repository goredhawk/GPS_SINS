%计算磁力计获得初始姿态角，返回值都应该是弧度
function [roll , pitch , yaw] = getATT()
DATA=importdata('F:\定位\Git-SINS-Branch\GPS_SINS\6.21华工数据采集\INS_Static2-000.txt');
N=size(DATA.data,1);%行数
t1=0.01:0.01:N*0.01;
t1=t1';
%求均值
Acc_X=mean(DATA.data(:,2));
Acc_Y=mean(DATA.data(:,3));
Acc_Z=mean(DATA.data(:,4));
Mag_X=mean(DATA.data(:,8));
Mag_Y=mean(DATA.data(:,9));
Mag_Z=mean(DATA.data(:,10));

g=sqrt(Acc_X^2+Acc_Y^2+Acc_Z^2);
%方法一：
a=-3.373795*pi/180;
pitch=asin(Acc_Y/g);
roll=asin(-Acc_X/g/cos(pitch));

Cbh=[cos(roll) 0 sin(roll);sin(pitch)*sin(roll)  cos(pitch) -sin(pitch)*cos(roll);-cos(pitch)*sin(roll)  sin(pitch) cos(pitch)*cos(roll) ];
Mag_h=Cbh*[Mag_X Mag_Y Mag_Z]';
yaw=atan2((Mag_h(1,1)*cos(a)-Mag_h(2,1)*sin(a)),((Mag_h(1,1))*sin(a)+Mag_h(2,1)*cos(a)));
