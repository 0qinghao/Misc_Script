$excel = New-Object -ComObject excel.application
$excel.visible = $true
$excel.DisplayAlerts = $false;
$folderpath = ".\*.xls", ".\*.xlsx"
Get-ChildItem -Path $folderpath | 
ForEach-Object `
{
    $path = ($_.fullname).substring(0,($_.FullName).lastindexOf("."))
    $workbook = $excel.workbooks.open($_.fullname)

    $workbook.saveas($path, 6)
    $workbook.close()
}
$excel.Quit()
$excel = $null
[gc]::collect()
[gc]::WaitForPendingFinalizers()

