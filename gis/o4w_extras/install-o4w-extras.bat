@echo off
echo.
echo.	Installing a few extra goodies into OSGeo4W
echo.

:: Environment settings
if [%OSGEO4W_ROOT%]==[] goto :EnvNotSet
set homedir=%cd%

:xcopy
	cd /d %~dp0
	call :Excludes
	xcopy /s /exclude:xcopy_exclude.txt /d /y .\* %OSGEO4W_ROOT%\
	call :MakeBats
	cd %homedir%
	goto :Done

:MakeBats
	cd /d %OSGEO4W_ROOT%\bin
	for %%g in (*.py) do (
		if not exist %%~ng.bat echo @python "%%OSGEO4W_ROOT%%\bin\%%g" %%* > %%~ng.bat
		)
	goto :EOF

:EnvNotSet
	echo.
	echo.	*** OSGEO4W_ROOT not found. 
	echo.	*** Please run install-o4w-extras.bat from within OSGeo4W shell.
	echo.
	:: pause for a few seconds.
	ping localhost -n 5 >nul
	goto :EOF	

:Excludes
	del xcopy_exclude.txt
	for %%g in (.svn tests xcopy_exclude.txt install-o4w-extras.bat *.reg) do (
		echo %%g >> xcopy_exclude.txt
		)
	goto :eof
	
:Done
	echo.
	echo.	Finished.
	echo.