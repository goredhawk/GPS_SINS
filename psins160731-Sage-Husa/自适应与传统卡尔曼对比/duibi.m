%%%%对比自适应卡尔曼滤波与传统卡尔曼滤波的差别
avp_a=load('F:\定位\严恭敏\psins160731————Sage-Husa\自适应与传统卡尔曼对比\avp_adaptive.mat');
avp=load('F:\定位\严恭敏\psins160731————Sage-Husa\自适应与传统卡尔曼对比\avperr.mat');

p_a=load('F:\定位\严恭敏\psins160731————Sage-Husa\自适应与传统卡尔曼对比\p_a.mat');
p=load('F:\定位\严恭敏\psins160731————Sage-Husa\自适应与传统卡尔曼对比\p.mat');

t=avp_a.avperr(:,end);
t(:,1)=t(:,1)/60;
glvs
%%%误差最大值
maxlat_a=max(avp_a.avperr(:,7))*glv.Re;
maxlog_a=max(avp_a.avperr(:,8))*glv.Re;
maxwhei_a=max(avp_a.avperr(:,9));

maxwlat=max(avp.avperr(:,7))*glv.Re;
maxwhlog=max(avp.avperr(:,8))*glv.Re;
maxwhei=max(avp.avperr(:,9));


myfigure;%角度误差
subplot(311), plot(t, avp.avperr(:,1)/glv.sec,t, avp_a.avperr(:,1)/glv.sec,'-.','LineWidth',1.5);  xlabel('时间（分钟）'); ylabel('俯仰角（度）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');title('角度误差');
subplot(312), plot(t, avp.avperr(:,2)/glv.sec,t, avp_a.avperr(:,2)/glv.sec,'-.','LineWidth',1.5);  xlabel('时间（分钟）'); ylabel('横滚角（度）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');
subplot(313), plot(t, avp.avperr(:,3)/glv.min,t, avp_a.avperr(:,3)/glv.min,'-.','LineWidth',1.5);  xlabel('时间（分钟）'); ylabel('航向角（度）');legend('传统卡尔曼滤波','自适应卡尔曼滤波');

myfigure;%速度误差
subplot(311), plot(t, avp.avperr(:,4),t, avp_a.avperr(:,4),'-.','LineWidth',1.5); xlabel('时间（分钟）'); ylabel('东向速度误差（m/s）');legend('传统卡尔曼滤波','自适应卡尔曼滤波');title('速度误差');
subplot(312), plot(t, avp.avperr(:,5),t, avp_a.avperr(:,5),'-.','LineWidth',1.5);xlabel('时间（分钟）'); ylabel('东向速度误差（m/s）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');
subplot(313), plot(t, avp.avperr(:,6),t, avp_a.avperr(:,6),'-.','LineWidth',1.5); xlabel('时间（分钟）'); ylabel('东向速度误差（m/s）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');


myfigure;%位置误差
subplot(311), plot(t, avp.avperr(:,7)*glv.Re,t, avp_a.avperr(:,7)*glv.Re,'-.','LineWidth',1.5); xygo('纬度（米）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');title('位置误差');
subplot(312), plot(t, avp.avperr(:,8)*glv.Re,t, avp_a.avperr(:,8)*glv.Re,'-.','LineWidth',1.5); xygo('经度（米）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');
subplot(313), plot(t, avp.avperr(:,9),t, avp_a.avperr(:,9),'-.','LineWidth',1.5); xygo('高度（米）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');

% 
% myfigure;%协方差
% subplot(311), plot(t, p.xkpk(:,22),t, p_a.xkpk(:,22),'r'); xygo('纬度（米）'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');
% subplot(312), plot(t, p.xkpk(:,23),t, p_a.xkpk(:,23),'r'); xygo('经度'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');
% subplot(313), plot(t,p.xkpk(:,24),t, p_a.xkpk(:,24),'r'); xygo('高度'); legend('传统卡尔曼滤波','自适应卡尔曼滤波');

%求均值
%自适应卡尔曼
mean_ad.Lat=mean(abs(avp_a.avperr(:,7)*glv.Re));
mean_ad.Lon=mean(abs(avp_a.avperr(:,8)*glv.Re));
mean_ad.Hei=mean(abs(avp_a.avperr(:,9)));
var_ad.Lat=var(avp_a.avperr(:,7)*glv.Re);
var_ad.Lon=var(avp_a.avperr(:,8)*glv.Re);
var_ad.Hei=var(avp_a.avperr(:,9));

%%%传统卡尔曼
mean_a.Lat=mean(abs(avp.avperr(:,7)*glv.Re));
mean_a.Lon=mean(abs(avp.avperr(:,8)*glv.Re));
mean_a.Hei=mean(abs(avp.avperr(:,9)));
var_a.Lat=var(avp.avperr(:,7)*glv.Re);
var_a.Lon=var(avp.avperr(:,8)*glv.Re);
var_a.Hei=var(avp.avperr(:,9));

%%求均值，利用协方差p