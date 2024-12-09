function get_weighted_psnr_from_file {
    param (
        [string]$file_path, # 输入文件路径
        [string]$log_type    # 解析对象类型 ('HM' 或 'x265')
    )
    
    # 读取文件的所有行
    $file_content = Get-Content $file_path

    # 初始化标志，指示是否已找到标题行
    $found_header = $false

    # 用于存储加权 PSNR 的变量
    $weighted_psnr = $null
    $frame_count = $null

    # 根据不同的 log_type 处理数据
    foreach ($line in $file_content) {
        if ($log_type -eq "hm") {
            # HM log 格式
            if ($line -match "Total Frames\s*\|\s*Bitrate\s+Y-PSNR\s+U-PSNR\s+V-PSNR") {
                $found_header = $true
                continue  # 跳过标题行，继续处理后面的数据行
            }
            
            # 在标题行之后处理数据行
            if ($found_header -and ($line -match "(\d+)\s+a\s+(?:[0-9.]+)\s+([0-9.]+)\s+([0-9.]+)\s+([0-9.]+)")) {
                $frame_count = [int]$matches[1]
                $y_psnr = [double]$matches[2]
                $u_psnr = [double]$matches[3]
                $v_psnr = [double]$matches[4]
                
                # 计算加权 PSNR (6:1:1)
                $weighted_psnr = (6 * $y_psnr + 1 * $u_psnr + 1 * $v_psnr) / 8
                break  # 找到结果后退出循环
            }
        }
        elseif ($log_type -eq "x265") {
            # x265 log 格式，查找标题行
            if ($line -match "Command,\s*Date/Time,\s*Elapsed\s*Time,\s*FPS,\s*Bitrate,\s*Y PSNR,\s*U PSNR,\s*V PSNR,\s*Global PSNR") {
                $found_header = $true
                continue  # 跳过标题行，继续处理后面的数据行
            }
            
            # 在标题行之后处理数据行
            # if ($found_header -and ($line -match "(?:[^,]+,\s*){5}([0-9.]+),\s*([0-9.]+),\s*([0-9.]+),\s*")) {
            #     $y_psnr = [double]$matches[1]
            #     $u_psnr = [double]$matches[2]
            #     $v_psnr = [double]$matches[3]
                
            #     # 计算加权 PSNR (6:1:1)
            #     $weighted_psnr = (6 * $y_psnr + 1 * $u_psnr + 1 * $v_psnr) / 8
            #     break  # 找到结果后退出循环
            # }
            if ($found_header -and ($line -match "(?:[^,]+,\s*){8}([0-9.]+)\s*,(?:[^,]+,\s*){2}(\d+)\s*,(?:[^,]+,\s*){6}([\d-]+)\s*,(?:[^,]+,\s*){6}([\d-]+)")) {
                $i_count = [int]$matches[2]
                $p_count = if ($matches[3] -eq '-') { 0 } else { [int]$matches[3] }
                $b_count = if ($matches[4] -eq '-') { 0 } else { [int]$matches[4] }
                $frame_count = $i_count + $p_count + $b_count

                $weighted_psnr = [double]$matches[1]
                break  # 找到结果后退出循环
            }
        }
        else {
            Write-Output "不支持的 log_type: $log_type"
            return
        }
    }

    # 返回加权 PSNR 和 frame_count
    return @{
        "weighted_psnr" = $weighted_psnr
        "frame_count"   = $frame_count
    }
}

# 调用示例
get_weighted_psnr_from_file -file_path "./hm.log" -log_type "hm"
get_weighted_psnr_from_file -file_path "./x265.csv" -log_type "x265"
