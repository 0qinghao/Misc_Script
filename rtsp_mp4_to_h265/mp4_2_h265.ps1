# 获取当前目录下所有的.mp4文件
$mp4Files = Get-ChildItem -Filter "*.mp4"

# 循环处理每个.mp4文件
foreach ($file in $mp4Files) {
    # 构建输出文件的文件名，将.mp4替换为.h265
    $outputFileName = $file.Name -replace ".mp4$", ".h265"

    # 构建ffmpeg命令并执行
    $ffmpegCommand = "ffmpeg -i `"$($file.FullName)`" -c:v copy `"$outputFileName`""
    Invoke-Expression $ffmpegCommand
}

Write-Host "转换完成。"