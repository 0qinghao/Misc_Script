#################### configuration part ####################
# set thread numbers
# set to $Total_logical_Processors may lead to CPU overload
$Total_logical_Processors = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
# $Thread_num = 8
$Thread_num = $Total_logical_Processors 
$src_yuv_dir = "\\pub\staff\derek.you\2019-07-30-FullhanSrc\420"
# $VMAF = $true
$VMAF = $false
$frames_to_be_encoded = 15
$GOP = 1
#################### configuration part end ####################


#################### function part ####################
function StartTaskPool {
	Param
	(
		$TaskPool,
		$parallelcount = 1
	)
	# 移除本次会话中已有的所有后台任务
	Remove-Job *
	# 使用变量 $TaskInPool 保存还没有执行完成的任务数
	$TaskInPool = $TaskPool.Length
	# 判断设定的并行任务数是否超过当前任务队列中的任务数
	if ($parallelCount -gt $TaskPool.Length) {
		$parallelCount = $TaskPool.Length
	}
	# init tasks
	foreach ($i in 1..$parallelCount) {
		Start-Job $TaskPool[$i - 1] -Name $task_name_list[$i - 1] | Out-Null
		Write-Host "Start" $task_name_list[$i - 1] "( No."($i)")"
	}
	$nextIndex = $parallelCount
    
	# pooling
	while (($nextIndex -lt $TaskPool.Length) -or ($TaskInPool -gt 0)) {
		foreach ($job in Get-Job) {
			$state = [string]$job.State
			if ($state -eq "Completed") {   
				# Receive-Job $job | Out-Null
				# Get-Job $job.Id 
				Write-Host "Complete" $job.Name -ForegroundColor Green
				Remove-Job $job
				$TaskInPool--
				if ($nextIndex -lt $TaskPool.Length) {
					Start-Job $TaskPool[$nextIndex] -Name $task_name_list[$nextIndex] | Out-Null
					Write-Host "Start" $task_name_list[$nextIndex] "( No."($nextIndex + 1)")"
					$nextIndex++
				}
			}
		}
		sleep 1
	} 
}
#################### function part end ####################


#################### Encode script part ####################
# Tic
$startTime = Get-Date
# encoder need this cfg file...
if (-not (Test-Path ..\seq\hevc_encoder.cfg)) { Write-Error "File ..\seq\hevc_encoder.cfg doesn't exist."; Pause; return -1 } 
if (Test-Path enc_info.txt) { rm enc_info.txt } 
if (Test-Path dec_info.txt) { rm dec_info.txt } 
if (-not (Test-Path ..\Result)) { mkdir ..\Result | Out-Null }
rm ..\Result\* -Recurse
$test_root_dir = pwd

# get yuv file list and sort it like windows explorer
$ToNatural = { [regex]::Replace($_, '^\d+', { $args[0].Value.PadLeft(20) }) }
$src_yuv_list = ls -Path $src_yuv_dir -Filter "*.yuv" | Sort-Object $ToNatural
$src_yuv_list = $src_yuv_list.Name -replace ".yuv", ""

# init task (string)
$task_str = {}
$task_name = ""
foreach ($yuv_file in $src_yuv_list) {
	if (Test-Path $yuv_file) { rm $yuv_file -Recurse } 
	mkdir $yuv_file\seq | Out-Null
	cp ..\seq\hevc_encoder.cfg $yuv_file\seq 
	foreach ($QP in (22, 27, 32, 37)) {
		cd $test_root_dir
		mkdir $yuv_file\$QP | Out-Null

		$task_str = $task_str.ToString()
		if ( -not ( [String]::IsNullOrEmpty( $task_str ))) { $task_str += "`n" }
		$task_str += "cd $test_root_dir\$yuv_file\$QP; $test_root_dir\HEVC_encoder.exe -i $src_yuv_dir\$yuv_file.yuv -w 1920 -h 1088 -f $frames_to_be_encoded -gop $GOP -qp $QP; $test_root_dir\TAppDecoder_YUV.exe -b test_enc.h265 -o dec.yuv; $test_root_dir\md5.exe -n dec.yuv > dec_yuv.md5;" 
		if ($VMAF) { $task_str += "$test_root_dir\vmaf.exe -r $src_yuv_dir\$yuv_file.yuv -d dec.yuv -w 1920 -h 1088 -p 420 -b 8 -o vmaf.csv --csv; " }
		# log Enc task name
		if ( -not ( [String]::IsNullOrEmpty( $task_name ))) { $task_name += "`n" }
		$task_name += $yuv_file + "_QP" + $QP 
	}
}
# log Enc task name
$task_name_list = $task_name -split "[\n]+"

