@ECHO OFF
:: -------------------------------------------
:: History
:: 2014-01-29 - Only allow editing your own message
:: -------------------------------------------
:: Notes:
:: This hook to prevent check-in message that is shorter than 10 chars
:: Ten dots mean at least ten chars. Adjust as you wish.
setlocal
set REPOS=%1
set TXN=%2
set SVNLOOK="%VISUALSVN_SERVER%\bin\svnlook.exe"
set MIN_CHAR=10

:: Look for minimum 10 chars
%SVNLOOK% log -t %TXN% %REPOS%| FindStr ..........
IF %ERRORLEVEL% EQU 0 GOTO NORMAL_EXIT

:: Output error message
:ERROR_TOO_SHORT
echo "Must provide comments at least %MIN_CHAR% characters" >&2
goto ERROR_EXIT

:: Message too short
:ERROR_EXIT
exit /b 1

:: Passed, so allow the commit.
:NORMAL_EXIT
exit 0 