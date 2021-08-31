# $blk_info_dir = "\\pub\staff\rin.lin\HM_MOLcfg_INTRA_BS\"
$blk_info_dir = "\\pub\staff\rin.lin\FH_MOLcfg_INTRA_BS\"
$result_list = ls -Path $blk_info_dir -Filter "*.csv" | % { $_.FullName }

# init
$regex_to_match_line = [regex]"^pu\stype\sluma/chroma;"
$regex_to_match_luma_mode = [regex]"(?<=^pu\stype\sluma/chroma;)\d+"
$regex_to_match_chroma_mode = [regex]"(?<=^pu\stype\sluma/chroma;.+)\d+$"
$outfile = $blk_info_dir + "data.csv"
Set-Content $outfile "Sequence,PU cnt,luma chroma neq count,percent"

foreach ($log in $result_list) {
	Write-Host "Parsing" $log
	$pu_cnt = 0
	$luma_chroma_eq_cnt = 0;
	$luma_chroma_neq_cnt = 0;
	foreach ($line in Get-Content $log) {
		if ($line -match $regex_to_match_line) {
			$pu_cnt++
			$luma_mode = $regex_to_match_luma_mode.Match($line).Value
			$chroma_mode = $regex_to_match_chroma_mode.Match($line).Value
			if ($luma_mode -eq $chroma_mode) {
				$luma_chroma_eq_cnt++
			}
			else {
				$luma_chroma_neq_cnt++
			}
		}
	}
	$neq_percent = $luma_chroma_neq_cnt / $pu_cnt * 100
	Write-Host "PU count=$pu_cnt, Not equal count=$luma_chroma_neq_cnt, $neq_percent%"
	Add-Content $outfile "$log,$pu_cnt,$luma_chroma_neq_cnt,$neq_percent"
}

# Write-Host "PU count=" $pu_cnt ",luma_chroma_mode_not_equal_count=" $luma_chroma_neq_cnt "," $luma_chroma_neq_cnt/$pu_cnt*100 "%"

#################### About ####################
# Windows 可能阻止脚本运行，需要设置用户运行脚本的策略
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# 此外 运行脚本时有可能提醒是否重置策略 选择默认否即可
#################### About end ####################