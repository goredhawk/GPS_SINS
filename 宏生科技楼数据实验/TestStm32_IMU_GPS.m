
%%%%解析txt文件，保存为mat格式数据
%stm32=textread('F:\定位\严恭敏\跑车实验\初始对准实验\aligin.txt','%s')';
%stm32=textread('F:\定位\严恭敏\跑车实验\3.29采集数据\第二次\data.txt','%s')';
stm32=textread('F:\定位\严恭敏\跑车实验\3.29采集数据\第六次\data.txt','%s')';

n=size(stm32,2);%列数
h=floor(n/71);%行数
stm32_1=stm32(:,1:h*71);%截断多余的列后的数据

stm32_data.gro=zeros(h,3);%存放数据的结构体
stm32_data.acc=zeros(h,3);
stm32_data.mgn=zeros(h,3);
stm32_data.att=zeros(h,3);
stm32_data.gps=zeros(h,2);%只包含经纬度，高度为固定值
stm32_data.t=zeros(h,1);
g=9.7833;%重力加速度
 k=1;
for i=1:71:h*71
    if strcmp(stm32_1{1,i},'81')%判断第一个字节是否为81
        %陀螺仪
        stm32_data.gro(k,1)=strcat4(stm32_1{1,i+4},stm32_1{1,i+3},stm32_1{1,i+2},stm32_1{1,i+1})*180/pi;%原始单位为弧度，转化为度
        stm32_data.gro(k,2)=strcat4(stm32_1{1,i+8},stm32_1{1,i+7},stm32_1{1,i+6},stm32_1{1,i+5})*180/pi;%原始单位为弧度，转化为度
        stm32_data.gro(k,3)=strcat4(stm32_1{1,i+12},stm32_1{1,i+11},stm32_1{1,i+10},stm32_1{1,i+9})*180/pi;%原始单位为弧度，转化为度
        %加速度计
        stm32_data.acc(k,1)=strcat4(stm32_1{1,i+16},stm32_1{1,i+15},stm32_1{1,i+14},stm32_1{1,i+13})/1000*g;%%原始单位为mg，转化为m/s2
        stm32_data.acc(k,2)=strcat4(stm32_1{1,i+20},stm32_1{1,i+19},stm32_1{1,i+18},stm32_1{1,i+17})/1000*g;
        stm32_data.acc(k,3)=strcat4(stm32_1{1,i+24},stm32_1{1,i+23},stm32_1{1,i+22},stm32_1{1,i+21})/1000*g;
        %磁力计
        stm32_data.mgn(k,1)=strcat4(stm32_1{1,i+28},stm32_1{1,i+27},stm32_1{1,i+26},stm32_1{1,i+25})/1000;%原始单位为mguss，转化为guss
        stm32_data.mgn(k,2)=strcat4(stm32_1{1,i+32},stm32_1{1,i+31},stm32_1{1,i+30},stm32_1{1,i+29})/1000;
        stm32_data.mgn(k,3)=strcat4(stm32_1{1,i+36},stm32_1{1,i+35},stm32_1{1,i+34},stm32_1{1,i+33})/1000;
        %姿态角
        stm32_data.att(k,1)=strcat4(stm32_1{1,i+40},stm32_1{1,i+39},stm32_1{1,i+38},stm32_1{1,i+37});%度
        stm32_data.att(k,2)=strcat4(stm32_1{1,i+44},stm32_1{1,i+43},stm32_1{1,i+42},stm32_1{1,i+41});
        stm32_data.att(k,3)=strcat4(stm32_1{1,i+48},stm32_1{1,i+47},stm32_1{1,i+46},stm32_1{1,i+45});
         %经纬度
        stm32_data.gps(k,1)=strcat4(stm32_1{1,i+52},stm32_1{1,i+51},stm32_1{1,i+50},stm32_1{1,i+49});%度
        stm32_data.gps(k,2)=strcat4(stm32_1{1,i+56},stm32_1{1,i+55},stm32_1{1,i+54},stm32_1{1,i+53});
        stm32_data.t(k,1)=k*0.01;
        k=k+1;
    end;
