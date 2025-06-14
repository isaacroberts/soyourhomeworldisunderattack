import json
import jsonpickle

f= open('temp/book.json', 'r')
str1 = f.read()
f.close()

book_info = jsonpickle.decode(str1)

def missing_info(key):
    if key not in book_info:
        return True
    data = book_info[key]
    if len(data)==0:
        return True
    return False

# Manual inputs 
if missing_info('id'):
    book_info['id'] = input('Enter id')
if missing_info('title'):
    book_info['title'] = input('Enter title')
if missing_info('byline'):
    book_info['byline'] = input('Enter byline')
if missing_info('color'):
    book_info['color'] = input('Enter color')


with open(f'temp/book.json', 'w') as f:
    import jsonpickle
    str1 = jsonpickle.encode(book_info)
    f.write(str1)


book_id = book_info['id']

import os
from objects.binary import *


import shutil
if os.path.isdir('generated_book/'+book_id):
    shutil.rmtree('generated_book/'+book_id)
os.makedirs('generated_book/'+book_id, exist_ok=False )

bin = BinList("Book")

bin += '..\\/..'
bin += pack_text(book_id)
bin += 'T:'
bin += pack_text(book_info['title'])
bin += 'C:'
bin += pack_hex(book_info['color'])
bin += 'B:'
bin += pack_text(book_info['byline'])


bin += '>-*/\\*-<'

f= open(f'generated_book/{book_id}.book', 'wb')
f.write(bin.bstr)
