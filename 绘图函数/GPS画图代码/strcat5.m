%将四字节转为double 有符号四字节数
function y=strcat4(a1,a2,a3,a4)

b=[a1,a2,a3,a4];

y=typecast(int32(hex2dec(b)),'single');