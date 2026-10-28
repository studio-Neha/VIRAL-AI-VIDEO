@echo off
setlocal EnableDelayedExpansion
title Auto-Viral Social Engine v2 - Zero-Touch Full Auto Installer

echo ============================================================================
echo   AUTO-VIRAL SOCIAL MEDIA ENGINE v2 - ZERO-TOUCH FULL AUTO SETUP
echo ============================================================================
echo.

set "INSTALL_DIR=%USERPROFILE%\Desktop\Auto_Viral_Social_Engine_v2"
echo [1/6] Creating installation folder at: "%INSTALL_DIR%"
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo [2/6] Extracting all engine files automatically...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "$lines = Get-Content -LiteralPath '%~f0'; " ^
  "$idx = [Array]::IndexOf($lines, ':: === PAYLOAD_START ==='); " ^
  "$b64 = ($lines[($idx+1)..($lines.Length-1)] -join ''); " ^
  "$bytes = [Convert]::FromBase64String($b64); " ^
  "$zipFile = Join-Path $env:TEMP 'auto_viral_v2_payload.zip'; " ^
  "[IO.File]::WriteAllBytes($zipFile, $bytes); " ^
  "$extractTemp = Join-Path $env:TEMP 'auto_viral_v2_extracted'; " ^
  "if (Test-Path $extractTemp) { Remove-Item $extractTemp -Recurse -Force }; " ^
  "Expand-Archive -LiteralPath $zipFile -DestinationPath $extractTemp -Force; " ^
  "Copy-Item -Path (Join-Path $extractTemp 'Auto_Viral_Social_Engine_v2\*') -Destination '%INSTALL_DIR%' -Recurse -Force; " ^
  "Remove-Item $zipFile -Force -ErrorAction SilentlyContinue"

cd /d "%INSTALL_DIR%"

echo [3/6] Checking Python 3.11+ installation...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [Notice] Python not found in PATH. Auto-installing Python 3.11 via Windows Winget...
    winget install -e --id Python.Python.3.11 --scope user --silent --accept-package-agreements --accept-source-agreements
    set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"
)

python --version >nul 2>&1
if %errorlevel% neq 0 (
    if exist "%LOCALAPPDATA%\Programs\Python\Python311\python.exe" (
        set "PATH=%LOCALAPPDATA%\Programs\Python\Python311;%LOCALAPPDATA%\Programs\Python\Python311\Scripts;%PATH%"
    ) else if exist "%LOCALAPPDATA%\Programs\Python\Python312\python.exe" (
        set "PATH=%LOCALAPPDATA%\Programs\Python\Python312;%LOCALAPPDATA%\Programs\Python\Python312\Scripts;%PATH%"
    )
)

echo [4/6] Creating virtual environment and installing all required libraries...
if not exist "venv" (
    python -m venv venv
)
call venv\Scripts\activate
python -m pip install --upgrade pip --quiet
pip install -r requirements.txt

echo [5/6] Setting up Windows Daily Auto-Scheduler (12:00 PM & 8:00 PM Daily)...
schtasks /Create /TN "AutoViralSocialEngine_v2_Noon" /TR "\"%INSTALL_DIR%\RUN_DAILY_AUTO.bat\"" /SC DAILY /ST 12:00 /F >nul 2>&1
schtasks /Create /TN "AutoViralSocialEngine_v2_Evening" /TR "\"%INSTALL_DIR%\RUN_DAILY_AUTO.bat\"" /SC DAILY /ST 20:00 /F >nul 2>&1
if %errorlevel% equ 0 (
    echo    -^> Daily auto-run scheduled for 12:00 PM and 8:00 PM every day!
) else (
    echo    -^> Note: Could not register background task, run RUN_DAILY_AUTO.bat anytime.
)

echo [6/6] Running Auto-Viral Social Engine v2 right now to generate your first 1080x1920 MP4 Short...
python auto_viral_engine.py

echo.
echo ============================================================================
echo   SETUP & FIRST VIDEO COMPLETE!
echo   Folder Location : %INSTALL_DIR%
echo   Output Videos   : %INSTALL_DIR%\daily_viral_output
echo ============================================================================
if exist "%INSTALL_DIR%\daily_viral_output" (
    explorer "%INSTALL_DIR%\daily_viral_output"
)
pause
exit /b 0

:: === PAYLOAD_START ===
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
X1NvY2lhbF9FbmdpbmVfdjIvSU5TVEFMTF9BTkRfUlVOX1dJTkRPV1MuYmF0UEsBAhQDFAAAAAgA
FZ1cXdYT89jQEgAAaDQAADAAAAAAAAAAAAAAALSBvQYAAEF1dG9fVmlyYWxfU29jaWFsX0VuZ2lu
ZV92Mi9hdXRvX3ZpcmFsX2VuZ2luZS5weVBLAQIUAxQAAAAIABWdXF3nKz4YygMAAPMIAAAvAAAA
AAAAAAAAAAC0gdsZAABBdXRvX1ZpcmFsX1NvY2lhbF9FbmdpbmVfdjIveW91dHViZV91cGxvYWRl
ci5weVBLAQIUAxQAAAAIABWdXF1J7PwNOAIAAAIGAAAgAAAAAAAAAAAAAAC0gfIdAABBdXRvX1Zp
cmFsX1NvY2lhbF9FbmdpbmVfdjIvLmVudlBLAQIUAxQAAAAIABWdXF1J7PwNOAIAAAIGAAAoAAAA
AAAAAAAAAAC0gWggAABBdXRvX1ZpcmFsX1NvY2lhbF9FbmdpbmVfdjIvLmVudi5leGFtcGxlUEsB
AhQDFAAAAAgAFZ1cXQtY4mupAAAA/gAAACwAAAAAAAAAAAAAALSB5iIAAEF1dG9fVmlyYWxfU29j
aWFsX0VuZ2luZV92Mi9yZXF1aXJlbWVudHMudHh0UEsBAhQDFAAAAAgAFZ1cXf6W6kwIAgAAewQA
AD0AAAAAAAAAAAAAALSB2SMAAEF1dG9fVmlyYWxfU29jaWFsX0VuZ2luZV92Mi8uZ2l0aHViL3dv
cmtmbG93cy9kYWlseV92aXJhbC55bWxQSwUGAAAAAAkACQBFAwAAPCYAAAAA
