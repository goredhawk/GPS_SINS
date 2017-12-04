%%%初始对准
load('F:\定位\严恭敏\跑车实验\初始对准实验\aligin.mat');
%%%%加速度计与磁力计的平均值
%%%%用的是弧度，加载的数据是角度
dec=(1+9/60)*pi/180;%磁偏角
inc=31*pi/180;%磁倾角

accX=mean(stm32_data.acc(:,1));%单位为m/s2
accY=mean(stm32_data.acc(:,2));
accZ=mean(stm32_data.acc(:,3));

mgnX=mean(stm32_data.mgn(:,1));%单位为G
mgnY=mean(stm32_data.mgn(:,2));
mgnZ=mean(stm32_data.mgn(:,3));

roll_stard=mean(stm32_data.att(:,1));%转化为弧度
pitch_stard=mean(stm32_data.att(:,2));
yaw_stard=mean(stm32_data.att(:,3));

g=sqrt(accX.^2+accY.^2+accZ.^2);%m/s2

pitch=asin(accY/g)*180/pi;%函数返回的就是弧度
roll=asin(-accX/g/cos(pitch))*180/pi;
yaw=atan((mgnX*cos(dec)-mgnY*sin(dec))/(mgnX*sin(dec)+mgnY*cos(dec)))*180/pi;
