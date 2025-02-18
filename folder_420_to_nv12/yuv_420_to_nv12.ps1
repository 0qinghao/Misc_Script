param (
    [string]$FolderPath = "./",
    [int]$Width = 1920,
    [int]$Height = 1088
)

# 检查 ffmpeg 是否存在
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Error "ffmpeg 未安装或未配置在系统路径中。请先安装 ffmpeg。"
    exit 1
}

# 检查输入文件夹是否存在
if (-not (Test-Path $FolderPath)) {
    Write-Error "指定的文件夹路径不存在：$FolderPath"
    exit 1
}

# 获取文件夹内的所有 YUV 文件
$yuvFiles = Get-ChildItem -Path $FolderPath -Filter *.yuv

# 检查是否存在 YUV 文件
if ($yuvFiles.Count -eq 0) {
    Write-Error "指定的文件夹中没有找到 YUV 文件。"
    exit 1
}

# 转换每个 YUV 文件
foreach ($file in $yuvFiles) {
    $inputFilePath = $file.FullName
    $fileName = $file.Name

    # 提取文件名中的宽度和高度
    if ($fileName -match '(\d+)x(\d+)') {
        $Width = [int]$matches[1]
        $Height = [int]$matches[2]
    }

    # 删除 "420"、"420p" 或 "_420" 或 "_420p" 部分
    $outputFileName = $fileName -replace '_?420p?', ''  # 删除 "420"、"420p"、"_420"、"_420p" 

    # 生成新的输出路径，加入 "nv12" 后缀
    $outputFilePath = [System.IO.Path]::Combine($FolderPath, [System.IO.Path]::GetFileNameWithoutExtension($outputFileName) + "_nv12.yuv")

    # 构建 ffmpeg 命令
    $ffmpegCmd = "ffmpeg -y -f rawvideo -video_size ${Width}x${Height} -pix_fmt yuv420p -i `"$inputFilePath`" -pix_fmt nv12 `"$outputFilePath`""

    # 执行 ffmpeg 命令
    Write-Output "转换文件：$inputFilePath 到 $outputFilePath"
    Invoke-Expression $ffmpegCmd
}

Write-Output "所有 YUV 文件已成功转换为 NV12 格式。"
