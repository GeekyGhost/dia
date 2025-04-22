@echo off
setlocal EnableDelayedExpansion

:: Set variables
set VENV_DIR=venv
set REQUIREMENTS_URL=https://github.com/GeekyGhost/dia.git
set APP_FILE=app.py

:: Check if Python is installed
where python >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed or not in PATH. Please install Python 3.8 or higher.
    pause
    exit /b 1
)

:: Check if virtual environment exists, create if it doesn't
if not exist "%VENV_DIR%\Scripts\activate.bat" (
    echo Creating virtual environment...
    python -m venv %VENV_DIR%
    if %ERRORLEVEL% neq 0 (
        echo Failed to create virtual environment.
        pause
        exit /b 1
    )
)

:: Activate virtual environment
echo Activating virtual environment...
call %VENV_DIR%\Scripts\activate.bat
if %ERRORLEVEL% neq 0 (
    echo Failed to activate virtual environment.
    pause
    exit /b 1
)

:: Install requirements from the git repository
echo Installing requirements...
pip install git+%REQUIREMENTS_URL%
if %ERRORLEVEL% neq 0 (
    echo Failed to install requirements.
    pause
    exit /b 1
)

:: Check if app.py exists
if not exist "%APP_FILE%" (
    echo %APP_FILE% not found in the current directory.
    pause
    exit /b 1
)

:: Run the application
echo Starting the application...
python %APP_FILE%
if %ERRORLEVEL% neq 0 (
    echo Failed to start the application.
    pause
    exit /b 1
)

:: Deactivate virtual environment
deactivate

echo Application closed.
pause