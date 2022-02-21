@echo off
setlocal EnableDelayedExpansion

:intro
	cls
	echo Backupper Creator
	echo.
	echo Do you want to download the Backupper.bat now?
	set /p input=y/n:
	if %input%==y call :download_backupper
goto start_create


:download_backupper
	echo Downloading backupper.bat
	curl https://raw.githubusercontent.com/SvenWollinger/Backupper/master/Backupper.bat -o Backupper.bat
	echo Done!
goto :eof

:start_create
	cls
	echo Enter the name of the thing you are backing up.
	set /p name=Name: 
	echo.

	echo Enter the base folder path. You will then select one or multiple subfolders.
	set /p basefolder=Basefolder: 
	echo.

	echo How many subfolders will be included in the backup?
	set /p amount=Amount: 
	set /a "real_amount=%amount%-1"
	echo.

	echo Enter all subfolders now.
	FOR /L %%G IN (0, 1, %real_amount%) DO (
		call :set_list %%G
	)
	echo.
	
	echo Enter destination folder
	set /p dest=Destination folder: 
goto preview_info

:set_list
	set /p test=Add Folder: 
	set sub_list[%~n1]=%test%
goto :eof

:get_sub_list_length
	set length=0
	:get_sub_list_length_loop
		if defined sub_list[%length%] (
			set /a length+=1
			goto get_sub_list_length_loop
		)
	set /a "length=%length%-1"
goto :eof

:preview_info
	cls
	echo Current status:
	echo.
	echo Name: %name%
	echo Basefolder: %basefolder%
	echo Subfolders:
	call :get_sub_list_length
	for /L %%i in (0,1,%length%) do echo - !sub_list[%%i]!
	echo.
	echo Is this correct?
	set /p input=(y/n): 
	if %input%==n goto intro
goto create_program

:create_program
	set filename=%name%.bat
	echo @echo off >> "%filename%"
	echo. >> "%filename%"
	echo set title=%name% backup >> "%filename%"
	echo. >> "%filename%"
	echo set baseFolder=%basefolder% >> "%filename%"
	echo. >> "%filename%"
	echo set amount=%real_amount% >> "%filename%"

	call :get_sub_list_length
	for /L %%i in (0,1,%length%) do echo set folders[%%i]=!sub_list[%%i]! >> "%filename%"
	
	echo. >> "%filename%"
	echo set destinationFolder=%dest% >> "%filename%"
	echo. >> "%filename%"
	echo call Backupper.bat >> "%filename%"
	echo Done! "%filename%" was created successfully!
goto done
	
:done