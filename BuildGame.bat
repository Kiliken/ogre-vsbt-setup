@echo off

if exist "%programfiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" call "%programfiles%\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
if exist "%programfiles%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" call "%programfiles%\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"


SET includes=/I src /I %cd%/OGRE/include/OGRE /I %cd%/OGRE/include/OGRE/Bites /I %cd%/OGRE/include/OGRE/Bullet /I %cd%/OGRE/include/OGRE/MeshLodGenerator /I %cd%/OGRE/include/OGRE/RTShaderSystem /I %cd%/OGRE/include/OGRE/RenderSystems /I %cd%/OGRE/include/OGRE/Volume /I %cd%/OGRE/include/OGRE/Threading /I %cd%/OGRE/include/OGRE/Overlay /I %cd%/OGRE/include/OGRE/Property /I %cd%/OGRE/include/OGRE/Plugins 
SET links=/link /LIBPATH:%cd%/src /LIBPATH:%cd%/OGRE/lib MSVCRT.lib LIBCMT.lib opengl32.lib User32.lib Shell32.lib Gdi32.lib Kernel32.lib Advapi32.lib Ole32.lib Oleaut32.lib uuid.lib odbc32.lib odbccp32.lib OgreMain.lib OgreBites.lib OgreMeshLodGenerator.lib OgreProperty.lib OgreRTShaderSystem.lib OgreVolume.lib
SET defines=/D RELEASE

cl /std:c++14 /EHsc /utf-8 /Fe"%cd%/bin/MyApp.exe" /Fo"%cd%/bin/" %includes% %defines% src/*.cpp %links%

if %errorlevel% neq 0 (
		color 0c
		echo Build failed!
) else (
		color 0a
		echo Build succeeded. Launching game...
		cd bin
		MyApp.exe
)

