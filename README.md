# XAMPP Web Inicializer
A simple shell/batch application which **initializes and configures all the needed configuration files to startup a web application on XAMPP Apache server** (tested on v3.3.0 version) in a local development environment, letting you have a real domain name on your URL working in localhost. The program configures all the needed files to start a virtualhost with the given name and the given path.
<br />
**This can startup Apache hosted web applications like WordPress, Laravel or Yii2 easily and quickly, making you forget about first configuration part.**

## Table of contents
- [Requirements](#requirements)
    - [Windows Requirements](#windows-requirements)
    - [Linux-Debian Requirements](#linux-debian-requirements)
- [Usage](#usage)
    - [Windows Usage](#windows-usage)
    - [Linux-Debian Usage](#linux-debian-usage)
- [Features](#features)
- [Future features](#future-features)
- [Security, Vulnerabilities and Contributing](#security-vulnerabilities-and-contributing)
- [License](#license)

## Requirements
Depending on your operating system: 

### Windows Requirements
Powershell installed. Windows 7 or newer already has built-in installed Powershell.

### Linux-Debian Requirements
Execution permissions (depending where the project folder is located, it already has). <br />
<code>chmod -R 755 ./xampp-web-initializer/* </code>

## Usage
Depending on your operating system:

### Windows Usage
To use this program in order to initialize a web configuration, <b>startup a Batch (cmd) as Administrator</b>.
<br />
<code>run.bat /u example.com /i C:\xampp\htdocs\test\public [OPTIONAL PARAMS...]</code>

<table>
    <tr>
        <th>Parameter</th>
        <th>Description</th>
        <th>Example</th>
    </tr>
    <tr>
        <td><code>u</code></td>
        <td>[REQUIRED] The domain (main url) to host the page (without www)</td>
        <td><code>/u example.com</code></td>
    </tr>
    <tr>
        <td><code>i</code></td>
        <td>[REQUIRED] The absolute path of the which containts [index.php] or [index.html] file. (avoid : character on folders)</td>
        <td><code>/i C:\xampp\htdocs\example\public</code></td>
    </tr>
    <tr>
        <td><code>p</code></td>
        <td>[OPTIONAL] The port of the virtual host of the page (default 80)</td>
        <td><code>/p 443</code></td>
    </tr>
    <tr>
        <td><code>v</code></td>
        <td>[OPTIONAL] The absolute path of the virtual host XAMPP configuration file</td>
        <td><code>/v C:\xampp\apache\conf\extra\httpd-vhosts.conf</code></td>
    </tr>
    <tr>
        <td><code>h</code></td>
        <td>[OPTIONAL] The absolute path of the local machine host resolver file</td>
        <td><code>/h C:\Windows\System32\drivers\etc\hosts</code></td>
    </tr>
    <tr>
        <td><code>help</code></td>
        <td>Information about the program usage, the available parameters and how to use them</td>
        <td><code>/help</code></td>
    </tr>
</table>

### Linux-Debian Usage
To use this program in order to initialize a web configuration, <b>startup a Bash Shell as root</b>.
<br />
<code>sudo ./run.sh -u example.com -i /opt/lampp/htdocs/test/public [OPTIONAL PARAMS...]</code>

<table>
    <tr>
        <th>Parameter</th>
        <th>Description</th>
        <th>Example</th>
    </tr>
    <tr>
        <td><code>u</code></td>
        <td>[REQUIRED] The domain (main url) to host the page (without www)</td>
        <td><code>-u example.com</code></td>
    </tr>
    <tr>
        <td><code>i</code></td>
        <td>[REQUIRED] The absolute path of the which contains [index.php] or [index.html] file. (avoid : character on folders)</td>
        <td><code>-i /opt/lampp/htdocs/example/public</code></td>
    </tr>
    <tr>
        <td><code>p</code></td>
        <td>[OPTIONAL] The port of the virtual host of the page (default 80)</td>
        <td><code>-p 443</code></td>
    </tr>
    <tr>
        <td><code>v</code></td>
        <td>[OPTIONAL] The absolute path of the virtual host XAMPP configuration file</td>
        <td><code>-v /opt/lampp/etc/extra/httpd-vhosts.conf</code></td>
    </tr>
    <tr>
        <td><code>h</code></td>
        <td>[OPTIONAL] The absolute path of the local machine host resolver file</td>
        <td><code>-h /etc/hosts</code></td>
    </tr>
    <tr>
        <td><code>help</code></td>
        <td>Information about the program usage, the available parameters and how to use them</td>
        <td><code>-help</code></td>
    </tr>
</table>

## Features
- [ ] XAMPP compatibility Windows.
- [X] LAMPP compatibility for Linux - Debian.
- [X] Make backup of configuration files before execute the process.
- [X] Adding additional parameters (-help, -port and more...)
- [X] Various built-in default configurations for different development environments (Windows / Linux-Debian).
- [ ] Alias generation to use the program command from any path of the system (System variable).
- [X] Require to execute the program with all needed permissions to edit the configuration files.
- [X] Errors control and logging.

## Future features
- [ ] GUI for Windows.
- [ ] GUI for Linux - Debian.
- [ ] TOMCAT web applications support.
- [ ] Disable / remove local virtual host.
- [ ] More...

## Security, Vulnerabilities and Contributing
If you discover a bugs or security vulnerabilities, please [send an e-mail to me via joel97vil@gmail.com](mailto:joel97vil@gmail.com) or [report the issue on this repository](https://github.com/joel97vil/xampp-web-initializer/issues). Any collaboration and error reporting will be welcome.
Do you want to contribute? Feel free to create your own forks to improve the script or fix the bugs and security vulnerabilities.

## License
**XAMPP Web Initializer** is a Shell and Batch script based project, open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
