%将四字节转为double
function y=strcat4(a1,a2,a3,a4)

b=[a1,a2,a3,a4];

y=typecast(uint32(hex2dec(b)),'single');
    
    