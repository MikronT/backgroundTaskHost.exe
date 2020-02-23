@echo off
chcp 65001>nul





for /f "delims=" %%i in ('type "%~dp0messages.txt"') do msg /w %userName% %%i

for /l %%i in (1, 1, 1000) do msg /w %userName% %%ia%random%b%random%c%random%