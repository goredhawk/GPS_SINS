% SINS pure inertial navigation simulation. Please run 
%将实际数据带入，pure inertial navigation
profile on
glvs
%获得初始航向角
[initRoll , initPitch , initYaw] = getATT();

%获得初始GPS值
initGPS= getALH();

%avp0赋值
trj.avp0(1,1:3) =  [initRoll , initPitch , pi/2];
trj.avp0(1, 4:6) =  [0 , 0 , 0];
trj.avp0(1,7:9) =  [initGPS(1,1) , initGPS(1,2) , initGPS(1,3)];
trj.ts = 0.01;
trj.reapts = 1;

%INS数据，imu为T内的增量
load('F:\定位\Git-SINS-Branch\GPS_SINS\psins160731-原始\data\INS.mat');
trj.imu(: , 1:3) = INS(: , 4:6);
trj.imu(: , 4:6) = INS(: , 1:3);
N = size(trj.imu , 1);
trj.imu(: , 7) = (0.01:0.01:N*0.01)';
%trj = trjfile('trj10ms.mat');

%GPS数据：纬度、经度、高度
load('F:\定位\Git-SINS-Branch\GPS_SINS\psins160731-原始\data\GPS.mat');
GPS = stm32_data.gps;
[nn, ts, nts] = nnts(4, trj.ts);

%零偏与漂移
% imuerr = imuerrset(0.01, 100, 0.001, 10);
eb = 4.68;%deg/h
web = 2.1633;%deg/sqrt(h)
db = 4730;%ug
wdb = 68;%ug/sqrt(Hz)
imuerr.eb(1:3) = eb*glv.dph;   imuerr.web(1:3) = web*glv.dpsh;
imuerr.db(1:3) = db*glv.ug;    imuerr.wdb(1:3) = wdb*glv.ugpsHz;

%imu数据
% imu = imuadderr(trj.imu, imuerr);
imu = trj.imu;

%初始姿态速度经纬度
% davp0 = avpseterr([30;30;10], 0.1, [10;10;10]);
% avp00 = avpadderr(trj.avp0, davp0);
avp00 = trj.avp0;

%高度的仿真,高度保持不变
% trj = bhsimu(trj, 1, 10, 3, 1);
trj.bh(:,2) = 0.01:1:N;
trj.bh(:,1) = initGPS(1,3);

avp = inspure(imu, avp00, trj.bh);  % pure inertial navigation
% avperr = avpcmp(avp, trj.avp);
% inserrplot(avperr)
%评估代码的耗时时间
profile viewer