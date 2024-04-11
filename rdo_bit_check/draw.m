load("vlc_mv_trans_rdo_real.mat");

% 三维柱状频次图  根据频次着色
subplot(2,2,1)
xyEdge = 0:max([vlc_mv_real;vlc_mv_rdo]);
[N,~,~,binX,binY] = histcounts2(vlc_mv_real,vlc_mv_rdo,xyEdge,xyEdge);
b = bar3(N);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xlabel('RDO bits')
ylabel('Real bits')
zlabel('频次')
title('(vlc bits 方案) MV info 部分 RDO bits - Real bits 对比')
view(45,25)

subplot(2,2,2)
vlc_trans_real = log2(vlc_trans_real);
vlc_trans_rdo = log2(vlc_trans_rdo);
ss = 100;
xyEdge = linspace(0,round(max([vlc_trans_real;vlc_trans_rdo])),ss);
[N,~,~,binX,binY] = histcounts2(vlc_trans_real,vlc_trans_rdo,xyEdge,xyEdge);
b = bar3(N);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xlabel('RDO bits')
ylabel('Real bits')
zlabel('频次')
title('(vlc bits 方案) Trans 部分 RDO bits - Real bits 对比')
view(45,25)




load("bincnt_mv_trans_rdo_real.mat");
% 三维柱状频次图  根据频次着色
subplot(2,2,3)
xyEdge = 0:max([bincnt_mv_real;bincnt_mv_rdo]);
[N,~,~,binX,binY] = histcounts2(bincnt_mv_real,bincnt_mv_rdo,xyEdge,xyEdge);
b = bar3(N);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xlabel('RDO bits')
ylabel('Real bits')
zlabel('频次')
title('(bin cnt 方案) MV info 部分 RDO bits - Real bits 对比')
view(45,25)

subplot(2,2,4)
bincnt_trans_real = log2(bincnt_trans_real);
bincnt_trans_rdo = log2(bincnt_trans_rdo);
ss = 100;
xyEdge = linspace(0,round(max([bincnt_trans_real;bincnt_trans_rdo])),ss);
[N,~,~,binX,binY] = histcounts2(bincnt_trans_real,bincnt_trans_rdo,xyEdge,xyEdge);
b = bar3(N);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xlabel('RDO bits')
ylabel('Real bits')
zlabel('频次')
title('(bin cnt 方案) Trans 部分 RDO bits - Real bits 对比')
view(45,25)