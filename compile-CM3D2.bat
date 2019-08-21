@echo off
setlocal
pushd "%~dp0"

::set CM3D2_PATH=(CM3D2.exe �̂���t�H���_)

:: Set output directory.
set OUTDIR=UnityInjector

:: Set compiler path.
set "CSC=C:\Windows\Microsoft.NET\Framework\v3.5\csc.exe"

:: Find CM3D2 installed path.
set "CM3D2_REG_KEY=HKCU\SoftWare\KISS\�J�X�^�����C�h3D2"
if "%CM3D2_PATH%" == "" (
  for /F "usebackq skip=2 tokens=1-2*" %%A in (
    `REG QUERY "%CM3D2_REG_KEY%" /v InstallPath 2^>nul`) do (
    set "CM3D2_PATH=%%C"
  )
)

if "%CM3D2_PLATFORM%" == "" (
  if %PROCESSOR_ARCHITECTURE% == x86 (
    set CM3D2_PLATFORM=x86
  ) else (
    set CM3D2_PLATFORM=x64
  )
)

:check_args
if "%1" == "" goto :compile
if "%1" == "debug" set CSOPT_DEBUG=-define:DEBUG -debug
if "%1" == "deploy" set DEPLOY=1
if "%1" == "--no-pause" set NOPAUSE=1
shift
goto :check_args

:compile
set "SYBARIS_DIR=%CM3D2_PATH%\Sybaris"
set "SYBARIS_PLUGIN_DIR=%SYBARIS_DIR%\Loader"
set "UNITY_INJECTOR_DIR=%SYBARIS_DIR%\Plugins\UnityInjector"
set "CM3D2_MANAGED_DIR=%CM3D2_PATH%\CM3D2%CM3D2_PLATFORM%_Data\Managed"
set TARGET=CM3D2.SlowAnimation.Plugin.dll
set SRCS=^
  SlowAnimation.cs
set CSOPT=/nologo /optimize+ %CSOPT_DEBUG% %CSOPT_ADD%
set CSLIB=^
  /lib:"%CM3D2_MANAGED_DIR%" ^
  /lib:"%SYBARIS_PLUGIN_DIR%" ^
  /lib:"%UNITY_INJECTOR_DIR%" ^
  /r:UnityEngine.dll ^
  /r:UnityInjector.dll

mkdir "%OUTDIR%" 2>nul
echo "%CSC%" %CSOPT% /t:library %CSLIB% /out:"%OUTDIR%\%TARGET%" %SRCS%
"%CSC%" %CSOPT% /t:library %CSLIB% /out:"%OUTDIR%\%TARGET%" %SRCS% || goto :error

if not "%DEPLOY%" == "" (
  copy "%OUTDIR%\%TARGET%" "%UNITY_INJECTOR_DIR%" || goto :error
)

:success
echo ----------------------------------------------------------------------------
echo  �R���p�C�����������܂����B��̃��b�Z�[�W�ŃG���[���o�ĂȂ������m�F�������B
echo  ���Ȃ��ꍇ�A%OUTDIR% �t�H���_��dll���ł��Ă��܂��B
goto :done

:error
echo ----------------------------------------------------------------------------
echo  �G���[���������܂����B�ȉ��̉\��������܂��B
echo   �ECM3D2 �̃C���X�g�[���ꏊ���������Ȃ�
echo     compile.bat �̖`���Ɉȉ����L�����Ă��������B
echo     set CM3D2_PATH=(CM3D2.exe �̂���t�H���_)
echo   �E.NET Framework 3.5 �� "���΂肷" ���������C���X�g�[������Ă��Ȃ�
goto :done

:done
popd
if "%NOPAUSE%" == "" pause
endlocal
