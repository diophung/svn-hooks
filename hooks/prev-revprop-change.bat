@ECHO OFF
:: Credit to original post at http://ayria.livejournal.com/33438.html
:: -------------------------------------------
:: History
:: 2014-01-29 - Only allow editing your own message
:: -------------------------------------------
:: Notes:
:: Set all parameters. Even though most are not used, in case you want to add
:: changes that allow, for example, editing of the author or addition of log messages.

set repository=%1
set revision=%2
set userName=%3
set propertyName=%4
set action=%5

:: Only allow editing of the same user.
for /f "tokens=*" %%a in ( 
'"%VISUALSVN_SERVER%\bin\svnlook.exe" author -r %revision% %repository%') do ( 
set orgAuthor=%%a
)
if /I not "%userName%" == "%orgAuthor%" goto ERROR_SAME_USER

:: Only allow the log message to be changed, but not author, etc.
if /I not "%propertyName%" == "svn:log" goto ERROR_PROPNAME

:: Only allow modification of a log message, not addition or deletion.
if /I not "%action%" == "M" goto ERROR_ACTION

:: Make sure that the new svn:log message is not empty.
set bIsEmpty=true
for /f "tokens=*" %%g in ('find /V ""') do (
set bIsEmpty=false
)
if "%bIsEmpty%" == "true" goto ERROR_EMPTY

goto :eof

::Only allow editing your own message
:ERROR_SAME_USER
echo You can only edit your own commit message. >&2
goto ERROR_EXIT

:ERROR_EMPTY
echo Empty svn:log messages are not allowed. >&2
goto ERROR_EXIT

:ERROR_PROPNAME
echo Only changes to svn:log messages are allowed. >&2
goto ERROR_EXIT

:ERROR_ACTION
echo Only modifications to svn:log revision properties are allowed. >&2
goto ERROR_EXIT

:ERROR_EXIT
exit /b 1