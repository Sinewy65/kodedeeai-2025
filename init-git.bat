@echo off
echo ===========================================
echo KodeDeeAI Git Repository Setup
echo ===========================================
echo.

echo [1/7] Initializing Git repository...
git init
if %errorlevel% neq 0 (
    echo Error: Failed to initialize Git repository
    echo Make sure Git is installed and accessible
    pause
    exit /b 1
)
echo Git repository initialized successfully!

echo.
echo [2/7] Adding all files to Git...
git add .
if %errorlevel% neq 0 (
    echo Error: Failed to add files to Git
    pause
    exit /b 1
)
echo Files added to Git successfully!

echo.
echo [3/7] Creating initial commit...
git commit -m "Initial commit: KodeDeeAI Multi-Service Platform"
if %errorlevel% neq 0 (
    echo Error: Failed to create initial commit
    pause
    exit /b 1
)
echo Initial commit created successfully!

echo.
echo [4/7] Setting up Git configuration...
echo Please enter your Git user name:
set /p GIT_NAME=
git config user.name "%GIT_NAME%"

echo Please enter your Git email:
set /p GIT_EMAIL=
git config user.email "%GIT_EMAIL%"

echo Git configuration set successfully!

echo.
echo [5/7] Creating development branch...
git checkout -b development
git checkout main
echo Development branch created!

echo.
echo [6/7] Setting up remote repository...
echo Please enter your GitHub repository URL:
echo Example: https://github.com/username/kodedeeai-project.git
set /p REPO_URL=
git remote add origin %REPO_URL%
if %errorlevel% neq 0 (
    echo Warning: Failed to add remote repository
    echo You can add it later with: git remote add origin [URL]
) else (
    echo Remote repository added successfully!
)

echo.
echo [7/7] Pushing to GitHub...
set /p PUSH_NOW=Do you want to push to GitHub now? (y/n): 
if /i "%PUSH_NOW%"=="y" (
    git push -u origin main
    if %errorlevel% neq 0 (
        echo Warning: Failed to push to GitHub
        echo Please check your repository URL and permissions
    ) else (
        echo Code pushed to GitHub successfully!
    )
) else (
    echo Skipping GitHub push. You can push later with: git push -u origin main
)

echo.
echo ===========================================
echo Git setup completed!
echo ===========================================
echo.
echo Your repository is ready for:
echo - Collaborative development
echo - Lovable.dev integration
echo - CI/CD pipelines
echo - Issue tracking
echo.
echo Next steps for Lovable.dev:
echo 1. Go to https://lovable.dev
echo 2. Connect your GitHub repository
echo 3. Import the project
echo 4. Start building with AI assistance
echo.
pause
