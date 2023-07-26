仅支持 16 对齐的图像
python blk_to_planar.py <in_file_name> <out_file_name> <width> <height>
python blk_to_planar.py mobile_qcif_blk.yuv mobile_qcif_planar.yuv 176 144


关于 blk/mb 的图像
最常见于 FH 的编码输入，与其硬件配套使用，与常见的 yuv420p 相比，每一帧中的 Y 和 UV 排序都存在不同。
其数据排序规则为：
1. Y 以 16x16 为一个宏块，宏块内部分为 4 个 8x8 子块，最终按照光栅顺序扫描 4 个子块
2. 整帧 Y 扫描完毕后开始 UV
3. U/V 均以 8x8 块为一个单位，交错扫描，即光栅扫描完 8x8 个 U 数据后紧接着扫描 8x8 个 V 数据，之后才开始下一个块的扫描