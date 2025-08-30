import os
import sys
import shutil
import pandas as pd
import common
import common.files as cf

book_id = 'SoYourHomeworld'
# Read book info for the target
# book_info = cf.read_book_info()
# book_id = book_info['id']
##

font_file_df = pd.read_csv('temp/font_files.csv', index_col=0)
print(font_file_df)

# Don't need the path anymore
font_file_df = font_file_df.drop(columns=['path'])

font_file_df.to_csv('generated_book/font_files.csv', index=True)

# Pack to JSON for Flutter to grab off the server
import json
import jsonpickle



class FF:
    fonts = {}
    def __init__(self, ix, row):
        self.ix = ix
        self.fam = row['family']
        self.files = [row['file']]
        self.count = row['count']
    def add(self, row):
        file = row['file']
        if file not in self.files:
            self.files.append(file)
        self.count += row['count']
    def addToDict(ix, row):
        if ix in FF.fonts:
            FF.fonts[ix].add(row)
        else:
            FF.fonts[ix] = FF(ix, row)
    def pack(self):
        return {'i': self.ix, 'f': self.fam, 'l': self.files}
    def sortedList():
        fonts = list(FF.fonts.values())
        fonts = sorted(fonts, key= lambda f: -f.count)
        return fonts

for ix, row in font_file_df.iterrows():
    FF.addToDict(ix, row)

jsonFonts = []
l = FF.sortedList()
for font in l:
    jsonFonts.append(font.pack())

filename = f'generated_book/font_files.json'
with open(filename, 'w') as f:
    str1 = jsonpickle.encode(jsonFonts)
    f.write(str1)

# Convert to JSON
# font_file_df.to_json(f'generated_book/{book_id}/font_files.json')
