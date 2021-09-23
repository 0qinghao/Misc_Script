Get-ChildItem *.y4m | ForEach-Object { ./ffmpeg -i $_ $_.name.replace($_.extension, ".yuv") }
