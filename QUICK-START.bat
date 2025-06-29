@echo off
echo ===========================================
echo KodeDeeAI Quick Start Guide
echo ===========================================
echo.

echo [Step 1] Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is not installed!
    echo Please install Node.js 18+ from https://nodejs.org
    pause
    exit /b 1
)
echo Node.js is installed ✓

echo.
echo [Step 2] Checking Git installation...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Warning: Git is not installed
    echo Install Git from https://git-scm.com for version control
)

echo.
echo [Step 3] Installing dependencies...
echo Installing root dependencies...
call npm install
if %errorlevel% neq 0 (
    echo Error: Failed to install root dependencies
    pause
    exit /b 1
)

echo Installing frontend dependencies...
cd webapp\frontend
call npm install
if %errorlevel% neq 0 (
    echo Error: Failed to install frontend dependencies
    pause
    exit /b 1
)
cd ..\..

echo Installing backend dependencies...
cd webapp\backend
call npm install
if %errorlevel% neq 0 (
    echo Error: Failed to install backend dependencies
    pause
    exit /b 1
)
cd ..\..

echo Dependencies installed successfully ✓

echo.
echo [Step 4] Setting up environment files...
if not exist "webapp\backend\.env" (
    echo Creating backend .env file...
    (
        echo NODE_ENV=development
        echo PORT=3000
        echo MONGODB_URI=mongodb://localhost:27017/kodedeeai
        echo JWT_SECRET=your-secret-key-change-in-production
        echo STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key
        echo STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
        echo STRIPE_WEBHOOK_SECRET=whsec_your_webhook_secret
        echo SENDGRID_API_KEY=SG.your_sendgrid_api_key
        echo FRONTEND_URL=http://localhost:5173
    ) > webapp\backend\.env
    echo Backend .env file created ✓
) else (
    echo Backend .env file already exists ✓
)

if not exist "webapp\frontend\.env" (
    echo Creating frontend .env file...
    (
        echo VITE_API_URL=http://localhost:3000/api
        echo VITE_STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key
        echo VITE_APP_NAME=KodeDeeAI
        echo VITE_APP_VERSION=1.0.0
    ) > webapp\frontend\.env
    echo Frontend .env file created ✓
) else (
    echo Frontend .env file already exists ✓
)

echo.
echo ===========================================
echo Setup Complete! 🎉
echo ===========================================
echo.
echo What you can do now:
echo.
echo 1. Start Development:
echo    npm run dev
echo.
echo 2. Build for Production:
echo    npm run build
echo.
echo 3. Initialize Git Repository:
echo    init-git.bat
echo.
echo 4. View Documentation:
echo    - README.md (Project overview)
echo    - LOVABLE-INTEGRATION.md (Lovable.dev setup)
echo    - COMPLETE-DEPLOYMENT-GUIDE.md (Production deployment)
echo.
echo 5. Configure Services:
echo    - MongoDB: Install and start MongoDB
echo    - Stripe: Get API keys from dashboard
echo    - SendGrid: Get API key for email
echo.
echo 6. Test n8n Workflows:
echo    - Import JSON files from n8n-flows/ folder
echo    - Configure webhook URLs in n8n
echo.
echo URLs after starting:
echo - Frontend: http://localhost:5173
echo - Backend API: http://localhost:3000
echo - API Documentation: http://localhost:3000/api/docs
echo.
echo Need help?
echo - Read TROUBLESHOOTING.md
echo - Check GitHub issues
echo - Contact: support@kodedeeai.com
echo.

set /p START_NOW=Do you want to start the development server now? (y/n): 
if /i "%START_NOW%"=="y" (
    echo.
    echo Starting development servers...
    echo Frontend will open at: http://localhost:5173
    echo Backend API will run at: http://localhost:3000
    echo.
    npm run dev
) else (
    echo.
    echo To start development later, run: npm run dev
    echo.
)

pause
