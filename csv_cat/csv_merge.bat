@echo off
setlocal
set first=1
>new.csv.tmp (
  for %%F in (*.csv) do (
    if defined first (
      type "%%F"
      set "first="
    ) else more +1 "%%F"
  )
)
ren new.csv.tmp merged.csv