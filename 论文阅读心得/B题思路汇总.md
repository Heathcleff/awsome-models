# B题思路汇总

[TOC]

## 2017年：”拍照赚钱“的任务定价

### 问题重述

“拍照赚钱”是移动互联网下的一种自助式服务模式。用户下载 APP，注册 成为 APP 的会员，然后从 APP 上领取需要拍照的任务（比如上超市去检查某种 商品的上架情况），赚取 APP 对任务所标定的酬金。这种基于移动互联网的自助 式劳务众包平台，为企业提供各种商业检查和信息搜集，相比传统的市场调查方 式可以大大节省调查成本，而且有效地保证了调查数据真实性，缩短了调查的周 期。因此 APP 成为该平台运行的核心，而 APP 中的任务定价又是其核心要素。 如果定价不合理，有的任务就会无人问津，而导致商品检查的失败。 附件一是一个已结束项目的任务数据，包含了每个任务的位置、定价和完成
情况（“1”表示完成，“0”表示未完成）；附件二是会员信息数据，包含了会员 的位置、信誉值、参考其信誉给出的任务开始预订时间和预订限额，原则上会员 信誉越高，越优先开始挑选任务，其配额也就越大（任务分配时实际上是根据预 订限额所占比例进行配发）；附件三是一个新的检查项目任务数据，只有任务的 位置信息。请完成下面的问题：

1. 研究附件一中项目的任务定价规律，分析任务未完成的原因。 
2. 为附件一中的项目设计新的任务定价方案，并和原方案进行比较。 
3. 实际情况下，多个任务可能因为位置比较集中，导致用户会争相选择，一种 考虑是将这些任务联合在一起打包发布。在这种考虑下，如何修改前面的定 价模型，对最终的任务完成情况又有什么影响？

4. 对附件三中的新项目给出你的任务定价方案，并评价该方案的实施效果。

### 解题思路

#### 针对第一问

文章首先将任务点在地图上全部标出，发现任务集中在**佛山市**、**广州市**、**深圳市**、**东莞市**这四个城市。

我们利用Matlab的geobubble函数对上述操作进行实现，做出图像如下：

<img src="gb.png" style="zoom:150%;" />

代码示例：

```matlab
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
% 设置0-1变量为类别类型数据
colorData=categorical(Data.isFinished);

% 将离散的地理信息在底图上按气泡图的形式展示
gb=geobubble(Data.jingdu,Data.weidu,Data.price,colorData,'Title','任务完成度与任务地理分布情况','Basemap','streets-dark');

% 添加图例
gb.SizeLegendTitle='金额';
gb.ColorLegendTitle='任务完成度';

%保存图片
saveas(png,'c:\users\admin\pictures\gis.png');
```

上面图像可以很清晰直观的反映出任务定价、任务的完成情况和任务的空间位置分布，通过观察我们难看出，任务定价的影响因素包括（但不限于）**==任务相对偏僻程度==、==任务区域会员密度==、==任务密度==**。

接下来我们对