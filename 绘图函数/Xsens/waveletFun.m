function result = waveletFun(data)
%小波去噪函数0
%data输入数据数组
%result为输出数组


%使用小波函数'db6'对信号进行3层分解
[c,l] = wavedec(data,3,'db6');
%估计尺度1的噪声标准差
sigma = wnoisest(c,l,1);
alpha = 2;
%获取消噪过程中的阈值
thr = wbmpen(c,l,sigma,alpha);
keepapp = 1;
%对信号进行消噪
result = wdencmp('gbl',c,l,'db6',3,thr,'s',keepapp);