end
t=stm32_data.t(:,1);
%滤波，去除太大的毛刺
stm32_data.gro(:,1)=smooth(stm32_data.gro(:,1),'rlowess');
stm32_data.gro(:,2)=smooth(stm32_data.gro(:,2),'rlowess');
stm32_data.gro(:,3)=smooth(stm32_data.gro(:,3),'rlowess');
stm32_data.acc(:,1)=smooth(stm32_data.acc(:,1),'rlowess');
stm32_data.acc(:,2)=smooth(stm32_data.acc(:,2),'rlowess');
stm32_data.acc(:,3)=smooth(stm32_data.acc(:,3),'rlowess');
stm32_data.mgn(:,1)=smooth(stm32_data.mgn(:,1),'rlowess');
stm32_data.mgn(:,2)=smooth(stm32_data.mgn(:,2),'rlowess');
stm32_data.mgn(:,3)=smooth(stm32_data.mgn(:,3),'rlowess');
stm32_data.att(:,1)=smooth(stm32_data.att(:,1),'rlowess');
stm32_data.att(:,2)=smooth(stm32_data.att(:,2),'rlowess');
stm32_data.att(:,3)=smooth(stm32_data.att(:,3),'rlowess');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%
%数据保存为mat格式，不要每次都是去解析txt文件
save('F:\定位\严恭敏\跑车实验\3.29采集数据\stm32_data','stm32_data');
figure(1);
subplot(3,1,1) ,plot(t,stm32_data.gro(:,1));xlabel('时间t'),ylabel('陀螺仪x%legend('标定数据','原始数据')
subplot(3,1,2) ,plot(t,stm32_data.gro(:,2)*180abel('时间t'),ylabel('陀螺仪y');
%legend('标定数据','原始数据')
subplot(3,1,3) ,plot(t,stm32_data.gro(:,3)*180abel('时间t'),ylabel('陀螺仪z');
%legend('标定数据','原始数据')
title('陀螺仪数据');

figure(2);
subplot(3,1,1) ,plot(t,stm32_data.acc(:,1));xlabel('时间t'),ylabel('加速度计x');
%legend('标定数据','原始数据')
subplot(3,1,2) ,plot(t,stm32_data.acc(:,2));xlabel('时间t'),ylabel('加速度计y');
%legend('标定数据','原始数据')
subplot(3,1,3) ,plot(t,stm32_data.acc(:,3));xlabel('时间t'),ylabel('加速度计z');
% legend('标定数据','原始数据')
title('加速度计');

figure(3);
subplot(3,1,1) ,plot(t,stm32_data.mgn(:,1));xlabel('时间t'),ylabel('磁力计x');
% legend('标定数据','原始数据')
subplot(3,1,2) ,plot(t,stm32_data.mgn(:,2));xlabel('时间t'),ylabel('磁力计y');
% legend('标定数据','原始数据')
subplot(3,1,3) ,plot(t,stm32_data.mgn(:,3));xlabel('时间t'),ylabel('磁力计z');
% legend('标定数据','原始数据')
title('磁力计');

figure(4);
subplot(3,1,1) ,plot(t,stm32_data.att(:,1));xlabel('时间t'),ylabel('Roll');
% legend('标定数据','原始数据')
subplot(3,1,2) ,plot(t,stm32_data.att(:,2));xlabel('时间t'),ylabel('Pitch');
% legend('标定数据','原始数据')
subplot(3,1,3) ,plot(t,stm32_data.att(:,3));xlabel('时间t'),ylabel('Yaw');
% legend('标定数据','原始数据')
title('姿态角');

figure(5);
subplot(2,1,1) ,plot(t,stm32_data.gps(:,1));xlabel('时间t'),ylabel('经度');
subplot(2,1,2) ,plot(t,stm32_data.gps(:,2));xlabel('时间t'),ylabel('纬度');
title('GPS');

figure(6)
plot(stm32_data.gps(:,1),stm32_data.gps(:,2));
%scatter(stm32_data.gps(:,1),stm32_data.gps(:,2),'k*');
title('轨迹');


