Add-Type -AssemblyName System.Drawing

Get-ChildItem ./ -Filter *.jpg | ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    $wxh = [String]$img.Width + "x" + [String]$img.Height

    $src_name = $_.BaseName
    if (-not ($src_name -match $wxh)) {
        $appended_name = $src_name + "_" + $wxh + ".jpg"
        if (-not (Test-Path $appended_name)) {
            Copy-Item -Path $_.FullName -Destination $appended_name 
            Write-Host "$appended_name copy."
        }
        # else {
        #     Write-Warning "$appended_name already exists."
        # }
    }
    # else {
    #     Write-Warning "$src_name no need process."
    # }
}

Pause