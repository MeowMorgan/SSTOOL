@echo off
echo ========================================
echo   Checker Tool - PyInstaller Build
echo ========================================
echo.

:: Check Python
python --version >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Python not found! Install Python 3.10+ from python.org
    pause
    exit /b 1
)

:: Install dependencies
echo [*] Installing dependencies...
pip install pywebview pyinstaller --quiet

:: Build single exe
echo [*] Building Checker.exe (this takes 1-2 minutes)...
pyinstaller --onefile --noconsole --name "Checker" --icon "web\icon.ico" --add-data "web;web" app.py

if %ERRORLEVEL% neq 0 (
    echo [ERROR] Build failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   BUILD SUCCESSFUL!
echo ========================================
echo.
echo   Output: dist\Checker.exe
echo   Size: ~20MB
echo.
echo   This single .exe file contains everything.
echo   Send it to anyone - no installs needed!
echo.
echo ========================================
pause