# convert task string list to ScriptBlock list
$task_list = $task_str -split "[\n]+"
$generate_scriptblock_cmd = "[ScriptBlock]::Create(`$task_list[0])"
for ($i = 1; $i -lt $task_list.Length; $i++) {
	$generate_scriptblock_cmd = $generate_scriptblock_cmd + ", [ScriptBlock]::Create(`$task_list[$i])"
}
$enc_pool = Invoke-Expression $generate_scriptblock_cmd

StartTaskPool -TaskPool $enc_pool -parallelcount $Thread_num
#################### Encode script part end ####################


#################### Post Process part ####################
foreach ($yuv_file in $src_yuv_list) {
	foreach ($QP in (22, 27, 32, 37)) {
		cd $test_root_dir\$yuv_file\$QP
		if (-not ((Test-Path rec_yuv.md5) -and (Test-Path dec_yuv.md5))) { 
			Add-Content $test_root_dir\enc_info.txt "$yuv_file`_qp$QP		 LOST (MD5 checksum file doesn't exist) " 
		} 
		else {
			$md5_rec = Get-Content rec_yuv.md5 
			$md5_dec = Get-Content dec_yuv.md5
			if ($md5_rec -eq $md5_dec) {
				Add-Content $test_root_dir\enc_info.txt "$yuv_file`_qp$QP		 OK " 
			}
			else {
				Add-Content $test_root_dir\enc_info.txt "$yuv_file`_qp$QP		 DIFF " 
			}
		}

		mv test_enc.h265 "$test_root_dir\$yuv_file\$yuv_file`_qp$QP.h265"
		mv dec.yuv "$test_root_dir\$yuv_file\$yuv_file`_dec_qp$QP.yuv"
		if ((Test-Path rec_yuv.md5) -and (Test-Path dec_yuv.md5)) { mv rec_yuv.md5 "$test_root_dir\$yuv_file\$yuv_file`_qp$QP.md5" }
		mv stats_out.log "$test_root_dir\$yuv_file\$yuv_file`_qp$QP`_enc.log"
		mv stats_out.csv "$test_root_dir\$yuv_file\$yuv_file`_qp$QP.csv"
		if ($VMAF) { mv vmaf.csv "$test_root_dir\$yuv_file\$yuv_file`_qp$QP`_vmaf.csv" }
		cd $test_root_dir; rm $test_root_dir\$yuv_file\$QP -Recurse
	}
	rm $test_root_dir\$yuv_file\seq -Recurse
	cd $test_root_dir; mv $test_root_dir\$yuv_file $test_root_dir\..\Result 
}
mv $test_root_dir\enc_info.txt $test_root_dir\..\Result
cp $test_root_dir\HEVC_encoder.exe $test_root_dir\..\Result
$datetime = Get-Date -Format "_yyyy_MM_dd_HHmm"
mv $test_root_dir\..\Result "$test_root_dir\..\Result$datetime"

# run parse script
cp "$test_root_dir\..\Parse$frames_to_be_encoded.ps1" "$test_root_dir\..\Result$datetime"
cd "$test_root_dir\..\Result$datetime"
Invoke-Expression ".\Parse$frames_to_be_encoded.ps1"
cd $test_root_dir

# Toc
Write-Host "All Completed! Total Seconds:" (New-TimeSpan $startTime).totalseconds -ForegroundColor Green
# Pause 
#################### Post Process part end ####################


#################### About part ####################
# Windows 可能阻止脚本运行，需要设置用户运行脚本的策略
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# 此外 运行脚本时有可能提醒是否重置策略 选择默认否即可

# 关闭脚本运行窗口后，当前已在池中的线程（Start-Job）会继续运行到结束；未加入池中的任务不会继续运行
# 需要打开任务管理器手动结束编码器进程，或任其运行结束
#################### About part end ####################