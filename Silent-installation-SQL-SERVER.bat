@ECHO off
TITLE  SQL SERVER 2008 R2无人值守安装 by becase
::获取管理员权限
::set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
::( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
::if exist %TempFile_Name% (
::del %TempFile_Name% 1>nul 2>nul
::GOTO menu
::) else (
::GOTO admin
::)
:::menu
::安装.NET Framework 3.5(包括.NET 2.0和3.0)
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"
echo 正在安装.NET Framework 3.5(包括.NET 2.0和3.0)
dism.exe /online /enable-feature /featurename:NetFX3
::此处可以隐藏>nul
::通过命令判断一下是什么版本的系统然后执行相应程序
::ver | find "10.0." > NUL && goto :WIN10
::ver | find "6.0." > NUL && goto :WIN7
::echo unknown OS
::goto :eof
:::WIN10e
echo 正在部署SQL Server 2008 R2映像...
powershell.exe Mount-DiskImage -ImagePath "%~dp0aaa.iso">nul
echo 正在安装SQL Server 2008 R2 x64...
echo 请耐心等待十分钟………
D:\setup.exe /Q /ACTION=Install /PID=GYF3T-H2V88-GRPPH-HWRJP-QRTYB /ConfigurationFile=.\ConfigurationFile.ini /IACCEPTSQLSERVERLICENSETERMS  /SAPWD=Li299816 /SQLSYSADMINACCOUNTS=35938 > .\sqlinfo.txt
::@start /min 
cls
echo 安装完成……
pause>nul