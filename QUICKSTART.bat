@echo off
REM Clinical Trial Intelligence - One-Click Setup (Windows)

echo.
echo Clinical Trial Risk Intelligence Platform
echo ===========================================
echo.
echo This script will:
echo   1. Create virtual environment
echo   2. Install all dependencies
echo   3. Collect clinical trial data (5-10 min)
echo   4. Engineer features
echo   5. Train ML models
echo   6. Launch dashboard
echo.
pause

REM Check Python
echo.
echo Checking Python version...
python --version

REM Create virtual environment
echo.
echo Creating virtual environment...
python -m venv venv
echo Virtual environment created

REM Activate virtual environment
echo.
echo Activating virtual environment...
call venv\Scripts\activate

REM Upgrade pip
echo.
echo Upgrading pip...
python -m pip install --quiet --upgrade pip

REM Install dependencies
echo.
echo Installing dependencies (this may take 2-3 minutes)...
pip install --quiet -r requirements.txt
echo Dependencies installed

REM Create data directories
echo.
echo Creating data directories...
if not exist "data\raw" mkdir data\raw
if not exist "data\processed" mkdir data\processed
if not exist "data\models" mkdir data\models
echo Directories created

REM Collect data
echo.
echo Collecting clinical trial data from ClinicalTrials.gov...
echo This will take 5-10 minutes (collecting 2,000 trials)...
python src\data_collection\collect_trials.py

REM Engineer features
echo.
echo Engineering features...
python src\features\engineer_features.py

REM Train models
echo.
echo Training machine learning models...
echo This will take 3-5 minutes...
python src\models\train_models.py

REM Success message
echo.
echo ==============================================
echo Setup Complete!
echo ==============================================
echo.
echo To launch the dashboard, run:
echo.
echo    venv\Scripts\activate
echo    streamlit run src\app\streamlit_app.py
echo.
echo The dashboard will open at: http://localhost:8501
echo.
echo ==============================================
pause
