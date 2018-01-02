%测试小波去噪函数
load leleccum;
indx = 1:1024;
x = leleccum(indx);
%产生含噪信号
init = 2055615886;
% randn('seed',init);
nx = x + 18*randn(size(x));
%nx=nx';必须为竖队列
xd = waveletFun(nx);
subplot(221);
plot(x);
title('原始信号');
subplot(222);
plot(nx);
title('含噪信号');
subplot(223);
plot(xd);
title('消噪后的信号');