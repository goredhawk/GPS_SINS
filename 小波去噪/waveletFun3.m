function result = waveletFun3(data)
%小波去噪函数3
%data输入数据数组
%result为输出数组


%将信号nx使用小波函数'sym5'分解到第5层
%使用mimimaxi阈值选择系数进行处理，消除噪声信号
lev = 5
result = wden(data,'minimaxi','s','mln',lev,'sym5');