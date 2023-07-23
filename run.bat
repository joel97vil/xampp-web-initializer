@echo off 

:: ## ENVIRONMENT VARIABLES SECTION ##
set green="\e[0;32m\033[1m"
set endColour="\033[0m\e[0m"
set red="\e[0;31m\033[1m"
set blue="\e[0;34m\033[1m"
set yellow="\e[0;33m\033[1m"
set purpler="\e[0;35m\033[1m"
set turquoise="\e[0;36m\033[1m"
set gray="\e[0;37m\033[1m"
::trap crtl_c INT


:: ## SCRIPT VARIABLES SECTION ##
set indexPath=""
set url=""
set port="80"
set htaccessTemplate=".\resources\htaccess.tmpl"
set vhostsTemplate=".\resources\vhost.tmpl"


:: ## SCRIPT CONSTANTS SECTION ##
set hostsFile="C:\Windows\System32\drivers\etc\hosts"   REM Default path for Windows
set vhostsFile="C:\xampp\apache\conf\extra\httpd-vhosts.conf"   REM Default path for Windows
set logsErrors=".\logs\errors.log"
set logsActions=".\logs\details.log"


:: ## FUNCTIONS SECTION ##
:ctrl_c
    echo "%red%[!]%gray% Exiting ...%endColour%"
exit /B 1


:help
    echo "\n%gray%Usage:\n\n%blue% $0 /u [URL] /i [INDEX] ...%endColour%"
    echo "\n\t%yellow}%/u%gray%     [REQUIRED] The domain (main url) to host the page (without www)%green% Ex: example.com %endColour%"
    echo "\n\t%yellow}%/i%gray%     [REQUIRED] The absolute path of the %red%FOLDER%gray% which containts [index.php] or [index.html] file. (avoid : character on folders) %green% Ex: C:/xampp/htdocs/example/public %endColour%"
    echo "\n\t%yellow%/p%gray%     [OPTIONAL] The port of the virtual host of the page (default 80) %green% Ex: 443 %endColour%"
    ::echo "\n\t%yellow%/v%gray%     [OPTIONAL] The absolute path of the virtual host XAMPP configuration file %green% Ex: %vhostsFile% %endColour%"
    ::echo "\n\t%yellow%/h%gray%     [OPTIONAL] The absolute path of the local machine host resolver file %green% Ex: %hostsFile% %endColour%"
exit

:syntax_error
    echo "%red%Error on parameters: URL or INDEX parameters weren't given %gray% Check usage guide%endColour%"
exit

:success
    echo "%green%The web app has been configured for developing in local successfully. You can now access going %yellow%%url%%green% on your browser. Remember to startup Apache! %endColor%"
exit

:beautify_index_path
    ::indexPath="$( echo ${indexPath} | tr '\\' '/' | tr -d ':' )"
    indexPath=echo "%indexPath%" | tr '\\' '/' | tr -d ':'
    ::TODO: If the indexPath doesn't start with a slash, add it manually (to make always a absolute path)
    ::TODO: If the indexPath lasts with a slash, remove it manually (to make always a absolute path)
exit

:write_config_files
    ::Append to the virtual host machine the virtual host config (from the default XAMPP template)
    copy %vhostsFile% "%vhostsFile%.bak"
    type %vhostsTemplate% >> %vhostsFile% >> %logsActions% 2>> %logsErrors%)
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[URL\]', '%url%' | Set-Content '%vhostsFile%'" >> %logsActions% 2>> %logsErrors%
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[PORT\]', '%port%' | Set-Content '%vhostsFile%'" >> %logsActions% 2>> %logsErrors%
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[INDEX_PATH\]', '%indexPath%' | Set-Content '%vhostsFile%'" >> %logsActions% 2>> %logsErrors%

    ::Append to the local machine host resolver file a new line with the URL
    copy %hostsFile% "%vhostsFile%.bak"
    type "127.0.0.1      %url%" >> "%hostsFile%" >> %logsActions% 2>> %logsErrors%)
    type "127.0.0.1      www.%url%" >> "%hostsFile%" >> %logsActions% 2>> %logsErrors%)
exit

:copy_htaccess_file
    copy "%htaccessTemplate%" "%indexPath%/.htaccess" >> %logsActions% 2>> %logsErrors%
exit


:: ## RUN SECTION ##

:: Getting the params
:loop
    IF "%~1" == "/u" (url=%~2) REM INDEX.PHP OR INDEX.HTML PATH (REQUIRED)
    IF "%~1" == "/i" (indexPath=%~2) REM INDEX.PHP OR INDEX.HTML PATH (REQUIRED)
    IF "%~1" == "/p" (vhosts_file=%~2) REM VHOST PORT (NOT-REQUIRED, DEFAULT 80)
    IF "%~1" == "/v" (vhosts_file=%~2) REM VHOST CONFIG PATH (NOT-REQUIRED, DEFAULT WINDOWS)
    ::IF "%~1" == "h" (hosts_file=%~2) REM HOSTS RESOLVE PATH (NOT-REQUIRED, DEFAULT WINDOWS)
    IF %~1 == "/help" GOTO help
if "%~1" != "" GOTO loop

if not "%url%"=="" if not "%indexPath%"="" (
    CALL :beautify_index_path
    if exist "%indexPath%" (
        CALL :write_config_files
        CALL :copy_htaccess_file
        CALL :success
    ) else (
        echo "%red%%indexPath% was not found.%endColour%"
    )
) else (
    CALL :syntax_error
    CALL :help
)