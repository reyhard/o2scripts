if exist %1\* goto dir

:file
for %%f in (%*.pbo) do (
	"C:\Program Files (x86)\Mikero\DePboTools\bin\ExtractPboDos.exe"  -P %%f "%~dp0."
)
goto exit

:dir
for %%f in (%1\*.pbo) do (
	"C:\Program Files (x86)\Mikero\DePboTools\bin\ExtractPboDos.exe" -P  "%%f" %1
)
goto exit

:exit
pause