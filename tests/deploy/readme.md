Two-step deployment for Meteor apps
===================================

This folder contains four scripts that can be used to deploy a Meteor app to a remote server.

These files contain hard-coded names, file names and paths that you will need to change.

1. A client-side script to upload the packaged app to the server and open an ssh connection
2. A server-side script to run as root (using `sudo`) on the server
3. A script to place in the root directory of your app on the server. This will be executed by the script (2) above
4. A JavaScript file to be placed in the same root directory as (3). This can be customized and run optionally to update or fix the MongoDB database before the Meteor app relaunches.

To deploy your Meteor app, you will need to run two commands in your Terminal. The second command will ask for your password. And you'll have to spend a little time waiting for the commands to complete.

Client
------
* In `client_deploy.sh`, set the name of the remote server and the sudoer user on the server:
```bash
    ### <<< HARD-CODED
    sudoer=sudoer_user
    server=example.com'
    ### HARD-CODED >>>
```
* Place `client_deploy.sh` (or a symbolic link to it) in the root directory of your Meteor project
* Use `chmod 755 client_deploy.sh` to make the script executable.


Server
------
* In `server_deploy.sh`, set the names for:
    - the unprivileged user who owns the Meteor process on the server
    - the group to which the user belongs
    - the folder where the `bundle` is to be installed
    - the argument to use to trigger a mongodb script before relaunching the server
```bash
    ### <<< HARD-CODED
    user=unprivileged_user
    group='www-data'
    folder=/var/www/example/
    mongo_flag=run_mongo_script
    ### HARD-CODED >>>
```
* Place `server_deploy.sh` in the sudoer user's home directory, which is where the `package.tar.gz` file will be uploaded to.
* Use `chmod 755 server_deploy.sh` to make the script executable.


* In `replace_bundle.sh`, set the path to the version of npm that the unprivileged user (owner of the Meteor process) has access to:
```bash
    ### <<< HARD-CODED
    npm_path=/home/meteor/.nvm/versions/node/v12.16.2/bin
    ### HARD-CODED >>>
```
* Place `replace_bundle.sh` in the folder where the `bundle` is to be installed, that you previously defined in `server_deploy.sh`
* Use `sudo chmod 755 replace_bundle.sh` to make the script executable.
* Use `sudo chown unprivileged_user:group replace_bundle.sh` so that it can be run by the user who owns the Meteor process.

* In `mongo.js`, set the IP address, and the port number that MongoDB will use, and the name of the database that is defined in your nginx .conf file for this app

```javascipt
    // <<<HARD-CODED
    const ip_address = '127.0.0.1'
    const port = 27017
    const db_name = meteor
    // HARD-CODED >>>
```

* You can customize the JavaScript code to fix errors in the MongoDB installation, or to update it.
* Place the `mongo.js` file in the same directory as `replace_bundle.sh`

Use
===
* On your development machine, `cd` to the root directory of your app, where `client_deploy.sh` is located
* Run `./client_deploy.sh`
* Wait for the packaging and upload process to finish.
* When the Terminal prompt is available for input again, you will be logged in to your remote server
* Run `sudo ./server_deploy.sh` or `sudo ./server_deploy.sh run_mongo`
* You will be asked for your password
* Use the former command for a simple deployment, and the latter if you want Mongo to run the `mongo.js` script before your Meteor app is relaunched.
* When the installation process is complete, lauch your browser and open your app to check that all is working as expected.
* If there are any problems, you can revert to your previous version:
    * Delete the latest `build` folder in your `/var/www/example/` directory
    * Rename the most recent (highest-numbered) `build.xxxx` to `build`
    * Restart nginx