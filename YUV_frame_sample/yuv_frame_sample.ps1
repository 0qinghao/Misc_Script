# 设置参数
$inputFolder = "D:\src_yuv\JVET_test_sequence\ClassB"       # 输入 YUV 文件夹路径
$outputFolder = "D:\src_yuv\JVET_test_sequence\ClassB_sample"     # 输出 YUV 文件夹路径
$width = 1920                                 # YUV 文件的宽度
$height = 1088                                # YUV 文件的高度
$interval = 10                                # 每 10 帧取 1 帧
$pixFmt = "yuv420p"                           # 像素格式

# 创建输出文件夹（如果不存在）
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# 获取所有 YUV 文件
$yuvFiles = Get-ChildItem -Path $inputFolder -Filter *.yuv

# 检查是否找到 YUV 文件
if ($yuvFiles.Count -eq 0) {
    Write-Host "在文件夹 '$inputFolder' 中未找到任何 YUV 文件。"
    exit
}

# 处理每个 YUV 文件
foreach ($file in $yuvFiles) {
    $inputFile = $file.FullName
    $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + "_extracted.yuv"
    $outputFile = Join-Path -Path $outputFolder -ChildPath $outputFileName

    Write-Host "正在处理文件: $inputFile"

    # 构建 FFmpeg 命令
    # 使用双引号时，内部的双引号需要转义为 `"`
    $ffmpegCmd = "ffmpeg -s ${width}x${height} -pix_fmt ${pixFmt} -i `"$inputFile`" -vf `"select='not(mod(n\,$interval))'`" -vsync vfr -pix_fmt ${pixFmt} `"$outputFile`" -y"

    # 执行 FFmpeg 命令
    try {
        Invoke-Expression $ffmpegCmd
        Write-Host "成功生成: $outputFile"
    }
    catch {
        Write-Host "处理文件 $inputFile 时出错: $_"
    }
}

Write-Host "所有文件处理完成。"
