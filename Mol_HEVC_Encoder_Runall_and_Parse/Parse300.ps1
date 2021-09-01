#################### configuration part ####################
$FPS = 25
$frames_to_be_encoded = 300
#################### configuration part end####################


#################### Parse part ####################
$result_dir = pwd
# get result list and sort it like FH
$ToFHOrder = { ([regex]::Replace($_, '^\d+', { $args[0].Value.PadLeft(20, '0') })) -replace "_", "" }
$result_list = ls -Attributes Directory | Sort-Object $ToFHOrder
$result_list = $result_list.Name

# init
$bytes_arr = New-Object System.Collections.ArrayList
$bitrate_arr = New-Object System.Collections.ArrayList
$psnr_arr = New-Object System.Collections.ArrayList
$vmaf_arr = New-Object System.Collections.ArrayList
$regex_to_match_psnr = [regex]"\s+(?<=psnr_yuv:\s+)[\d\.]+"
$QP_list = (22, 27, 32, 37)
# test if vmaf log exist
$temp_seq = $result_list[0]
$VMAF = Test-Path $result_dir\$temp_seq\$temp_seq`_qp22`_vmaf.csv
# Parse Bytes/PSNR/VMAF
foreach ($seq in $result_list) {
	foreach ($QP in $QP_list) {
		$bytes_arr.Add((ls $result_dir\$seq\$seq`_qp$QP`.h265).Length) | Out-Null
		$psnr_arr.Add($regex_to_match_psnr.Match((Get-Content $result_dir\$seq\$seq`_qp$QP`_enc.log)).Value) | Out-Null
		if ($VMAF) { 
			$vmaf_content = (Import-Csv $result_dir\$seq\$seq`_qp$QP`_vmaf.csv).vmaf
			$vmaf_arr.Add(($vmaf_content | Measure-Object -Average).Average) | Out-Null
		}
	}
}
# Calculate Bitrate
for ($i = 0; $i -lt $bytes_arr.Count; $i++) {
	$bitrate_arr.Add($bytes_arr[$i] * 8 / $frames_to_be_encoded * $FPS) | Out-Null
}
#################### Parse part end ####################


#################### Output part ####################
cd $result_dir
$outfile = "data.csv"
if ($VMAF) {
	Set-Content $outfile "Sequence,QP,Bitrate,PSNR,VMAF"
}
else {
	Set-Content $outfile "Sequence,QP,Bitrate,PSNR"
}

$cnt = 0
for ($i = 0; $i -lt $result_list.Count; $i++) {
	for ($j = 0; $j -lt $QP_list.Count; $j++) {
		$temp_content = $result_list[$i] + "," + $QP_list[$j] + "," + $bitrate_arr[$cnt] + "," + $psnr_arr[$cnt]
		if ($VMAF) { $temp_content += "," + $vmaf_arr[$cnt]	}
		$temp_content
		Add-Content $outfile $temp_content
		$cnt++
	}
}

# hmm... it doesn't work as expected
# Get-Content $outfile | CLIP

Write-Host "Output file: $result_dir\$outfile" -ForegroundColor Green
# Pause 
#################### Output part end ####################


#################### About ####################
# Windows 可能阻止脚本运行，需要设置用户运行脚本的策略
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
#################### About end ####################