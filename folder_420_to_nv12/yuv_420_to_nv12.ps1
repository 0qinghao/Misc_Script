param (
    [string]$FolderPath = "./",
    [int]$Width = 1920,
    [int]$Height = 1088
)

# ��� ffmpeg �Ƿ����
if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue)) {
    Write-Error "ffmpeg δ��װ��δ������ϵͳ·���С����Ȱ�װ ffmpeg��"
    exit 1
}

# ��������ļ����Ƿ����
if (-not (Test-Path $FolderPath)) {
    Write-Error "ָ�����ļ���·�������ڣ�$FolderPath"
    exit 1
}

# ��ȡ�ļ����ڵ����� YUV �ļ�
$yuvFiles = Get-ChildItem -Path $FolderPath -Filter *.yuv

# ����Ƿ���� YUV �ļ�
if ($yuvFiles.Count -eq 0) {
    Write-Error "ָ�����ļ�����û���ҵ� YUV �ļ���"
    exit 1
}

# ת��ÿ�� YUV �ļ�
foreach ($file in $yuvFiles) {
    $inputFilePath = $file.FullName
    $fileName = $file.Name

    # ��ȡ�ļ����еĿ�Ⱥ͸߶�
    if ($fileName -match '(\d+)x(\d+)') {
        $Width = [int]$matches[1]
        $Height = [int]$matches[2]
    }

    # ɾ�� "420"��"420p" �� "_420" �� "_420p" ����
    $outputFileName = $fileName -replace '_?420p?', ''  # ɾ�� "420"��"420p"��"_420"��"_420p" 

    # �����µ����·�������� "nv12" ��׺
    $outputFilePath = [System.IO.Path]::Combine($FolderPath, [System.IO.Path]::GetFileNameWithoutExtension($outputFileName) + "_nv12.yuv")

    # ���� ffmpeg ����
    $ffmpegCmd = "ffmpeg -y -f rawvideo -video_size ${Width}x${Height} -pix_fmt yuv420p -i `"$inputFilePath`" -pix_fmt nv12 `"$outputFilePath`""

    # ִ�� ffmpeg ����
    Write-Output "ת���ļ���$inputFilePath �� $outputFilePath"
    Invoke-Expression $ffmpegCmd
}

Write-Output "���� YUV �ļ��ѳɹ�ת��Ϊ NV12 ��ʽ��"
