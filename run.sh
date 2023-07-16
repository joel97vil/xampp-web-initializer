#!/bin/bash

### ENVIRONMENT VARIABLES SECTION
green="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purpler="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;37m\033[1m"


### SCRIPT VARIABLES SECTION
indexPath=""
url="www.example.com"
hostsFile="/c/Windows/System32/drivers/etc/hosts_test"   #Default path for Windows
vhostsFile="/c/xampp/apache/conf/extra/httpd-vhosts.conf"   #Default path for Windows


### SCRIPT CONSTANTS SECTION
htaccessTemplate="./resoures/htaccess_template.txt"
vhostsTemplate="./resources/vhost_template.txt"


### FUNCTIONS SECTION
function ctrl_c() {
    echo -e "${red}[!]${gray} Exiting ...${endColour}"
    exit 1
}

function help() {
    echo -e "\n${gray}Usage:\n\n${blue} $0 -u [URL] -i [INDEX]${endColour}"
    echo -e "\n\t${yellow}-u${gray} The main url to host the page${green} Ex: www.example.com ${endColour}"
    echo -e "\n\t${yellow}-i${gray} The absolute path of the ${red}FOLDER${gray} which containts [index.php] or [index.html] file ${green} Ex: C:/xampp/htdocs/example/public ${endColour}"
    #echo -e "\n\t${yellow}-v${gray} [OPTIONAL] The absolute path of the virtual host XAMPP configuration file ${green} Ex: ${vhosts_file} ${endColour}"
    #echo -e "\n\t${yellow}-h${gray} [OPTIONAL ]The absolute path of the local machine host resolver file ${green} Ex: ${hosts_file} ${endColour}"
}

function syntax_error() {
    echo -e "\n${red}Error on parameters: ${gray} check usage guide${endColour}"
}

function beautify_index_path() {
    indexPath="$( echo -e ${indexPath} | tr '\' '/' )"
}

function write_config_files() {
    #TODO Append to the virtual host machine the virtual host config (from the default XAMPP template)
    
    #Append to the local machine host resolver file a new line with the URL
    echo -e "$( printf \\n127.0.0.1 >> ${hostsFile})"
    echo -e "$( printf '    ' >> ${hostsFile})"
    echo -e "$( printf ${url} >> ${hostsFile})"
}

function copy_htaccess_file() {
    echo -e "$( cp ${htaccessTemplate} ${indexPath}/.htaccess)"
}


### RUN SECTION
trap crtl_c INT

# Getting the params
#while getopts "u:i:v:h" args;do
while getopts "u:i" args;do
    case $args in
        u) url=$OPTARG;; #URL (REQUIRED)
        i) indexPath=$OPTARG;; #INDEX.PHP OR INDEX.HTML PATH (REQUIRED)
        #v) vhosts_file=$OPTARG;; #VHOST CONFIG PATH (NOT-REQUIRED, DEFAULT WINDOWS)
        #h) hosts_file=$OPTARG;; #HOSTS RESOLVE PATH (NOT-REQUIRED, DEFAULT WINDOWS)
    esac
done

echo "url=${url} indexPath=${indexPath}" #debug variable status
write_config_files
if ([ $url ] && [ $indexPath ]); then
    beautify_index_path
    if([ -d indexPath ]); then

        copy_htaccess_file
    else
        #TODO: Folder doesn't exist
        echo "The index web folder ${red}was not found.${endColour}"
    fi
else
    syntax_error
    help
fi