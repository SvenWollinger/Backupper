@echo off
setlocal enabledelayedexpansion 
title %title% - Backupper

REM ===== Time Variables =====
set timeUnformatted=%TIME%__%DATE%
set timeFormatted=%timeUnformatted::=_%
set timeFormatted=%timeFormatted:,=_%
set timeFormatted=%timeFormatted: =_%

REM ===== 7zip Location, change as needed =====
set zip="C:\Program Files\7-Zip\7z.exe"

REM ===== Destination folder =====
set destinationFile=%destinationFolder%\Backup_%timeFormatted%.zip

REM ===== START BACKUP =====
echo Backup location: %destinationFile%
echo.
set tempLog=%temp%\%timeFormatted%_templog.txt
for /l %%n in (0,1,%amount%) do ( 
	echo Added "%baseFolder%!folders[%%n]!"
	%zip% a "%destinationFile%" "%baseFolder%!folders[%%n]!" >> %tempLog%
)
del %tempLog%

Rem ===== DONE =====
echo.
echo Done!
echo Press any key to exit
pause>nul
