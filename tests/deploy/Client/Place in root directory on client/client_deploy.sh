#!/usr/bin/env bash

### <<< HARD-CODED
sudoer=blackslate
server='94.76.206.212'
### HARD-CODED >>>

remote=$sudoer@$server
echo "Build a server-only package"
meteor build --server-only ../new_package
mv ../new_package/*.tar.gz package.tar.gz

echo "Upload the package to ${remote}:~ and log in"

scp package.tar.gz $remote:~
ssh $remote