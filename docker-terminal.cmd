@ECHO OFF
TITLE Docker
SETLOCAL
SET DOCKER_MACHINE_EXE=docker-machine.exe
SET DOCKER_MACHINE_NAME=default

REM Search "docker-machine.exe"

WHERE %DOCKER_MACHINE_EXE% /Q
IF errorlevel 1 (
    ECHO Can't find "%DOCKER_MACHINE_EXE%".
    PAUSE
    GOTO END
)

REM Check docker host is running.
FOR /F "DELIMS=" %%a in ('%DOCKER_MACHINE_EXE% ls ^| FIND "%DOCKER_MACHINE_NAME%" ^| FIND "Running"') DO SET STATUS_CHECK=%%a
IF "%STATUS_CHECK%" neq "" ECHO "%DOCKER_MACHINE_NAME%" is already running. 
IF "%STATUS_CHECK%" equ "" (%DOCKER_MACHINE_EXE% start %DOCKER_MACHINE_NAME%)

FOR /F "DELIMS=" %%a in ('%DOCKER_MACHINE_EXE% ip %DOCKER_MACHINE_NAME%') DO SET IPADDR=%%a
ECHO IP address: %IPADDR%
powershell -NoExit -ExecutionPolicy RemoteSigned -Command "& \"%DOCKER_MACHINE_EXE%\" env %DOCKER_MACHINE_NAME% | Invoke-Expression" ; $HOST.UI.RawUI.WindowTitle =\"Dcoker (PowerShell) - IP Address : %IPADDR%\" 

:END