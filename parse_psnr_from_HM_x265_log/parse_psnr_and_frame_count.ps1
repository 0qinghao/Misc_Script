function get_weighted_psnr_from_file {
    param (
        [string]$file_path, # �����ļ�·��
        [string]$log_type    # ������������ ('HM' �� 'x265')
    )
    
    # ��ȡ�ļ���������
    $file_content = Get-Content $file_path

    # ��ʼ����־��ָʾ�Ƿ����ҵ�������
    $found_header = $false

    # ���ڴ洢��Ȩ PSNR �ı���
    $weighted_psnr = $null
    $frame_count = $null

    # ���ݲ�ͬ�� log_type ��������
    foreach ($line in $file_content) {
        if ($log_type -eq "hm") {
            # HM log ��ʽ
            if ($line -match "Total Frames\s*\|\s*Bitrate\s+Y-PSNR\s+U-PSNR\s+V-PSNR") {
                $found_header = $true
                continue  # ���������У�������������������
            }
            
            # �ڱ�����֮����������
            if ($found_header -and ($line -match "(\d+)\s+a\s+(?:[0-9.]+)\s+([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)")) {
                $frame_count = [int]$matches[1]
                $y_psnr = [double]$matches[2]
                $u_psnr = [double]$matches[3]
                $v_psnr = [double]$matches[4]
                
                # �����Ȩ PSNR (6:1:1)
                $weighted_psnr = (6 * $y_psnr + 1 * $u_psnr + 1 * $v_psnr) / 8
                break  # �ҵ�������˳�ѭ��
            }
        }
        elseif ($log_type -eq "x265") {
            # x265 log ��ʽ�����ұ�����
            if ($line -match "Command,\s*Date/Time,\s*Elapsed\s*Time,\s*FPS,\s*Bitrate,\s*Y PSNR,\s*U PSNR,\s*V PSNR,\s*Global PSNR") {
                $found_header = $true
                continue  # ���������У�������������������
            }
            
            # �ڱ�����֮����������
            # if ($found_header -and ($line -match "(?:[^,]+,\s*){5}([0-9.]+),\s*([0-9.]+),\s*([0-9.]+),\s*")) {
            #     $y_psnr = [double]$matches[1]
            #     $u_psnr = [double]$matches[2]
            #     $v_psnr = [double]$matches[3]
                
            #     # �����Ȩ PSNR (6:1:1)
            #     $weighted_psnr = (6 * $y_psnr + 1 * $u_psnr + 1 * $v_psnr) / 8
            #     break  # �ҵ�������˳�ѭ��
            # }
            if ($found_header -and ($line -match "(?:[^,]+,\s*){8}([0-9.]+)\s*,(?:[^,]+,\s*){2}(\d+)\s*,(?:[^,]+,\s*){6}([\d-]+)\s*,(?:[^,]+,\s*){6}([\d-]+)")) {
                $i_count = [int]$matches[2]
                $p_count = if ($matches[3] -eq '-') { 0 } else { [int]$matches[3] }
                $b_count = if ($matches[4] -eq '-') { 0 } else { [int]$matches[4] }
                $frame_count = $i_count + $p_count + $b_count

                $weighted_psnr = [double]$matches[1]
                break  # �ҵ�������˳�ѭ��
            }
        }
        else {
            Write-Output "��֧�ֵ� log_type: $log_type"
            return
        }
    }

    # ���ؼ�Ȩ PSNR �� frame_count
    return @{
        "weighted_psnr" = $weighted_psnr
        "frame_count"   = $frame_count
    }
}

# ����ʾ��
get_weighted_psnr_from_file -file_path "./hm.log" -log_type "hm"
get_weighted_psnr_from_file -file_path "./x265.csv" -log_type "x265"
