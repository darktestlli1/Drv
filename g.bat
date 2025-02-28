@echo off
cls
adb kill-server
adb start-server
adb.exe devices
adb root
adb logcat -c

:loop
adb logcat -d | findstr "13G17GJG7173HYHYG" > nul 2>&1
if %errorlevel% equ 0 goto cleanup

timeout /t 2 > nul
goto loop

:cleanup
echo Detected target log, performing cleanup...
adb shell rm -rf /data/data/%pkg%/lib/libGVoicePlugin.so
adb shell rm -rf /data/data/%pkg%/lib/libCasa.so
echo Cleanup done.
exit
