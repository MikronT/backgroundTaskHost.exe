@echo off
chcp 65001>nul





if "%1" == "start" (
  for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit

  reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /t REG_SZ /d "%~dp0lnk.ico" /f >nul 2>nul
) else if "%1" == "remove" (
  reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul 2>nul
) else exit





rem for /l %%i in (1,1,4) do taskkill /f /im explorer.exe >nul
rem timeout /nobreak /t 1 >nul
rem start "" "%winDir%\explorer.exe"

ie4uinit.exe -show
ie4uinit.exe -ClearIconCache
timeout /nobreak /t 1 >nul
for %%i in (brndlog.bak brndlog.txt ie4uinit-ClearIconCache.log ie4uinit-show.log ie4uinit-UserConfig.log) do if exist "%localAppData%\Microsoft\Internet Explorer\%%i" del /q "%localAppData%\Microsoft\Internet Explorer\%%i"
exit