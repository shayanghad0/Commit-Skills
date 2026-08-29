@echo off
setlocal enabledelayedexpansion

REM ============================================================
REM Commit Skills Installer (Windows)
REM Installs the commit-skills skill to all supported CLI tools.
REM
REM Supported CLI tools:
REM - Claude Code (%USERPROFILE%\.claude\skills\)
REM - OpenCode (%USERPROFILE%\.agents\skills\)
REM - OpenCode Config (%USERPROFILE%\.config\opencode\skills\)
REM
REM Usage:
REM   install.bat                  Install to all detected CLI tools
REM   install.bat /dir "C:\path"   Install to a custom directory
REM   install.bat /uninstall       Remove the skill from all CLI tools
REM ============================================================

set "SKILL_DIR=commit-skills"
set "SKILL_FILES=skill.md Ai-commit.md Ai-list.md"

REM Get script directory
set "SCRIPT_DIR=%~dp0"

REM Parse arguments
if /i "%~1"=="/uninstall" goto :uninstall
if /i "%~1"=="/dir" goto :install_custom

REM Default: install to all detected locations
goto :install_all

:install_all
echo ==================================================
echo Commit Skills Installer
echo ==================================================
echo.

REM Check source files
echo Checking source files...
set "MISSING=0"
for %%f in (%SKILL_FILES%) do (
    if not exist "%SCRIPT_DIR%%%f" (
        echo   X %%f (not found)
        set "MISSING=1"
    )
)
if "%MISSING%"=="1" (
    echo.
    echo Error: Missing source files.
    echo Make sure you run this script from the commit-skills directory.
    exit /b 1
)
echo   All source files found
echo.

REM Detect CLI tools
set "COUNT=0"

REM Claude Code
if exist "%USERPROFILE%\.claude\skills" (
    echo Detected: Claude Code
    call :install_one "%USERPROFILE%\.claude\skills"
    set /a COUNT+=1
)

REM OpenCode
if exist "%USERPROFILE%\.agents\skills" (
    echo Detected: OpenCode
    call :install_one "%USERPROFILE%\.agents\skills"
    set /a COUNT+=1
)

REM OpenCode Config
if exist "%USERPROFILE%\.config\opencode\skills" (
    echo Detected: OpenCode Config
    call :install_one "%USERPROFILE%\.config\opencode\skills"
    set /a COUNT+=1
)

if "%COUNT%"=="0" (
    echo No CLI tools detected.
    echo Use /dir "C:\path" to install to a custom directory.
    exit /b 1
)

echo.
echo ==================================================
echo Successfully installed to %COUNT% location(s)
echo ==================================================
echo Restart your CLI if needed, then test with: commit
exit /b 0

:install_one
REM Install to a single skills directory
set "TARGET=%~1\%SKILL_DIR%"
if not exist "%TARGET%" mkdir "%TARGET%"
for %%f in (%SKILL_FILES%) do (
    if exist "%SCRIPT_DIR%%%f" (
        copy /y "%SCRIPT_DIR%%%f" "%TARGET%\" >nul
        echo   + %%f
    ) else (
        echo   X %%f (not found)
    )
)
echo   Installed to: %TARGET%
echo.
goto :eof

:install_custom
REM Install to a custom directory
if "%~2"=="" (
    echo Error: /dir requires a path.
    echo Usage: install.bat /dir "C:\path\to\skills"
    exit /b 1
)
echo ==================================================
echo Commit Skills Installer
echo ==================================================
echo.
echo Installing to custom directory: %~2
call :install_one "%~2"
echo ==================================================
echo Done
exit /b 0

:uninstall
echo ==================================================
echo Commit Skills Uninstaller
echo ==================================================
echo.

set "COUNT=0"

REM Claude Code
if exist "%USERPROFILE%\.claude\skills\%SKILL_DIR%" (
    echo Removing from: %USERPROFILE%\.claude\skills
    rmdir /s /q "%USERPROFILE%\.claude\skills\%SKILL_DIR%"
    echo   Removed
    set /a COUNT+=1
)

REM OpenCode
if exist "%USERPROFILE%\.agents\skills\%SKILL_DIR%" (
    echo Removing from: %USERPROFILE%\.agents\skills
    rmdir /s /q "%USERPROFILE%\.agents\skills\%SKILL_DIR%"
    echo   Removed
    set /a COUNT+=1
)

REM OpenCode Config
if exist "%USERPROFILE%\.config\opencode\skills\%SKILL_DIR%" (
    echo Removing from: %USERPROFILE%\.config\opencode\skills
    rmdir /s /q "%USERPROFILE%\.config\opencode\skills\%SKILL_DIR%"
    echo   Removed
    set /a COUNT+=1
)

echo.
echo ==================================================
echo Removed from %COUNT% location(s)
echo ==================================================
exit /b 0
