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
trap crtl_c INT


### SCRIPT VARIABLES SECTION
indexPath=""
url=""
port="80"
hostsFile="/etc/hosts"   #Default path for Ubuntu or "/etc/resolv.conf"
vhostsFile="/opt/lampp/etc/extra/httpd-vhosts.conf"   #Default path for Ubuntu
vconfigFile="/opt/lampp/etc/httpd.conf" #Default apache config file to enable/disable virtual hosts
vconfigLine="#Include etc/extra/httpd-vhosts.conf" #Include remove commented line in config (#487 maybe)


### SCRIPT CONSTANTS SECTION
htaccessTemplate="./resources/htaccess_template.txt"
vhostsTemplate="./resources/vhost_template.txt"


### FUNCTIONS SECTION
function ctrl_c() {
    echo -e "${red}[!]${gray} Exiting ...${endColour}"
    exit 1
}

function help() {
    echo -e "\n${gray}Usage:\n\n${blue} $0 -u [URL] -i [INDEX] ...${endColour}"
    echo -e "\n\t${yellow}-u${gray}     [REQUIRED] The domain (main url) to host the page (without www)${green} Ex: example.com ${endColour}"
    echo -e "\n\t${yellow}-i${gray}     [REQUIRED] The absolute path of the ${red}FOLDER${gray} which containts [index.php] or [index.html] file. (avoid : character on folders) ${green} Ex: C:/xampp/htdocs/example/public ${endColour}"
    #echo -e "\n\t${yellow}-p${gray}     [OPTIONAL] The port of the virtual host of the page (default 80) ${green} Ex: 443 ${endColour}"
    #echo -e "\n\t${yellow}-v${gray}     [OPTIONAL] The absolute path of the virtual host XAMPP configuration file ${green} Ex: ${vhostsFile} ${endColour}"
    #echo -e "\n\t${yellow}-h${gray}     [OPTIONAL] The absolute path of the local machine host resolver file ${green} Ex: ${hostsFile} ${endColour}"
}

function syntax_error() {
    echo -e "${red}Error on parameters: URL or INDEX parameters weren't given ${gray} Check usage guide${endColour}"
}

function success() {
    echo -e "${green}The web app has been configured for developing in local successfully. You can now access going ${yellow}${url}${green} on your browser. Remember to startup Apache! ${endColor}"
}

function beautify_index_path() {
    indexPath="$( echo ${indexPath} | tr '\\' '/' | tr -d ':' )"
    #TODO: If the indexPath doesn't start with a slash, add it manually (to make always a absolute path)
    #TODO: If the indexPath lasts with a slash, remove it manually (to make always a absolute path)
}

function write_config_files() {
    #Append to the virtual host machine the virtual host config (from the default XAMPP template)
    $( cat ${vhostsTemplate} >> ${vhostsFile} 2>> "./logs/errors.txt")
    #Set configuration to the new virtualhost added on virtualhosts file
    $( sed -e "s@\[URL\]@${url}@" "${vhostsFile}") 
    $( sed -e "s@\[PORT\]@${port}@" "${vhostsFile}")
    $( sed -e "s@\[INDEX_PATH\]@${indexPath}@" "${vhostsFile}")
    
    #Append to the local machine host resolver file a new line with the URL
    $( echo "127.0.0.1      ${url}" | tee -a ${hostsFile})
    $( echo "127.0.0.1      www.${url}" | tee -a ${hostsFile})
}

function copy_htaccess_file() {
    $( cp "${htaccessTemplate}" "${indexPath}/.htaccess")
}

function enable_virtual_hosts_usage(){
    #Locate the line which enables virtual host usage on config file
    commentedLine=$( cat "${vconfigFile}" | grep "'${vconfigLine}'")
    #if comment found, remove to enable the usage
    if ([ $commentedLine ]); then
        $(sed -i "'s|^${vconfigLine}conf$|Include ${vhostsFile}|'" "${vconfigFile}")
    fi
}


### RUN SECTION

# Getting the params
#while getopts "u:i:p:v:h:help:" args;do
while getopts "u:i:" args;do
    case $args in
        u) url=$OPTARG;; #URL (REQUIRED)
        i) indexPath=$OPTARG;; #INDEX.PHP OR INDEX.HTML PATH (REQUIRED)
        #p) vhosts_file=$OPTARG;; #VHOST PORT (NOT-REQUIRED, DEFAULT 80)
        #v) vhosts_file=$OPTARG;; #VHOST CONFIG PATH (NOT-REQUIRED, DEFAULT WINDOWS)
        #h) hosts_file=$OPTARG;; #HOSTS RESOLVE PATH (NOT-REQUIRED, DEFAULT WINDOWS)
        #help) help;;
    esac
done

# Check if the script is being run as root
if [ "$(id -u)" -ne 0 ]; then
  echo -e "${red}This script must be run as root. {$gray}Please use 'sudo' to execute it.${endColour}"
  exit 1
fi

if ([ $url ] && [ $indexPath ]); then
    enable_virtual_hosts_usage
    beautify_index_path
    if([ -d $indexPath ]); then
        write_config_files
        copy_htaccess_file
        success
    else
        echo -e "${red}${indexPath} was not found. Please, make sure where's the correct web path. ${endColour}"
    fi
else
    syntax_error
    help
fi