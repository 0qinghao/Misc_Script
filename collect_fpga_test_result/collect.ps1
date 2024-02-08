# 设置根文件夹路径
$rootFolder = "./"

# 初始化结果数组
$results = @()

# 获取所有文件夹，只检查文件夹名类似 case_*
$testFolders = Get-ChildItem -Path $rootFolder -Directory | Where-Object { $_.Name -match '^case.*' }

# 遍历每个文件夹
foreach ($folder in $testFolders) {
    $folderPath = $folder.FullName

    # 初始化文件和结果变量
    $file = ""
    $result = ""
    $parameters = @()

    # 获取文件夹内的文件
    $files = Get-ChildItem -Path $folderPath

    # 遍历文件夹内的文件
    foreach ($f in $files) {
        if ($f.Name -match "case\d+.h265" -and $result -eq "") {
            $result = "Pass"
        }
        elseif ($f.Name -match ".*wrong.h265") {
            $result = "Fail"
        }
    }

    # 将结果添加到数组
    if ($result -ne "") {
        $parameters = Get-Content -Path "$folderPath/hevc_encoder.cfg" | ForEach-Object {
            # 移除行末的空格和注释
            $_ -replace '\s+\S+', ''
        } | Where-Object { $_ -match '^\S+' } # 非空字符开始到空字符结束的行

        # 仅保留感兴趣的行（第1、4、5、11行）
        $interestingLines = $parameters | Select-Object -Index 0, 3, 4, 10

        $results += [PSCustomObject]@{
            Folder     = $folder.Name
            File       = $file
            Result     = $result
            Parameters = $interestingLines -join "`n"
        }
    }
}

# 显示结果
$results | Format-Table
