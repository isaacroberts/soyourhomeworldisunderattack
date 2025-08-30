
import objects.font_obj as FONTS
from objects.font_obj import Font
from objects.text_obj import *

import font_lookup

import common.files as cf
import pyperclip
from common.logger import *
# import re
# import os


import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst


def do_all(spans_file='spans_raw.json', fonts_file='fonts_raw.json', csv_output='font_files.csv', font_output='fonts_clean.json'):
    logger_start('font_counter')
    change_log_file('start')

    _, fonts = cf.read_spans_and_fonts(spans_file, fonts_file)
    print('Fonts =', fonts)

    fonts, font_files = clean_fonts(fonts)

    change_log_file('writing')

    write_fonts(fonts, font_output)
    write_csv(font_files, csv_output)
    logger_end()

def clean_fonts(fonts):
    logger_start('font_counter')
    change_log_file('clean')

    print()
    print()
    print()

    file_cts = {}
    missed_files= []
    font_files = {}

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
                print("Missed file: ", pkg)

                # Default to Palatino
                font.family = 'Palatino'
                # Get file
                file = font_lookup.find_font_file(font)
                font.fileId = 0
                # exit(1)
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

    print('.')
    print(space_row('Family', 15)+' '+space_row('File', 30) +space_row('Id', 8) +  space_row('Count', 4))

    for font_file in font_files.values():
        s = file_pretty(font_file.family)
        print(space_row(s, 15)+' '+space_row(font_file.file, 30) + space_row(font_file.id, 8)+ space_row(font_file.count, 4))

    change_log_file('missed_files')

    print('.')
    missed_files = set(missed_files)
    missed_files = list(missed_files)
    print('> Missed files:', 'None' if len(missed_files)==0 else '')
    for family, ital in missed_files:
        print('x', family, 'italic' if ital else 'straight')

    return fonts, font_files


def count_fonts(spans, fonts):

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

    return font_counts


def write_csv(font_files, csv_name='font_files.csv'):
    if csv_name is not None:
        import pandas as pd
        font_file_df = pd.DataFrame([ff.as_dict() for ff in font_files.values()])
        print(font_file_df)
        font_file_df.to_csv('temp/'+csv_name, index=False)

def write_fonts(fonts, filename):
    import json
    import jsonpickle

    with open('temp/'+filename, 'w') as f:
        str1 = jsonpickle.encode(fonts)
        f.write(str1)

# ======== Various utilities =============


class FontFile():
    def __init__(self, family, basename, path):
        self.id = font_lookup.get_font_id(family)
        self.family = family
        self.path = path
        self.file = basename
        self.count = 1
    def as_dict(self):
        return {'id': self.id, 'family':self.family,'path':self.path, 'file':self.file, 'count':self.count}

def file_pretty(file):
    file = file.split('/')[-1]
    file = file.split('.')[0]
    return file

def space_row(s, width):
    if not isinstance(s, str):
        s = str(s)
    s += ' '*(width-len(s))
    s = s[:width]
    return s


# ========== Main =================

if __name__=="__main__":
    do_all()
    # raws_to_counted('spans_raw.json', 'fonts_raw.json')
    print('>Font Counter Done<')
    pst.end(False)
