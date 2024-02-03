@echo off

:: Obtener la ruta actual del directorio
set "currentDir=%cd%"

:: Verificar si se está ejecutando como administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as Administrator
    echo.
    goto :admin
) else (
    echo Requesting Administrator Privileges...
    echo.
    goto :elevate
)

:elevate
:: Intentar reiniciar con privilegios elevados
powershell -Command "Start-Process cmd -ArgumentList '/c cd /d \"\"%currentDir%\"\" && \"%~f0\"' -Verb RunAs" >nul 2>&1
goto :eof

:admin
call .\Get-Info.cmd

:eof