if exist %1\* goto dir

:file
"C:\Program Files (x86)\Mikero\DePboTools\bin\ExtractPboDos.exe"  %1
goto exit

:dir
for %%f in (%1\*.p3d) do (
	"C:\Program Files (x86)\Mikero\DePboTools\bin\ExtractPboDos.exe"  %%f
)
goto exit

:exit
pause