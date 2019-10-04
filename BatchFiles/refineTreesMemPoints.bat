@ECHO OFF
set Object=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Script.exe
set Script=C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Scripts\refineTreeMemPoint.bio2s
if exist %1\* goto dir

:file
for %%f in (%*) do (
	"%Object%"  "%Script%" %%f
)
goto exit

:dir
for %%f in (%1\*.p3d) do (
	"%Object%"  "%Script%" %%f
)
goto exit
ECHO

:exit
pause