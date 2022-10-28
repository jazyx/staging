#!/usr/bin/env bash

echo "Executing $0 in $(PWD)"

### <<< HARD-CODED
sudoer=blackslate
server='94.76.206.212'
server_script='dev_deploy.sh'
### HARD-CODED >>>

remote=$sudoer@$server
echo "Build a server-only package"
meteor build --server-only ../new_package
mv ../new_package/*.tar.gz package.tar.gz

echo "Upload the package to ${remote}:~ and log in"

scp package.tar.gz $remote:~

echo "Upload ${server_script} to ${remote}"
scp ${server_script} $remote:~

ssh $remote