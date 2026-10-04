@echo off
TITLE WACRM Development Launcher
COLOR 0A

echo ===================================================
echo        Starting WACRM Development Environment
echo ===================================================
echo.

:: Check Node.js installation
where node >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Node.js is not installed or not in PATH.
    echo Please install Node.js 20+ from https://nodejs.org/
    pause
    exit /b 1
)

echo [1/3] Launching Next.js Dev Server on http://localhost:3000 ...
start "WACRM Next.js Server" cmd /k "npm run dev"

echo [2/3] Launching Cloudflare Tunnel on http://127.0.0.1:3000 ...
start "WACRM Cloudflare Tunnel" cmd /k "npx -y cloudflared tunnel --url http://127.0.0.1:3000"

echo.
echo [3/3] Waiting for servers to initialize...
timeout /t 5 /nobreak >nul

echo.
echo ===================================================
echo  WACRM is starting!
echo  - Local CRM: http://localhost:3000
echo  - Tunnel Window: Copy your .trycloudflare.com URL
echo    for your Meta Webhook configuration.
echo ===================================================
echo.

:: Open local CRM in default browser
start http://localhost:3000

exit /b 0
