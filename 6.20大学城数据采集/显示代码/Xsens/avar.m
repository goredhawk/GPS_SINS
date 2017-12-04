function [sigma,tau,Err,R]=avar(y0,tau0,titles,num)
%计算Allan方差
%Allan方差 量纲单位应与输入y保持一致 
%tauo周期
%titles 画图名称
%num 画图顺序
%R 角度随机游走
y=y0;
Nl=length(y);
N=Nl;
for k=1:inf
    sigma(k,1)=sqrt(1/(2*(N-1))*sum([y(2:N)-y(1:N-1)].^2));
    tau(k,1)=2^(k-1)*tau0;
    Err(k,1)=1/sqrt(2*(N-1));
    N=floor(N/2);
    if N<3
        break;
    end
    y=1/2*(y(1:2:2*N)+y(2:2:2*N));
end
R = interp1(tau,sigma,1)*60 ;%%%角度随机游走
figure(num);
subplot(211),plot(tau0*[1:Nl],y0);grid
title(titles);
xlabel('\itt\rm/s');ylabel('\ity');
subplot(212),
loglog(tau,sigma,[1,1],[0.0001,0.1]);grid%%%%双对数函数
xlabel('\itt\rm/s');
ylabel('\it\sigma_A\rm(\tau)');