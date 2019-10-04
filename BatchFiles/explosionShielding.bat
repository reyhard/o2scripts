if exist %1\* goto dir

:file
for %%f in (%*) do (
	"C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Script.exe"  "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder\O2Scripts\explosionShielding.bio2s" %%f
)
goto exit

:dir
for %%f in (%1\*.p3d) do (
	"C:\Program Files (x86)\Steam\SteamApps\common\Arma 3 Tools\ObjectBuilder\O2Script.exe"  "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\ObjectBuilder\O2Scripts\explosionShielding.bio2s" %%f
)
goto exit

:exit
pause