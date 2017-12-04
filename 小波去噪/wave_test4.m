% 本例中，使用一维信号的自动消噪函数wden对信号进行消噪。
load leleccum;
indx = 1:1024;
x = leleccum(indx);
%产生含噪信号
init = 2055615866;
randn('seed',init);
nx = x + 18*randn(size(x));
%将信号nx使用小波函数'sym5'分解到第5层
%使用mimimaxi阈值选择系数进行处理，消除噪声信号
lev = 5
xd = wden(nx,'minimaxi','s','mln',lev,'sym5');
subplot(221);
plot(x);
title('原始信号');
subplot(222);
plot(nx);
title('含噪信号');
subplot(223);
plot(xd);
title('消噪后的信号');