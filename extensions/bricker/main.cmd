@echo off
chcp 65001>nul





if "%1" == "start" (
  for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z exit

  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDesktop            /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoControlPanel       /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRun                /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableCMD           /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableTaskMgr       /t REG_DWORD /d 1 /f >nul
  rem for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableRegistryTools /t REG_DWORD /d 1 /f >nul
) else if "%1" == "remove" (
  for /l %%i in (1,1,4) do infDefaultInstall "%~dp0unHookExec.inf"
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDesktop      /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoControlPanel /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRun          /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableCMD     /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableTaskMgr /t REG_DWORD /d 0 /f >nul
) else exit





for /l %%i in (1,1,4) do gpupdate /force >nul

rem for /l %%i in (1,1,4) do taskkill /f /im explorer.exe >nul
rem timeout /nobreak /t 1 >nul
rem start "" "%winDir%\explorer.exe"

ie4uinit.exe -show
ie4uinit.exe -ClearIconCache
timeout /nobreak /t 1 >nul
for %%i in (brndlog.bak brndlog.txt ie4uinit-ClearIconCache.log ie4uinit-show.log ie4uinit-UserConfig.log) do if exist "%localAppData%\Microsoft\Internet Explorer\%%i" del /q "%localAppData%\Microsoft\Internet Explorer\%%i"
exit