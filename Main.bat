@echo off
setlocal enabledelayedexpansion

REM Prompt the user for an IP address
set /p IP_ADDRESS=Enter the IP address: 

REM Use curl to fetch the IP information from ipinfo.io
curl -s "https://ipinfo.io/%IP_ADDRESS%/json" > ipinfo.json

REM Check if the JSON response is empty (indicating an invalid IP)
for %%i in (ipinfo.json) do (
    set "file=%%~zi"
    if !file! equ 0 (
        echo Invalid IP address or no information found.
        goto :end
    )
)

REM Parse and display the JSON response
for /f "tokens=*" %%a in (ipinfo.json) do (
    set "line=%%a"
    echo !line!
)

:end
REM Clean up the temporary JSON file
del ipinfo.json

endlocal
