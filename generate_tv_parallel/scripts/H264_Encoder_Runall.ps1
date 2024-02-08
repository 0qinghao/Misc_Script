#################### configuration part ####################
# set thread numbers
# set to $Total_logical_Processors may lead to CPU overload
$Total_logical_Processors = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
# $Thread_num = 4
$Thread_num = $Total_logical_Processors 
$src_yuv_dir = "D:\src_yuv"
# $VMAF = $true
$VMAF = $false
$frames_to_be_encoded = 20
$GOP = 10
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
if (-not (Test-Path .\seq\h264_encoder.cfg)) { Write-Error "File .cfg doesn't exist."; Pause; return -1 } 
if (Test-Path enc_info.txt) { rm enc_info.txt } 
if (Test-Path dec_info.txt) { rm dec_info.txt } 
# if (-not (Test-Path ..\Result)) { mkdir ..\Result | Out-Null }
# rm ..\Result\* -Recurse
$test_root_dir = pwd

# get yuv file list and sort it like windows explorer
$ToNatural = { [regex]::Replace($_, '^\d+', { $args[0].Value.PadLeft(20) }) }
# $src_yuv_list = ls -Path $src_yuv_dir -Filter "*.yuv" | Sort-Object $ToNatural
$src_yuv_list = Get-ChildItem -Path $src_yuv_dir -Recurse -Filter *.yuv | Where-Object { $_.BaseName -like '*192x144*' } | Select-Object -First 10

# init task (string)
$task_str = {}
$task_name = ""
foreach ($yuv_file in $src_yuv_list) {
    $yuv_basename = $yuv_file.BaseName
    $yuv_fullname = $yuv_file.FullName

    if (Test-Path $yuv_basename) { rm $yuv_basename -Recurse } 
    mkdir $yuv_basename | Out-Null

    foreach ($QP in (22)) {
        # 只是用来构建目录
        cd $test_root_dir
        mkdir $yuv_basename\$QP\exe | Out-Null
        Copy-Item -Path ".\fbc_bin\" -Destination "$yuv_basename\$QP\exe" -Recurse
        Copy-Item -Path ".\seq\" -Destination "$yuv_basename\$QP" -Recurse
        $datetime = get-date -format "MMddHHmm"

        $task_str = $task_str.ToString()
        if ( -not ( [String]::IsNullOrEmpty( $task_str ))) { $task_str += "`n" }
        $task_str += "cd $test_root_dir\$yuv_basename\$QP\exe; $test_root_dir\H264_encoder.exe -i $yuv_fullname -w 192 -h 144 -f $frames_to_be_encoded -gop $GOP -qp $QP -rc 1 -tx 1 -rate 2000;" 
        $task_str += "mv $test_root_dir\$yuv_basename\test_vectors $test_root_dir\$yuv_basename\$datetime`_$yuv_basename; Compress-Archive -Path $test_root_dir\$yuv_basename\$datetime`_$yuv_basename -DestinationPath $test_root_dir\..\$datetime`_$yuv_basename`.zip; "
        # log Enc task name
        if ( -not ( [String]::IsNullOrEmpty( $task_name ))) { $task_name += "`n" }
        $task_name += $yuv_basename + "_QP" + $QP 
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

cd $test_root_dir
# Toc
Write-Host "All Completed! Total Seconds:" (New-TimeSpan $startTime).totalseconds -ForegroundColor Green
Pause 
#################### Post Process part end ####################


#################### About part ####################
# Windows 可能阻止脚本运行，需要设置用户运行脚本的策略
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# 此外 运行脚本时有可能提醒是否重置策略 选择默认否即可

# 关闭脚本运行窗口后，当前已在池中的线程（Start-Job）会继续运行到结束；未加入池中的任务不会继续运行
# 需要打开任务管理器手动结束编码器进程，或任其运行结束
#################### About part end ####################