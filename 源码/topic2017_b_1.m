%% �������һ�Ļ�ͼ
clear all;
clc;

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 5);

% ָ��������ͷ�Χ
opts.Sheet = "t_tasklaunch";
opts.DataRange = "A2:E75";

% ָ�������ƺ�����
opts.VariableNames = ["subject", "jingdu", "weidu", "price", "isFinished"];
opts.VariableTypes = ["string", "double", "double", "double", "string"];

% ָ����������
opts = setvaropts(opts, "subject", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "subject", "EmptyFieldRule", "auto");

% ��������
Data= readtable("D:\��ѧ��ģ\supermodeling-master\����\2017\B\topic\����һ���ѽ�����Ŀ��������.xls", opts, "UseExcel", false);

% �����ʱ����
clear opts

%% ��ͼ
figure(1);
% ����0-1����Ϊ�����������
colorData=categorical(Data.isFinished);

% ����ɢ�ĵ�����Ϣ�ڵ�ͼ�ϰ�����ͼ����ʽչʾ
gb=geobubble(Data.jingdu,Data.weidu,Data.price,colorData,'Title','������ɶ����������ֲ����','Basemap','streets-dark');

% ���ͼ��
gb.SizeLegendTitle='���';
gb.ColorLegendTitle='������ɶ�';

%����ͼƬ
saveas(gcf,'c:\users\admin\pictures\gis.png');