@echo off
chcp 65001>nul





setlocal EnableDelayedExpansion

for /f "delims=" %%i in ('type "%~dp0messages.txt"') do msg /w %userName% %%i

for /l %%i in (1, 1, 1000000000) do (
  if exist "%path_desktop%\%app_date%" exit
  if exist "%systemDrive%\%app_date%"  exit
  set message=%%ia!random!b!random!c!random!
  msg /w %userName% !message!
)