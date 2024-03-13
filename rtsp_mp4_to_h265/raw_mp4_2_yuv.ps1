# ��ȡ��ǰĿ¼������MP4�ļ�
$mp4Files = Get-ChildItem -Path . -Filter outdoor_day_walkway*.mp4

# ����ÿ��MP4�ļ���ִ��ת������
foreach ($file in $mp4Files) {
    # ��ӡ������ļ���
    Write-Host "�����ļ��� $($file.FullName)"
    
    # ��ȡԭʼ�ֱ���
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]+x[0-9]+)"
    $line = $output.Line
    $resolution = [regex]::Match($line, 'yuv.*?(\d+x\d+)').Groups[1].Value
    
    Write-Output "�ֱ���: $resolution"
    
    # ��������ļ���
    $yuv_name = $file.BaseName + "_$resolution.yuv"
    
    # ִ��ת�����ʹ�û�ȡ�ķֱ�����Ϣ
    # -vf "setpts=N/(FRAME_RATE*TB)"�����¼���ÿ��֡��ʱ�������ȷ�����ǰ�˳��洢
    ffmpeg -i $file.FullName -vf "setpts=N/(FRAME_RATE*TB)" -pix_fmt yuv420p $yuv_name
}

<#
# ����ÿ��MP4�ļ���ִ��ת������
foreach ($file in $mp4Files) {
    # ��ӡ������ļ���
    Write-Host "�����ļ��� $($file.FullName)"
    
    # ��ȡԭʼ֡��
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]*\.?[0-9]+) fps" 
    $line = $output.Line
    $rate = [regex]::Match($line, '(\d+\.\d+) fps').Groups[1].Value
    
    Write-Output "֡��: $rate"
    
    # ��ȡԭʼ�ֱ���
    $output = ffmpeg -i $file.FullName 2>&1 | Select-String -Pattern "Stream #0:0.* ([0-9]+x[0-9]+)"
    $line = $output.Line
    $resolution = [regex]::Match($line, 'yuv.*?(\d+x\d+)').Groups[1].Value
    
    Write-Output "�ֱ���: $resolution"
    
    # ��������ļ���
    $yuv_name = $file.BaseName + "_$resolution.yuv"
    
    # ִ��ת�����ʹ�û�ȡ��֡�ʺͷֱ�����Ϣ
    ffmpeg -i $file.FullName -r $rate -pix_fmt yuv420p $yuv_name
}
#>