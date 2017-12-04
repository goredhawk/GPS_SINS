% 本例中，对小波分解系数使用函数wthcoef进行阈值处理，然后利用阈值处理后的小波系数进行重构达到去噪目的。
load leleccum;
indx = 1:1024;
x = leleccum(indx);
%产生含噪信号
init = 2055615866;
randn('seed',init);
nx = x + 18*randn(size(x));
%使用小波函数'db5'对信号进行3层分解
[c,l] = wavedec(nx,3,'db5');
%设置尺度向量
n = [1,2,3];
%设置阈值向量
p = [100,90,80];
%对高频系数进行阈值处理
nc = wthcoef('d',c,l,n,p);
%对修正后的小波分解结构进行重构
rx = waverec(nc,l,'db5');
subplot(221);
plot(x);
title('原始信号');
subplot(222);
plot(nx);
title('含噪信号');
subplot(223);
plot(rx);
title('消噪后的信号');