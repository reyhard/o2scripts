@ECHO OFF
set Object=C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ImageToPAA\ImageToPAA.exe
if exist %1\* goto dir

:file
for %%f in (%*) do (
	"%Object%" %%f %%~nf.tga
)
goto exit

:dir
for /R %%G in (*.paa) do (
	"%Object%" %%G %%~nG.tga
)
goto exit
ECHO

:exit
pause