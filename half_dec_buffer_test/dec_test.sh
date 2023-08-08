#!/bin/bash

SeqName=(10_outdoor_dusk_cross_lightvar_1920x1088 12_indoor_day_OnePeopleSitting_1920x1088 13_outdoor_day_road_pixelmove_1920x1088 1_outdoor_day_cross_1920x1088 2_outdoor_dusk_cross_1920x1088 3_outdoor_night_cross_1920x1088 4_indoor_night_onePeopleMoving_1920x1088 5_outdoor_day_rain_cross_1920x1088 6_outdoor_day_road_fewcars_1920x1088 7_indoor_night_noPeople_1920x1088 8_outdoor_day_road_many_cars_1920x1088 9_indoor_day_canteen_1920x1088 BQTerrace_1920x1088_60 BasketballDrive_1920x1088_50 Cactus_1920x1088_50 HL_day_asphalt_road_265_16M_1920x1088_729frames HL_indoor_265_30M_1920x1088_878frames HL_indoor_44db_265_16M_1920x1088_234frames HL_outdoor_night_265_12M_1920x1088_1006frames Kimono_1920x1088_24 ParkScene_1920x1088_24 Tennis_1920x1088_24 WS_F35_265_8M_1920x1088_1705frames case025_1920x1088_12b_34425_car1_1000frames hk_floor_12M_1920x1088 hk_light_1920x1088_201frames indoor1_54db_wdroff_NR50_8M_1920x1088 indoor_54db_wdroff_NR35_8fps_8M_1920x1088_1399frames indoor_54db_wdroff_NR40_8fps_8M_1920x1088_1397frames indoor_54db_wdroff_NR45_8fps_8M_1920x1088 outdoor_day02_1920x1088 outdoor_day_8M_1920x1088_872frames outdoor_day_cross_clip_global_light_change2_1920x1088_1000frames outdoor_night_8M_1920x1088 outdoor_wdroff_8M_1920x1088 question_IFlicker_1_1920x1088_673frames question_IFlicker_2_1920x1088_1400frames question_mosaic_0_1920x1088_1026frames question_mosaic_1_1920x1088_1001frames red_car2_1920x1088)
# SeqName=(10_outdoor_dusk_cross_lightvar_1920x1088 12_indoor_day_OnePeopleSitting_1920x1088)
# SeqName=(BasketballDrive_1920x1088_50)

basedir=$(pwd)
bs_dir=/mnt/d/FH_PT/PTv2_FH_H265_2M/
yuv_dir=/mnt/e/src_yuv/mc_test_all/ #10_outdoor_dusk_cross_lightvar_1920x1088.yuv

rm $basedir/HM/summary.csv
for i in "${!SeqName[@]}"; do
    {
        cd $basedir/HM

        echo "Decoding "${SeqName[$i]}" HM_src"
        ./TAppDecoderStatic_src -b $bs_dir/${SeqName[$i]}/${SeqName[$i]}_blk_cbr_2M_FH.h265 -o ${SeqName[$i]}_src_dec.yuv >/dev/null #2>&1
        ffmpeg -pixel_format yuv420p -f rawvideo -video_size 1920x1088 -i $yuv_dir/${SeqName[$i]}.yuv -pixel_format yuv420p -f rawvideo -video_size 1920x1088 -i ${SeqName[$i]}_src_dec.yuv -filter_complex psnr=stats_file=${SeqName[$i]}_src_dec.psnr -f null - >./${SeqName[$i]}_src_dec.log 2>&1
        psnr_src=$(tail ./${SeqName[$i]}_src_dec.log | grep -o -E 'average:[0-9.]+' | grep -o -E '[0-9.]+')

        echo "Decoding "${SeqName[$i]}" HM_half_dec_buffer"
        ./TAppDecoderStatic_half_dec_buf -b $bs_dir/${SeqName[$i]}/${SeqName[$i]}_blk_cbr_2M_FH.h265 -o ${SeqName[$i]}_half_dec_buf_dec.yuv >/dev/null #2>&1
        ffmpeg -pixel_format yuv420p -f rawvideo -video_size 1920x1088 -i $yuv_dir/${SeqName[$i]}.yuv -pixel_format yuv420p -f rawvideo -video_size 1920x1088 -i ${SeqName[$i]}_half_dec_buf_dec.yuv -filter_complex psnr=stats_file=${SeqName[$i]}_half_dec_buf_dec.psnr -f null - >./${SeqName[$i]}_half_dec_buf_dec.log 2>&1
        psnr_half_dec_buf=$(tail ./${SeqName[$i]}_half_dec_buf_dec.log | grep -o -E 'average:[0-9.]+' | grep -o -E '[0-9.]+')

        echo ${SeqName[$i]},$psnr_src,$psnr_half_dec_buf >>summary.csv

        rm *.yuv
    }
done
