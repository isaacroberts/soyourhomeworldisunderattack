
import objects.fonts as FONTS
from objects.fonts import Font
from objects.text_obj import *

import font_lookup

import common.files as cf
import pyperclip
from common.logger import *
# import re
# import os

logger_start('font_counter')

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst

if __name__=="__main__":
    # pst.DEBUG=True
    pass

change_log_file('start')

spans, fonts = cf.read_spans_and_fonts('spans_raw.json', 'fonts_raw.json')

print('Fonts =', fonts)

font_counts = {}

def spanWalker():
    for span in spans:
        yield from span.elemWalker()

for span in spanWalker():
    if hasattr(span, 'font'):
        font = span.font
        if font is None:
            assert not span.hasFont()
        elif not font.isCodeMarker():
            if font in font_counts:
                font_counts[font] +=1
            else:
                font_counts[font] = 1

font_counts = list(font_counts.items())
font_counts = sorted(font_counts, key=lambda x: -x[1])

pst.button()
change_log_file('font_files')

print()
print()
print()

def file_pretty(file):
    file = file.split('/')[-1]
    file = file.split('.')[0]
    return file

file_cts = {}
missed_files= []
font_files = {}

def defined_file_ids(family):
    return font_lookup.get_font_id(family)

class FontFile():
    def __init__(self, family, basename, path):
        self.id = defined_file_ids(family)
        self.family = family
        self.path = path
        self.file = basename
        self.count = 1
    def as_dict(self):
        return {'id': self.id, 'family':self.family,'path':self.path, 'file':self.file, 'count':self.count}

"""
TODO: Fix Font File ID
"""

for font in fonts.values():
    if font.isCodeMarker():
        font.file = None
    else:
        # if font.file is None
        file = font_lookup.find_font_file(font)

        if file == '-':
            pkg = (font.family, font.italic)
            missed_files.append(pkg)
            font.file = '-'
            font.fileId = -1
        else:
            path = file
            file = file.split('/')[-1]

            if file not in font_files:
                font_files[file] = FontFile(font.family, file, path)
            else:
                font_files[file].count+=1

            font.file = file
            font.fileId = font_files[file].id

            # print(file_pretty(file))

def space_row(s, width):
    if not isinstance(s, str):
        s = str(s)
    s += ' '*(width-len(s))
    s = s[:width]
    return s

print('.')
print(space_row('Family', 15)+' '+space_row('File', 30) +space_row('Id', 8) +  space_row('Count', 4))

for font_file in font_files.values():
    s = file_pretty(font_file.family)
    print(space_row(s, 15)+' '+space_row(font_file.file, 30) + space_row(font_file.id, 8)+ space_row(font_file.count, 4))

print('.')
missed_files = set(missed_files)
missed_files = list(missed_files)
print('> Missed files:', 'None' if len(missed_files)==0 else '')
for family, ital in missed_files:
    print('x', family, 'italic' if ital else 'straight')

# Write paths to font files in CSV
import pandas as pd
# self.id = defined_file_ids(basename)
# self.family = family
# self.path = path
# self.file = basename
# self.count = 1
font_file_df = pd.DataFrame([ff.as_dict() for ff in font_files.values()])

print(font_file_df)

font_file_df.to_csv('temp/font_files.csv', index=False)

# Write paths to font files for script
# with open('temp/font_files.txt', 'w') as f:
#     s = ''
#     for ff in font_files.values():
#         s += ff.id + ':'+ ff.path
#         s += '\n'
#     f.write(s)
#     f.close()


logger_end()

import json
import jsonpickle

font_dict = {}
for font, ct in font_counts:
    font.count = ct
    font_dict[font.tag] = font


with open('temp/fonts_cleaned.json', 'w') as f:
    str1 = jsonpickle.encode(fonts)
    f.write(str1)

# with open(f'temp/fonts_cleaned.json', 'w') as f:
#     # Order is important
#     str1 = jsonpickle.encode(defined_values)
#     f.write(str1)



print('>Font Counter Done<')
pst.end(False)

# # pyperclip.copy('mv generated_dart/styles.dart ../lib/generated/')
# cmd = 'mv generated/styles.dart ../lib/generated/'
# print(cmd)
# r = pst.response('Move generated styles?')
# if r[0] in 'y':
#     # import subprocess
#     # subprocess.run(['mv ' 'generated_dart/styles.dart ' '../lib/generated/'])
#     import os
#     os.system(cmd)
