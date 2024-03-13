# 获取当前目录的所有MP4文件
$mp4Files = Get-ChildItem -Path . -Filter outdoor_day_walkway*.mp4

# 遍历每个MP4文件并执行转换命令
foreach ($file in $mp4Files) {
    # 打印处理的文件名
    Write-Host "处理文件： $($file.FullName)"
    
    # 获取原始分辨率
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]+x[0-9]+)"
    $line = $output.Line
    $resolution = [regex]::Match($line, 'yuv.*?(\d+x\d+)').Groups[1].Value
    
    Write-Output "分辨率: $resolution"
    
    # 构建输出文件名
    $yuv_name = $file.BaseName + "_$resolution.yuv"
    
    # 执行转换命令，使用获取的分辨率信息
    # -vf "setpts=N/(FRAME_RATE*TB)"：重新计算每个帧的时间戳，以确保它们按顺序存储
    ffmpeg -i $file.FullName -vf "setpts=N/(FRAME_RATE*TB)" -pix_fmt yuv420p $yuv_name
}

<#
# 遍历每个MP4文件并执行转换命令
foreach ($file in $mp4Files) {
    # 打印处理的文件名
    Write-Host "处理文件： $($file.FullName)"
    
    # 获取原始帧率
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]*\.?[0-9]+) fps" 
    $line = $output.Line
    $rate = [regex]::Match($line, '(\d+\.\d+) fps').Groups[1].Value
    
    Write-Output "帧率: $rate"
    
    # 获取原始分辨率
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]+x[0-9]+)"
    $line = $output.Line
    $resolution = [regex]::Match($line, 'yuv.*?(\d+x\d+)').Groups[1].Value
    
    Write-Output "分辨率: $resolution"
    
    # 构建输出文件名
    $yuv_name = $file.BaseName + "_$resolution.yuv"
    
    # 执行转换命令，使用获取的帧率和分辨率信息
    ffmpeg -i $file.FullName -r $rate -pix_fmt yuv420p $yuv_name
}
#>