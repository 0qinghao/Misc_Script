param (
    [string]$folderPath
)

# 获取脚本文件所在的目录
if (-not $folderPath) {
    $folderPath = Split-Path -Parent $MyInvocation.MyCommand.Path
}
echo "$folderPath"

Add-Type -AssemblyName System.Drawing

function Get-ImageFormat {
    param (
        [string]$filePath
    )

    $fileStream = [System.IO.File]::OpenRead($filePath)
    $reader = New-Object System.IO.BinaryReader($fileStream)

    # 读取前8个字节
    $bytes = $reader.ReadBytes(8)

    $fileStream.Close()

    # 把字节转换为字符串格式的十六进制
    $hexString = -join ($bytes | ForEach-Object { $_.ToString("X2") })

    # 根据魔术数判断文件格式
    switch ($hexString) {
        { $_ -like 'FFD8FF*' } { return "JPEG" }
        { $_ -like '89504E47*' } { return "PNG" }
        { $_ -like '47494638*' } { return "GIF" }
        { $_ -like '424D*' } { return "BMP" }
        { $_ -like '49492A00*' -or $_ -like '4D4D002A*' } { return "TIFF" }
        default { return "Unknown" }
    }
}

# 获取指定目录中的所有指定格式的图片文件
Get-ChildItem -Path "$folderPath" | Where-Object { $_.Extension -match '(?i)\.(jpg|jpeg|png|gif|bmp|tiff)$' } | ForEach-Object {
    $filePath = $_.FullName
    $baseName = $_.BaseName
    $extension = $_.Extension

    # 获取文件的实际格式
    $actualFormat = Get-ImageFormat -filePath $filePath

    # 扩展名和实际格式对照表
    $extensionFormatMap = @{
        '.jpg' = 'JPEG'
        '.jpeg' = 'JPEG'
        '.png' = 'PNG'
        '.gif' = 'GIF'
        '.bmp' = 'BMP'
        '.tiff' = 'TIFF'
        '.tif' = 'TIFF'
    }

    # 获取文件扩展名对应的格式
    $expectedFormat = $extensionFormatMap[$extension.ToLower()]

    # 检查扩展名和实际格式是否匹配
    if ($actualFormat -ne $expectedFormat) {
        Write-Warning "File '$filePath' extension '$extension' does not match its actual format '$actualFormat'."
    }
    
	$img = [System.Drawing.Image]::FromFile($filePath)
	$wxh = "$($img.Width)x$($img.Height)"
	$newName = "${baseName}_${wxh}${extension}"
	$newPath = Join-Path -Path $_.DirectoryName -ChildPath $newName

	# 检查文件名中是否已经包含宽高信息
	if ("$baseName" -notmatch $wxh) {
		# 如果文件不存在，则复制文件并更改文件名
		if (-not (Test-Path "$newPath")) {
			Copy-Item -Path "$filePath" -Destination "$newPath"
			Write-Host "$newPath copied."
		} else {
			Write-Warning "$newPath already exists."
		}
	} else {
		Write-Warning "$filePath no need process."
	}
}

Pause
