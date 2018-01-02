function result = waveletFun2(data)
%小波去噪函数2
%data输入数据数组
%result为输出数组


%使用小波函数'db5'对信号进行3层分解
[c,l] = wavedec(data,3,'db5');
%设置尺度向量
n = [1,2,3];
%设置阈值向量
p = [100,90,80];
%对高频系数进行阈值处理
nc = wthcoef('d',c,l,n,p);
%对修正后的小波分解结构进行重构
result= waverec(nc,l,'db5');