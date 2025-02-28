@echo off
setlocal enabledelayedexpansion

set "TARGET_DIR=/data/data/com.rekoo.pubgm/lib"
set "OUTPUT_DIR=%CD%"
set "OLD_LIST="

:loop
::
for /f "tokens=*" %%a in ('adb shell ls %TARGET_DIR% 2^>nul') do (
    set "NEW_LIST=!NEW_LIST! %%a"
)

:: 
for %%b in (!NEW_LIST!) do (
    echo !OLD_LIST! | find "%%b" >nul
    if errorlevel 1 (
        echo [+] New file pulled: %%b
        adb pull %TARGET_DIR%/%%b %OUTPUT_DIR%
    )
)

:: 
set "OLD_LIST=!NEW_LIST!"
set "NEW_LIST="
timeout /t 1 /nobreak >nul
goto loop