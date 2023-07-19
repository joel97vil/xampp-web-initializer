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
set url="example.com"
set port="80"


:: ## SCRIPT CONSTANTS SECTION ##
set htaccessTemplate=".\resources\htaccess_template.txt"
set vhostsTemplate=".\resources\vhost_template.txt"
set hostsFile="C:\Windows\System32\drivers\etc\hosts"   REM Default path for Windows
set vhostsFile="C:\xampp\apache\conf\extra\httpd-vhosts.conf"   REM Default path for Windows
set logsFile=".\logs\errors.txt"


:: ## FUNCTIONS SECTION ##
:ctrl_c
    echo -e "%red%[!]%gray% Exiting ...%endColour%"
exit /B 1


:help
    echo -e "\n%gray%Usage:\n\n%blue% $0 /u [URL] /i [INDEX] ...%endColour%"
    echo -e "\n\t%yellow}%/u%gray%     [REQUIRED] The domain (main url) to host the page (without www)%green% Ex: example.com %endColour%"
    echo -e "\n\t%yellow}%/i%gray%     [REQUIRED] The absolute path of the %red%FOLDER%gray% which containts [index.php] or [index.html] file. (avoid : character on folders) %green% Ex: C:/xampp/htdocs/example/public %endColour%"
    echo -e "\n\t%yellow%/p%gray%     [OPTIONAL] The port of the virtual host of the page (default 80) %green% Ex: 443 %endColour%"
    ::echo -e "\n\t%yellow%/v%gray%     [OPTIONAL] The absolute path of the virtual host XAMPP configuration file %green% Ex: %vhostsFile% %endColour%"
    ::echo -e "\n\t%yellow%/h%gray%     [OPTIONAL] The absolute path of the local machine host resolver file %green% Ex: %hostsFile% %endColour%"
exit

:syntax_error
    echo -e "%red%Error on parameters: URL or INDEX parameters weren't given %gray% Check usage guide%endColour%"
exit

:success
    echo -e "%green%The web app has been configured for developing in local successfully. You can now access going %yellow%%url%%green% on your browser. Remember to startup Apache! %endColor%"
exit

:beautify_index_path
    ::indexPath="$( echo ${indexPath} | tr '\\' '/' | tr -d ':' )"
    indexPath=echo "%indexPath%" | tr '\\' '/' | tr -d ':'
    ::TODO: If the indexPath doesn't start with a slash, add it manually (to make always a absolute path)
    ::TODO: If the indexPath lasts with a slash, remove it manually (to make always a absolute path)
exit

:write_config_files
    ::Append to the virtual host machine the virtual host config (from the default XAMPP template)
    type %vhostsTemplate% >> %vhostsFile% 2>> %logsFile%)
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[URL\]', '%url%' | Set-Content '%vhostsFile%'"
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[PORT\]', '%port%' | Set-Content '%vhostsFile%'"
    powershell -Command "(Get-Content '%vhostsFile%') -replace '\[INDEX_PATH\]', '%indexPath%' | Set-Content '%vhostsFile%'"
    ::Append to the local machine host resolver file a new line with the URL
    type "127.0.0.1      %url%" >> "%hostsFile%")
    type "127.0.0.1      www.%url%" >> "%hostsFile%")
exit

:copy_htaccess_file
    copy "%htaccessTemplate%" "%indexPath%/.htaccess"
exit


:: ## RUN SECTION ##

:: Getting the params
::while getopts "u:i:p:v:h:help:" args;do
:loop
    IF %param% == "i" set indexPath=%param% REM INDEX.PHP OR INDEX.HTML PATH (REQUIRED)
    IF %param% == "p" set vhosts_file=%param% REM VHOST PORT (NOT-REQUIRED, DEFAULT 80)
    ::IF %param% == "v" set vhosts_file=%param% REM VHOST CONFIG PATH (NOT-REQUIRED, DEFAULT WINDOWS)
    ::IF %param% == "h" set hosts_file=%param% REM HOSTS RESOLVE PATH (NOT-REQUIRED, DEFAULT WINDOWS)
    ::IF %param% == "help" GOTO help
if %param% != "" GOTO loop

if ([ %url% ] && [ %indexPath% ]); then
    CALL :beautify_index_path
    if([ -d %indexPath% ]); then
        CALL :write_config_files
        CALL :copy_htaccess_file
        CALL :success
    else
        echo -e "%red%%indexPath% was not found.%endColour%"
    end if
else
    CALL :syntax_error
    CALL :help
