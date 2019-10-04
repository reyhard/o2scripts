if exist %1\* goto dir

:file
for %%f in (%*) do (
	"C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\Audio\WSSDecoder.exe" %%f *.wss
)
goto exit

:dir
for %%f in (%1\*.p3d) do (
	"C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\Audio\WSSDecoder.exe" %%f *.wss
)
goto exit

:exit
pause
"C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\Audio\WSSDecoder.exe" %1 *.wss
pause 