New-Item -ItemType Directory -Force -Path ./merged
"$datetime = Get-Date -Format ""yyyy_MM_dd_HHmm"""

Get-ChildItem -Filter ./*.csv | Select-Object -ExpandProperty FullName | Import-Csv | Export-Csv ./merged/$datetime`_merged.csv -NoTypeInformation -Append
