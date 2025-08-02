#!/bin/bash

dir=`pwd`

if [[ $dir != "/home/titzak/Documents/McKinsey Plan/soyourhomeworldisunderattack/python_writer" ]];
then
  echo "Must be in python_writer directory!"
  echo "You are in: $dir"
  exit 1
fi
rm -r temp/
rm -r log/

fc-list > data/font_table_raw.txt
python _font_lookup_creator.py
