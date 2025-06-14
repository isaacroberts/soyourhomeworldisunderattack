#!/bin/bash
shopt -s expand_aliases
source ~/.profile

rm -r ../book_binary/
mkdir ../book_binary/

mv -f generated_book/* ../server/book_binary/

python move_fonts.py
