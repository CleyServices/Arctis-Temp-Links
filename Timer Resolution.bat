@echo off
title Timer Resolution Setup
color 0B
cd /D "%~dp0"
cls

IF EXIST "C:\SetTimerResolution.exe" (
    IF EXIST "C:\SetTimerResolutionService.exe" (
        goto Remove
    ) else (
        goto Install
    )
)

:Remove
echo Removing previous Timer Resolution...
net stop "STR" >nul 2>&1
sc delete STR >nul 2>&1
del /q "C:\SetTimerResolutionService.exe" >nul 2>&1
del /q "C:\SetTimerResolutionService" >nul 2>&1
taskkill /f /im SetTimerResolution.exe >nul 2>&1
del /q "C:\SetTimerResolution.exe" >nul 2>&1
timeout /t 3 >nul
cls
goto Install

:Install
echo Copying Timer Resolution to C:\...
copy "SetTimerResolution.exe" "C:\SetTimerResolution.exe" /y
timeout /t 5 >nul
cls

echo Creating startup shortcut...
powershell -command "$WScriptShell = New-Object -ComObject WScript.Shell; $Shortcut = $WScriptShell.CreateShortcut([System.Environment]::GetFolderPath('Startup') + '\SetTimerResolution.lnk'); $Shortcut.TargetPath = 'C:\SetTimerResolution.exe'; $Shortcut.Arguments = '--resolution 5070 --no-console'; $Shortcut.Save()"
timeout /t 3 >nul
cls

echo Finished
timeout /t 3 >nul
exit
