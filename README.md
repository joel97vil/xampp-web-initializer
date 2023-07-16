# XAMPP Web Inicializer
A simple shell application which initializes and configures all the needed things for a web application on XAMPP (tested on v3.3.0 version) to start developing in a local development environment, letting you have a real domain name on your URL.
This can startup web applications like WordPress, Laravel or Yii2 easily and quickly, making you forget about first configuration part.


## Windows pre-requisites
<b>Install/enable a Bash Shell</b>
- Option 1: Enable Bash Shell compatibility on Windows features configuration (available on Windows 10 or more).
- Option 2: Install GitHub Desktop, which installs a built-in Bash Shell.
- Option 3: <i>Others, coming soon...</i>


## Linux-Debian pre-requisites
<b>None</b> - Bash Shell is built-in installed on Linux - Debian operating systems (like Ubuntu).


# Usage
To use this program in order to initialize a web configuration, <b>startup a Bash Shell as root/Administrator</b>.
<code>./run.sh -u example.com -i /c/xampp/htdocs/test/public</code>

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
        <td>[REQUIRED] The absolute path of the ${red}FOLDER${gray} which containts [index.php] or [index.html] file. (avoid : character on folders)</td>
        <td><code>-i /c/xampp/htdocs/example/public</code></td>
    </tr>
    <tr>
        <td><code>p</code></td>
        <td>[OPTIONAL] The port of the virtual host of the page (default 80)</td>
        <td><code>-p 443</code></td>
    </tr>
    <tr>
        <td><code>v</code></td>
        <td>[OPTIONAL] The absolute path of the virtual host XAMPP configuration file</td>
        <td><code>-v /c/Windows/System32/drivers/etc/hosts</code></td>
    </tr>
    <tr>
        <td><code>h</code></td>
        <td>[OPTIONAL] The absolute path of the local machine host resolver file</td>
        <td><code>-h /c/xampp/apache/conf/extra/httpd-vhosts.conf</code></td>
    </tr>
    <tr>
        <td><code>help</code></td>
        <td>Information about the program usage, the available parameters and how to use them</td>
        <td><code>-help</code></td>
    </tr>
</table>




## Future features
[x] XAMPP compatibility (Windows).
[] Path parameters passed to the program using Windows layout (C:\)
[] LAMPP compatibility (XAMPP for Linux - Debian).
[] Adding additional parameters (-help, -port and more...)
[] Various built-in default configurations for different development environments (Windows / Linux-Debian / iOS?).
[] Alias generation to use the program command from any path of the system
[] Execute the program with all needed permissions to edit the configuration files
More...


## Security Vulnerabilities and Contributing
If you discover a bugs or security vulnerabilities, please send an e-mail to me via [joel97vil@gmail.com](mailto:joel97vil@gmail.com). Any collaboration will be thankful.
Feel free to create your own forks to improve the script or fix the bugs and security vulnerabilities.


## License
<i>XAMPP Web Initializer</i> is a Shell based project, open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).
