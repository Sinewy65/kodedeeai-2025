@echo off
echo ===========================================
echo KodeDeeAI Project Setup Script
echo ===========================================
echo.

echo [1/6] Moving frontend files...
if exist "..\frontend" (
    echo Copying frontend files to webapp/frontend/...
    xcopy "..\frontend\*" "webapp\frontend\" /E /H /Y /I
    echo Frontend files copied successfully!
) else (
    echo Warning: Frontend folder not found!
)

echo.
echo [2/6] Moving backend files...
if exist "..\backend" (
    echo Copying backend files to webapp/backend/...
    xcopy "..\backend\*" "webapp\backend\" /E /H /Y /I
    echo Backend files copied successfully!
) else (
    echo Warning: Backend folder not found!
)

echo.
echo [3/6] Moving documentation files...
if exist "..\*.md" (
    echo Copying documentation files to docs/...
    copy "..\*.md" "docs\" >nul 2>&1
    echo Documentation files copied successfully!
)

echo.
echo [4/6] Moving script files...
if exist "..\*.bat" (
    echo Copying script files to scripts/...
    copy "..\*.bat" "scripts\" >nul 2>&1
    echo Script files copied successfully!
)

if exist "..\*.ps1" (
    echo Copying PowerShell scripts to scripts/...
    copy "..\*.ps1" "scripts\" >nul 2>&1
    echo PowerShell scripts copied successfully!
)

echo.
echo [5/6] Moving n8n workflow files...
if exist "..\n8n-flows" (
    echo Copying n8n workflows to n8n-flows/...
    xcopy "..\n8n-flows\*" "n8n-flows\" /E /H /Y /I
    echo n8n workflow files copied successfully!
) else (
    echo Warning: n8n-flows folder not found!
)

echo.
echo [6/6] Installing dependencies...
echo Installing root dependencies...
npm install
echo.

echo Installing frontend dependencies...
cd webapp\frontend
npm install
cd ..\..

echo.
echo Installing backend dependencies...
cd webapp\backend
npm install
cd ..\..

echo.
echo ===========================================
echo Setup completed successfully! 
echo ===========================================
echo.
echo Next steps:
echo 1. Run 'git init' to initialize Git repository
echo 2. Run 'git add .' to stage all files
echo 3. Run 'git commit -m "Initial commit"' to create first commit
echo 4. Create GitHub repository and push code
echo 5. Connect to Lovable.dev for UI development
echo.
echo To start development:
echo - Run 'npm run dev' for development mode
echo - Run 'npm run build' to build for production
echo - Run 'npm start' to run production server
echo.
pause
