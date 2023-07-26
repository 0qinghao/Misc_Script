# 可配置
$python = "C:\Users\rin.lin\python-3.10.10-embed-amd64\python.exe"
#$yuv_dir1 = "C:\Users\rin.lin\src_yuv\4cif_704x576"

$yuv_dir2 = "C:\Users\rin.lin\src_yuv\artificitial\ClassF_scale","C:\Users\rin.lin\src_yuv\artificitial\SCC_scale"

# 基本变量
$root_dir = Get-Location 
$run_enc_path = "$root_dir\encoder\exe"
$encoder = "$run_enc_path\HEVC_encoder.exe"
$yuv_list_obj = Get-ChildItem -Path $yuv_dir2 -Filter *.yuv
$yuv_list = $yuv_list_obj.FullName

while ($true) {
    # 随机变量
    # "Get-Random -Minimum a -Maximum b" return integer [a,b)
    $i = Get-Random -Minimum 0 -Maximum $yuv_list.Count; $yuv_file = $yuv_list[$i]#; Write-Output $yuv_file
    $yuv_file -match "\d+(?=x\d+)" | Out-Null; $cur_w = $Matches[0]
    $yuv_file -match "(?<=\d+x)\d+" | Out-Null; $cur_h = $Matches[0]
    $rc = Get-Random -Minimum 0 -Maximum 2
    $tx = Get-Random -Minimum 0 -Maximum 2
    $type = Get-Random -Minimum 0 -Maximum 2
    $rcmode = 1#Get-Random -Minimum 1 -Maximum 3
    $rate = [Math]::pow(10, $(Get-Random -Minimum 2 -Maximum 7))
    $minqp = Get-Random -Minimum 0 -Maximum 12 
    $maxqp = Get-Random -Minimum $($minqp + 1) -Maximum 13
    $qp = Get-Random -Minimum $minqp -Maximum $($maxqp + 1)
    # $qp = [Math]::Round(($minqp + $maxqp) / 2)
    $frames = Get-Random -Minimum 2 -Maximum 100
    $skip = Get-Random -Minimum 0 -Maximum 200 
    $gop = Get-Random -Minimum 1 -Maximum $frames

    $enc_cmd = "Set-Location $run_enc_path; $encoder -i $yuv_file -w $cur_w -h $cur_h -rc $rc -tx $tx -type $type -rate $rate -rcmode $rcmode -min $minqp -max $maxqp -skip $skip -f $frames -gop $gop -qp $qp; cd $root_dir"
    $enc_cmd | Add-Content -Path "$root_dir\log.txt"
    Invoke-Expression $enc_cmd
    $run_cnt_cmd = "$python $root_dir\search01.py $run_enc_path\test_enc.h265"
    Invoke-Expression $run_cnt_cmd | Add-Content -Path "$root_dir\log.txt"
}