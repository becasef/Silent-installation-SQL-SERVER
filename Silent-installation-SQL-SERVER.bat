@ECHO off
TITLE  SQL SERVER 2008 R2����ֵ�ذ�װ by becase
::��ȡ����ԱȨ��
::set TempFile_Name=%SystemRoot%\System32\BatTestUACin_SysRt%Random%.batemp
::( echo "BAT Test UAC in Temp" >%TempFile_Name% ) 1>nul 2>nul
::if exist %TempFile_Name% (
::del %TempFile_Name% 1>nul 2>nul
::GOTO menu
::) else (
::GOTO admin
::)
:::menu
::��װ.NET Framework 3.5(����.NET 2.0��3.0)
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if '%errorlevel%' NEQ '0' (goto UACPrompt) else (goto UACAdmin)
:UACPrompt
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:UACAdmin
cd /d "%~dp0"
echo ���ڰ�װ.NET Framework 3.5(����.NET 2.0��3.0)
dism.exe /online /enable-feature /featurename:NetFX3
::�˴���������>nul
::ͨ�������ж�һ����ʲô�汾��ϵͳȻ��ִ����Ӧ����
::ver | find "10.0." > NUL && goto :WIN10
::ver | find "6.0." > NUL && goto :WIN7
::echo unknown OS
::goto :eof
:::WIN10e
echo ���ڲ���SQL Server 2008 R2ӳ��...
powershell.exe Mount-DiskImage -ImagePath "%~dp0aaa.iso">nul
echo ���ڰ�װSQL Server 2008 R2 x64...
echo �����ĵȴ�ʮ���ӡ�����
D:\setup.exe /Q /ACTION=Install /PID=GYF3T-H2V88-GRPPH-HWRJP-QRTYB /ConfigurationFile=.\ConfigurationFile.ini /IACCEPTSQLSERVERLICENSETERMS  /SAPWD=Li299816 /SQLSYSADMINACCOUNTS=35938 > .\sqlinfo.txt
::@start /min 
cls
echo ��װ��ɡ���
pause>nul