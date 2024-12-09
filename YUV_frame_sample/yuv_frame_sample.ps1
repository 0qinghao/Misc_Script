# ���ò���
$inputFolder = "D:\src_yuv\JVET_test_sequence\ClassB"       # ���� YUV �ļ���·��
$outputFolder = "D:\src_yuv\JVET_test_sequence\ClassB_sample"     # ��� YUV �ļ���·��
$width = 1920                                 # YUV �ļ��Ŀ��
$height = 1088                                # YUV �ļ��ĸ߶�
$interval = 10                                # ÿ 10 ֡ȡ 1 ֡
$pixFmt = "yuv420p"                           # ���ظ�ʽ

# ��������ļ��У���������ڣ�
if (!(Test-Path -Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder | Out-Null
}

# ��ȡ���� YUV �ļ�
$yuvFiles = Get-ChildItem -Path $inputFolder -Filter *.yuv

# ����Ƿ��ҵ� YUV �ļ�
if ($yuvFiles.Count -eq 0) {
    Write-Host "���ļ��� '$inputFolder' ��δ�ҵ��κ� YUV �ļ���"
    exit
}

# ����ÿ�� YUV �ļ�
foreach ($file in $yuvFiles) {
    $inputFile = $file.FullName
    $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name) + "_extracted.yuv"
    $outputFile = Join-Path -Path $outputFolder -ChildPath $outputFileName

    Write-Host "���ڴ����ļ�: $inputFile"

    # ���� FFmpeg ����
    # ʹ��˫����ʱ���ڲ���˫������Ҫת��Ϊ `"`
    $ffmpegCmd = "ffmpeg -s ${width}x${height} -pix_fmt ${pixFmt} -i `"$inputFile`" -vf `"select='not(mod(n\,$interval))'`" -vsync vfr -pix_fmt ${pixFmt} `"$outputFile`" -y"

    # ִ�� FFmpeg ����
    try {
        Invoke-Expression $ffmpegCmd
        Write-Host "�ɹ�����: $outputFile"
    }
    catch {
        Write-Host "�����ļ� $inputFile ʱ����: $_"
    }
}

Write-Host "�����ļ�������ɡ�"
