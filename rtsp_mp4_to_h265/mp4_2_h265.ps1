# ��ȡ��ǰĿ¼�����е�.mp4�ļ�
$mp4Files = Get-ChildItem -Filter "*.mp4"

# ѭ������ÿ��.mp4�ļ�
foreach ($file in $mp4Files) {
    # ��������ļ����ļ�������.mp4�滻Ϊ.h265
    $outputFileName = $file.Name -replace ".mp4$", ".h265"

    # ����ffmpeg���ִ��
    $ffmpegCommand = "ffmpeg -i `"$($file.FullName)`" -c:v copy `"$outputFileName`""
    Invoke-Expression $ffmpegCommand
}

Write-Host "ת����ɡ�"