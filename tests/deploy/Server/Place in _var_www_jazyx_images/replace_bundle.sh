#!/usr/bin/env bash

### <<< HARD-CODED
npm_path=/home/meteor/.nvm/versions/node/v12.16.2/bin
### HARD-CODED >>>

echo "Add ${npm_path} to PATH so that npm is accessible"
PATH=$PATH:$npm_path

# echo "Rename current bundle for archival purposes"
# max=0
# filename="bundle"

# for entry in "./${filename}"*
# do
#   # Strip string common to all matching filenames
#   entry=${entry#"./bundle"} # "./bundle" itself will be empty
#   if [ -n "$entry" ];
#   then
#     # Strip leading . and zeros, so conversion to number gives decim$
#     entry=${entry#"."}
#     ext=$(echo $entry | sed 's/^0*//')

#     # Convert to a number
#     ext="$((${ext} + 0))"

#     if [ $ext -gt $max ];
#     then
#       max=$ext
#     fi;
#   fi;
# done

# # Convert to decimal number; add 1
# max="$((${max} + 1))"

# # Pad with zeros
# if [ $max -lt 10 ];
# then
#   max="000${max}"
# elif [ $max -lt 100 ];
# then
#   max="00${max}"
# elif [ $max -lt 1000 ];
# then
#   max="0${max}"
# fi;

# mv $filename "${filename}.${max}"
# echo "bundle renamed as ${filename}.${max}"
#ls -al

# echo "Unzip package.tar.gz"
# tar xzf package.tar.gz
#ls -al

# echo "Deleting package.tar.gz"
# rm package.tar.gz
# ls -al

cd bundle/programs/server
echo -n "Install package at "; pwd;
echo -n "as user "; whoami
npm install --production