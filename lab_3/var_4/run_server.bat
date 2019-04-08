@echo off

set FLASK_DEBUG=0
set FLASK_APP=flask_server.py
if "%1"=="/D" set FLASK_DEBUG=1
if "%1"=="-d" set FLASK_DEBUG=1
if "%1"=="--debug" set FLASK_DEBUG=1

python -m flask run --host=0.0.0.0