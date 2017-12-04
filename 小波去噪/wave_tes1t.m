load leleccum;
index = 1:1024;
x = leleccum(index);
%产生噪声信号
init = 2055615866;
randn('seed',init);
nx = x + 18*randn(size(x));
%获取消噪的阈值
[thr,sorh,keepapp] = ddencmp('den','wv',nx);
%对信号进行消噪
xd = wdencmp('gbl',nx,'db4',2,thr,sorh,keepapp);
subplot(221);
plot(x);
title('原始信号');
subplot(222);
plot(nx);
title('含噪信号');
subplot(223);
plot(xd);
title('消噪后的信号');
% subplot(224);
% plot(leleccum);
% title('lelccum');