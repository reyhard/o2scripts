@ECHO OFF
set Object=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Script.exe
set Script=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Scripts\addNewCharacterFG.bio2s
if exist %1\* goto dir

:file
for %%f in (%*) do (
	"%Object%"  "%Script%" %%f
)
goto exit

:dir
for /R %%G in (*.p3d) do (
	"%Object%"  "%Script%" %%G
)
goto exit
ECHO

:exit
pause