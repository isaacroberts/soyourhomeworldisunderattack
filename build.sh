#!/bin/bash
source ~/.profile
shopt -s expand_aliases



build_mode='release'
if [[ $* == *--profile* ]];
then
  build_mode='profile'
fi
if [[ $* == *--debug* ]];
then
  build_mode='debug'
fi


src_root='/web/'
local_folder='server/web/'

echo "Making directories"
backup_directory='backup/web_backup/'
mkdir -p 'backup/'
rm -rf $backup_directory
mv $local_folder $backup_directory
# rm -r $local_folder
# mkdir $local_folder


echo "Building in $build_mode"
# if [ ! -f "build/web/$versfolder.js" ]; then
#     # Clean because it doesn't remake flutter.js & canvaskit otherwise
#     flutter clean
# fi

flutter build web --$build_mode --base-href=$src_root &&
echo "Moving" &&
mv ./build/web/ $local_folder &&

# this overwrites index.html
# cp -r web/* $local_folder/ &&



# assets/fonts already has something from Flutter
# Just merge them
# cp templates/assets/assets/fonts/* templates/assets/fonts/
# rm -r templates/assets/assets/fonts

# # Fixes fucked assets thing
# mv templates/assets/assets/* templates/assets/
# rm -r templates/assets/assets/

notify
