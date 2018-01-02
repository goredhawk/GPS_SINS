function [averLong,averLat, averHigh]=getAver(route)
%输入route:txt文件路径
%输出：
%averLong：平均精度
%averLaT：平均纬度
%averHigh：平均海拔
stm32=textread(route,'%s')';
n=size(stm32,2);%列数
h=n/27;
Re=6378137;
stm32_data.gps=zeros(h,6);%只包含经纬度，高度，三维速度
k=1;
t=1:1:h;
for i=2:27:n
         %经纬度
        stm32_data.gps(k,2)=strcat4(stm32{1,i+3},stm32{1,i+2},stm32{1,i+1},stm32{1,i});%经度
        stm32_data.gps(k,1)=strcat4(stm32{1,i+7},stm32{1,i+6},stm32{1,i+5},stm32{1,i+4});%纬度
        stm32_data.gps(k,3)=strcat4(stm32{1,i+11},stm32{1,i+10},stm32{1,i+9},stm32{1,i+8});%高度
         stm32_data.gps(k,4)=strcat5(stm32{1,i+15},stm32{1,i+14},stm32{1,i+13},stm32{1,i+12});%E速度
         stm32_data.gps(k,5)=strcat5(stm32{1,i+19},stm32{1,i+18},stm32{1,i+17},stm32{1,i+16});%N速度
         stm32_data.gps(k,6)=strcat5(stm32{1,i+23},stm32{1,i+22},stm32{1,i+21},stm32{1,i+20});%D速度
        k=k+1;
 end;
 averLong=mean(stm32_data.gps(:,2));
 averLat=mean(stm32_data.gps(:,1));
 averHigh=mean(stm32_data.gps(:,3));