@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Drag and drop a text file onto this batch file.
    pause
    exit /b
)

set "tempFile=%temp%\tempfile.txt"

if exist "%tempFile%" del "%tempFile%"

for /f "usebackq tokens=* delims=" %%A in ("%~1") do (
    set "line=%%A"
    set "first_word=!line:~0,4!"

    echo !first_word! | findstr /i /b /c:"show" /c:"hide" /c:"scene" /c:"with" >nul

    if errorlevel 1 (
        echo !line!>>"%tempFile%"
    )
)
move /y "%tempFile%" "%~1" >nul
echo Processing complete.
pause
