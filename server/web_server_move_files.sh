#!/usr/bin/env bash

cd /home/protected/

if [[ $* == *--help* ]]
then
        echo "--Help: show this text"
        echo "--fast: Skips period of mourning for github folder"

        exit 0
fi


cd soyourhomeworldisunderattack
echo "Wiping github"
git restore .
echo "Pulling from github"
git pull
cd ..
echo ""
echo "Old /public/:"
ls /home/public/

# Move javascript code
rm -r /home/public/web/
mv soyourhomeworldisunderattack/server/web /home/public/
# Move book files
rm -r /home/public/book_binary/
mv soyourhomeworldisunderattack/server/book_binary /home/public/
# Move images
rm -r /home/public/images/
mv soyourhomeworldisunderattack/server/images /home/public/
# Move fonts
rm -r /home/public/hosted_fonts/
mv soyourhomeworldisunderattack/server/hosted_fonts /home/public/

echo ""
echo "/public/:"
ls /home/public/

if [[ $* != *--nodelete* ]]
then

cd soyourhomeworldisunderattack/

echo "Say goodbye to these:"
echo "$pwd"
ls

# delete all non-hidden files for space constraints
rm -r *
# restore to avoid accidentally pushing
git restore .

#show destruction
echo ""
echo "Github folder:"
ls -a

#go to parent directory
cd ..


fi

echo "/home/public/:"
ls /home/public/
