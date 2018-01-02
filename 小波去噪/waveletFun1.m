function result = waveletFun1(data)
%小波去噪函数1
%data输入数据数组
%result为输出数组


%获取消噪的阈值
[thr,sorh,keepapp] = ddencmp('den','wv',data);
%对信号进行消噪99
result = wdencmp('gbl',data,'db4',2,thr,sorh,keepapp);
