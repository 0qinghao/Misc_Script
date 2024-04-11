bin_1 = """D:\HM15_Src\bin\BasketballDrive_1920x1088_50_1stMXqp37_2toendsrc.h265""";
bin_2 = """D:\Run_Enc_Script\Result_2022_10_26_1633 intra weight\BasketballDrive_1920x1088_50\BasketballDrive_1920x1088_50_qp37.h265""";
source_yuv = """T:\Derek.You\YUV_Sequence\ClassB\1088\BasketballDrive_1920x1088_50.yuv""";

dec_n_csv_cmd1 = strcat("TAppDecoderLogcsv.exe --DecFrames=5 -o dec.yuv -b ",bin_1," --SourceFile=",source_yuv)
system(dec_n_csv_cmd1);
movefile ctu_info analyse1
movefile rc_stat.csv analyse1
movefile dec.yuv analyse1
copyfile((strrep(bin_1,"""","")),"analyse1/")

dec_n_csv_cmd2 = strcat("TAppDecoderLogcsv.exe --DecFrames=5 -o dec.yuv -b ",bin_2," --SourceFile=",source_yuv)
system(dec_n_csv_cmd2);
movefile ctu_info analyse2
movefile rc_stat.csv analyse2
movefile dec.yuv analyse2
copyfile bin_2 analyse2
copyfile((strrep(bin_2,"""","")),"analyse2/")