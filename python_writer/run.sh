#!/bin/bash
shopt -s expand_aliases
source ~/.profile

if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    echo "Must provide input ODT"
    exit 1
fi


dir= pwd
if [ $dir -ne "/home/titzak/Documents/McKinsey Plan/webapp/python_writer" ]
then
  echo "Must be in python_writer directory!"
  exit 1
fi

# python odt_to_xml.py $1 &&
odt_file="$1"
echo cp "$odt_file" temp/
cp "$odt_file" temp/
odt_file=temp/${odt_file##*/}
echo "$odt_file"
# exit 0

# Remove ext
dir="${odt_file%.*}"

# Log file directory
rm -r log/
mkdir log/

# Generated folder
mkdir -p generated

# Remove existing unzipped book
rm -r "$dir" #2>/dev/null
mkdir -p "$dir"

# Unzip BookTitle.odt
unzip "$odt_file" -d "$dir" &&
# BookTitle/**
python reader.py "$dir" &&
# spans_raw.json && fonts_raw.json

python font_counter.py &&
# spans_raw.json && fonts_cleaned.json

python cleaner.py &&
# spans_clean.json && fonts_cleaned.json
python code_parser.py &&

python book_inspector.py &&

# spans_coded.json && fonts_cleaned.json
python chapter_breaker.py &&
# chapters.json && fonts_cleaned.json
python chaptered_writer.py &&
# generated/**.dart
# echo "Moving" &&

# python index_writer.py &&

echo "Fmt runner done" &&

./move.sh &&
echo "Moved" && 

notify


rm -r "$dir" 2>/dev/null
rm -r "$odt_file"
