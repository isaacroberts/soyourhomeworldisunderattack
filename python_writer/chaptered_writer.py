import jsonpickle

from objects import *
import common.files as cf
from common.logger import *

import pyperclip
import re
import os

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst

pst.use_logger(print)

from common.fmt_writer_functions import *

if __name__=="__main__":
    pst.DEBUG=False

logger_start('fmt_writer')

change_log_file('spans')

chapters, fonts = cf.read_spans_and_fonts('chapters.json', 'fonts_cleaned.json')

# Read book info
f= open('temp/book.json', 'r')
str1 = f.read()
f.close()

book_info = jsonpickle.decode(str1)
book_id = book_info['id']
##

for chapter in chapters:
    chapter.book_id = book_id

cf.chapter_health_inspection(chapters)

change_log_file('generate files')
print("""
========= Begin fmt_writer code ===================
""")

pst.button()

for chapter in chapters:
    chapter.setup_binary()

    for span in chapter.spans:
        span_type = type(span).__name__

        if span_type=='Header':
            print("Header", span.get_text())
            chapter.output += headerElement(span)
        elif span.isCode():
            chapter.output += code_element(span)
        else:
            chapter.output += typedLine(span)

for i in range(len(chapters)):
    chapters[i].writeChapter()

change_log_file('.index')
print("""
        .index
""")

bin = BinList("Index")

bin += '+'

for chapter in chapters:
    bin += chapter.chapter_info()

bin += ';'

f= open(f'generated_book/{book_id}/index', 'wb')
f.write(bin.bstr)

logger_end()

print('>Writer Done<')
