%惯性器件数据预处理
DATA=importdata('F:\定位\Git-SINS-Branch\GPS_SINS\6.21华工数据采集\INS_Static2-000.txt');
N=size(DATA.data,1);%行数
t1=0.01:0.01:N*0.01;
t1=t1';
INS(:,1)= waveletFun3(DATA.data(:,2)');
INS(:,2)= waveletFun3(DATA.data(:,3)');
INS(:,3)= waveletFun3(DATA.data(:,4)');
INS(:,4)= waveletFun3(DATA.data(:,5)');
INS(:,5)= waveletFun3(DATA.data(:,6)');
INS(:,6)= waveletFun3(DATA.data(:,7)');
%转化为角增量，直接将其输出乘以T
INS(:,1)= INS(:,1)*0.01;
INS(:,2)= INS(:,2)*0.01;
INS(:,3)= INS(:,3)*0.01;
INS(:,4)= INS(:,4)*0.01;
INS(:,5)= INS(:,5)*0.01;
INS(:,6)= INS(:,6)*0.01;
save('F:\定位\Git-SINS-Branch\GPS_SINS\psins160731-原始\data\INS.mat','INS');