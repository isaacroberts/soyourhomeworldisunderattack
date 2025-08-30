#!/bin/bash
shopt -s expand_aliases
source ~/.profile

rm -r ../server/book_binary/
mkdir ../server/book_binary/ &&

mv -f generated_book/* ../server/book_binary/ &&

mv ../server/book_binary/font_files.csv ../server/

notify
