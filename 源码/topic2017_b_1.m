%% 针对问题一的绘图
clear all;
clc;

%% 设置导入选项并导入数据
opts = spreadsheetImportOptions("NumVariables", 5);

% 指定工作表和范围
opts.Sheet = "t_tasklaunch";
opts.DataRange = "A2:E75";

% 指定列名称和类型
opts.VariableNames = ["subject", "jingdu", "weidu", "price", "isFinished"];
opts.VariableTypes = ["string", "double", "double", "double", "string"];

% 指定变量属性
opts = setvaropts(opts, "subject", "WhitespaceRule", "preserve");
opts = setvaropts(opts, "subject", "EmptyFieldRule", "auto");

% 导入数据
Data= readtable("D:\数学建模\supermodeling-master\国赛\2017\B\topic\附件一：已结束项目任务数据.xls", opts, "UseExcel", false);

% 清除临时变量
clear opts

%% 绘图
figure(1);
% 设置0-1变量为类别类型数据
colorData=categorical(Data.isFinished);

% 将离散的地理信息在底图上按气泡图的形式展示
gb=geobubble(Data.jingdu,Data.weidu,Data.price,colorData,'Title','任务完成度与任务地理分布情况','Basemap','streets-dark');

% 添加图例
gb.SizeLegendTitle='金额';
gb.ColorLegendTitle='任务完成度';

%保存图片
saveas(gcf,'c:\users\admin\pictures\gis.png');