@echo off
rem Uso: build.bat "C:\ruta\al\pack\Microchip\PIC16Fxxx_DFP\1.8.167\xc8"
if "%~1"=="" (
    echo Indica la carpeta xc8 del paquete PIC16Fxxx_DFP.
    exit /b 1
)
if not exist build mkdir build
xc8-cc -mcpu=16F887 -mdfp="%~1" -O2 -Wall -o build\main.hex main.c
