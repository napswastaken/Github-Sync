@echo off
SET "LogDir=C:\Users\Administrator\Desktop\Github\logs"
SET "LogFileName=script_log"
SET "LogFileExt=.txt"
SET "DateTimeFormat=%Y%m%d_%H%M%S"
SET "LogFilePath=%LogDir%\%LogFileName%_%date:~10,4%%date:~4,2%%date:~7,2%%time:~0,2%%time:~3,2%%time:~6,2%%LogFileExt%"

IF NOT EXIST "%LogDir%" mkdir "%LogDir%"

echo Starting script [%date% %time%] >> "%LogFilePath%"

SET "Github_profiles=C:\Users\Administrator\Desktop\Github\Development\Chernarus\profiles"
SET "Github_mpmissions=C:\Users\Administrator\Desktop\Github\Development\Chernarus\mpmissions"

SET "Server_profiles=C:\Users\Administrator\Desktop\OmegaManager\servers\0\profiles\" # point to your server profiles
SET "Server_mpmissions=C:\Users\Administrator\Desktop\OmegaManager\servers\0\mpmissions\dayzOffline.chernarusplus" # point to your server mpmissions

echo Syncing Github mpmissions [%date% %time%] >> "%LogFilePath%"
cd %Github_mpmissions%
git fetch >> "%LogFilePath%" 2>&1
git reset --hard origin/main >> "%LogFilePath%" 2>&1

echo Syncing Github profiles [%date% %time%] >> "%LogFilePath%"
cd %Github_profiles%
git fetch >> "%LogFilePath%" 2>&1
git reset --hard origin/main >> "%LogFilePath%" 2>&1

echo Copying mpmissions to server [%date% %time%] >> "%LogFilePath%"
ROBOCOPY %Github_mpmissions% %Server_mpmissions% /E /Z /W:2 /R:5 /NS /NC /NFL /NDL /V >> "%LogFilePath%" 2>&1

echo Copying profiles to server [%date% %time%] >> "%LogFilePath%"
ROBOCOPY %Github_profiles% %Server_profiles% /E /Z /W:2 /R:5 /NS /NC /NFL /NDL /V >> "%LogFilePath%" 2>&1

echo Script completed [%date% %time%] >> "%LogFilePath%"
