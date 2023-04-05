# 可配置
$python = "D:\Programs\Python\Python39\python.exe"
$yuv_dir1 = "D:\src_yuv\4cif_704x576"
$yuv_dir2 = "D:\src_yuv\cif_352x288"
$yuv_dir3 = "D:\src_yuv\qcif_176x144"
$yuv_dir4 = "D:\src_yuv\HEVC_test_sequence\ClassC"
$yuv_dir5 = "D:\src_yuv\HEVC_test_sequence\ClassD"
$yuv_dir6 = "D:\src_yuv\HEVC_test_sequence\ClassE"
$yuv_dir7 = "D:\src_yuv\HEVC_test_sequence\ClassF"

# 基本变量
$root_dir = Get-Location 
$run_enc_path = "$root_dir\encoder\exe"
$encoder = "$run_enc_path\HEVC_encoder.exe"
$yuv_list_obj = Get-ChildItem -Path $yuv_dir1, $yuv_dir2, $yuv_dir3, $yuv_dir4, $yuv_dir5, $yuv_dir6, $yuv_dir7 -Filter *.yuv
$yuv_list = $yuv_list_obj.FullName
$yuv_index_max = $yuv_list.Count - 1

while ($true) {
    # 随机变量
    $i = Get-Random -Minimum 0 -Maximum $yuv_index_max; $yuv_file = $yuv_list[$i]#; Write-Output $yuv_file
    $yuv_file -match "\d+(?=x\d+)" | Out-Null; $cur_w = $Matches[0]
    $yuv_file -match "(?<=\d+x)\d+" | Out-Null; $cur_h = $Matches[0]
    $rc = Get-Random -Minimum 0 -Maximum 2
    $tx = Get-Random -Minimum 0 -Maximum 2
    $type = Get-Random -Minimum 0 -Maximum 2
    $rcmode = Get-Random -Minimum 1 -Maximum 3
    $rate = Get-Random -Minimum 2 -Maximum 7
    $rate = [Math]::Pow(10, $rate)
    $minqp = Get-Random -Minimum 0 -Maximum 51
    $minqp_p1 = $minqp + 1
    $maxqp = Get-Random -Minimum $minqp_p1 -Maximum 52
    $qp = [Math]::Round(($minqp + $maxqp) / 2)
    $frames = Get-Random -Minimum 2 -Maximum 100
    $gop = Get-Random -Minimum 1 -Maximum $frames

    $enc_cmd = "Set-Location $run_enc_path; $encoder -i $yuv_file -w $cur_w -h $cur_h -rc $rc -tx $tx -type $type -rate $rate -rcmode $rcmode -min $minqp -max $maxqp -f $frames -gop $gop -qp $qp; cd $root_dir"
    $enc_cmd | Add-Content -Path "$root_dir\log.txt"
    Invoke-Expression $enc_cmd
    $run_cnt_cmd = "$python $root_dir\search01.py $run_enc_path\test_enc.h265"
    Invoke-Expression $run_cnt_cmd | Add-Content -Path "$root_dir\log.txt"
}