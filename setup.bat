@echo off
pip install pycaw
pip install hidapi

mklink ./Shortcuts/run.lnk run.bat

echo:
echo:

python configurator.py

echo:
echo:

echo Setup completed!

PAUSE