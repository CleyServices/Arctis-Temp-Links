@echo off
:: request administrator privileges
DISM >nul 2>&1 || (
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo error: right-click on the "%~f0" script and select "Run as administrator"
        pause
    )
    exit /b 1
)

:: start tweaking for Mouse
bcdedit /set nx AlwaysOff
bcdedit /set disabledynamictick yes
bcdedit /deletevalue useplatformclock
bcdedit /deletevalue useplatformtick

::Disable mouse accel
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f

::Mouse Fix
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d "10" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v SmoothMouseXCurve /t REG_BINARY /d "00,00,00,00,00,00,00,00,C0,CC,0C,00,00,00,00,00,80,99,19,00,00,00,00,00,40,66,26,00,00,00,00,00,00,33,33,00,00,00,00,00" /f
reg add "HKEY_CURRENT_USER\Control Panel\Mouse" /v SmoothMouseYCurve /t REG_BINARY /d "00,00,00,00,00,00,00,00,00,00,38,00,00,00,00,00,00,00,70,00,00,00,00,00,00,00,00,00,A8,00,00,00,00,00,00,00,00,E0,00,00,00,00,00,00" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d "0" /f
reg add "HKEY_USERS\.DEFAULT\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d "0" /f
