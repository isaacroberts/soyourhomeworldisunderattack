from bs4 import BeautifulSoup
import bs4

import os

from objects import *
from common import *

from common.style_handler import StyleHandler

# from objects.code_objects import *

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst

if __name__=="__main__":
    # pst.DEBUG=True
    pass

assert len(sys.argv)>=2, 'Must provide input unzipped folder'
folder = sys.argv[1]

logger_start('reader')

    # print("This isn't going to run because you need to change the aligns.")
    # print("Currently it's on the fonts (you've commented font.align but not the calls) ")
    # print("The align needs to be extracted and moved to the text element.")
    # exit(1)


with open(os.path.join(folder,'styles.xml'), 'r') as f:
    file = f.read()
# print(len(file))
# 'xml' is the parser used. For html files, which BeautifulSoup is typically used for, it would be 'html.parser'.
style_soup = BeautifulSoup(file, 'xml')


with open(os.path.join(folder, 'content.xml'), 'r') as f:
    file = f.read()
# print(len(file))
# 'xml' is the parser used. For html files, which BeautifulSoup is typically used for, it would be 'html.parser'.
content_soup = BeautifulSoup(file, 'xml')


def find_font_families(soup):
    fams = style_soup.find_all('style:font-face')
    fams = [f['style:name'] for f in fams]
    return fams

change_log_file('families')

fams = find_font_families(style_soup)
print('\n'.join(fams))
pst.button()

change_log_file('styles')

master_styles = style_soup.find_all('style:style')
sub_styles = content_soup.find_all('style:style')

# print(soup.prettify())

print(len(master_styles),'styles')
# styles = styles[:60]
# exit(0)
style_handler = StyleHandler()

#
for style in master_styles:
    print(style['style:name'])
    print(style.attrs)
    # print(style.__dict__)

    style_handler.read(style, is_sub_font=False)
            # assert isinstance(font.size, double)


for style in sub_styles:
    print(style['style:name'])
    print(style.attrs)

    style_handler.read(style, is_sub_font=True)


print('Wo fill')
print(style_handler.fonts)
pst.click()
print(style_handler.sub_fonts)
pst.click()


print('Parents:')

ss = ''
for s in style_handler.sub_fonts.values():
    if s.parent is not None:
        ss += f'{s.tag} -> {s.parent}), '
# s = ', '.join(s.tag+': '+ s.parent for s in style_handler.sub_fonts.values())
# print('{',s,'}')

# exit(1)
style_handler.fill_masters()
# print(fonts)
print('Filled:')
print(style_handler.fonts)
pst.click()
print(style_handler.sub_fonts)
pst.click()


"""
 ================ Acquire Text =============
"""

change_log_file('text')

# Use BeautifulSoup to find paragraphs & headers
paras = content_soup.find_all(['text:p', 'text:h'])

spans = []

# ==== Scrape all elements & fonts out of document
for para in paras:

    # font tag
    tag = para.attrs['text:style-name']

    # Guaranteed to have the font & align, unless something's wrong
    font, align = style_handler.get_font(tag)

    # Newline
    if len(para.contents)==0:
        print(f'>\t\t\tNL(empty paragraph)')
        spans.append(NewLine(font))
        print(spans[-1])

    # Process paragraph
    else:

        def add_line_of_text(font, text, align):
            """
            Adds either TextSpan or Header, depending on font
            """
            # If text is empty
            if len(text)==0:
                # Add NewLine with correct spacing
                print(f'>\t\t\tNL(empty maybe_header)')
                spans.append(NewLine(font))
            else:
                if font is None:
                    assert False, 'None font for Header'
                    print(f'(!)\t\t\tNull-font Header("{text}")', '\n' in text)
                    spans.append(Header(font, text, align))

                # Header font means Header object
                elif font.isHeading:
                    print(f'>\t\t\tHeader("{text}")', '\n' in text)
                    spans.append(Header(font, text, align))
                else:
                    # Non-header TextSpan
                    print(f'>\t\t\tText("{text}")', '\n' in text)
                    spans.append(TextSpan(font, text, align))

        # Sometimes fonts roll over to the next span
        # So these are global variables
        temp_font = font
        temp_align = align

        def add_misc_element(font, c, is_first_such_span):
            """
            Handle non-standard object.
            These aren't used
            """
            global temp_font
            global temp_align

            assert font is not None, f"! None font in handle_Misc: c='{c}' first_span = '{is_first_such_span}'"

            print('\t\tMisc:', c)
            # Span
            if c.name=='span':
                # If has font
                if 'text:style-name' in c.attrs:
                    # Update rolling font
                    temp_font_name = c.attrs['text:style-name']
                    # Assumed to be in []
                    # subfonts are a COMBINATION of 'P32' + arbitary parent font
                    tup = style_handler.fill_sub(temp_font_name, font)
                    temp_font, temp_align = tup

                print('\t', 'contents:', c.contents)
                #Check contents of span
                for cc in c.contents:
                    # If tag
                    if isinstance(cc, bs4.element.Tag):
                        # Then it's not text
                        add_misc_element(temp_font, cc, is_first_such_span)
                    else: #Else
                        # Must be string
                        assert(isinstance(cc, str))
                        # Add line of text with rolling font
                        add_line_of_text(temp_font, cc, temp_align)
                    is_first_such_span=False
            # Tab element
            elif c.name == 'tab':
                print(f'>\t\t\tTextSpan("\\t")')
                spans.append(TextSpan(font, '\t', align))
            # Page break
            elif c.name == 'soft-page-break':
                print(f'>\t\t\tMiscToken("{c.name}")')
                spans.append(MiscToken(c.name))
            # Single space
            elif c.name=='s':
                # Single space
                spc = ' '
                # Count
                if 'text:c' in c.attrs:
                    count = int(c.attrs['text:c'])
                    spc = ' ' * count
                print(f'>\t\t\tText("{spc}")')
                spans.append(TextSpan(font, spc, align))
            # Line break
            elif c.name=='line-break':
                if is_first_such_span:
                    # Add fixed NewLine
                    print(f'>\t\t\tNL(starting line break)')
                    spans.append(NewLine(font))
                else:
                    # Prevents joins later.
                    # I think there's another NewLine added later
                    print(f'>\t\t\tEndOfPara()')
                    spans.append(EndOfPara())
            # Only other types of elements
            elif c.name in ['bookmark-start', 'bookmark-end']:
                print('Skipping', c.name)
                pass
            elif c.name == 'a':
                print('Unhandled web link: ', c)
                assert False, 'Unhandled text type: '+ c.name
            else:
                # Crash just to make sure we don't miss something
                print('Unhandled element: ', c)
                assert False, 'Unhandled text type: '+ c.name

        # Beginning of span
        is_first_such_span = True
        # For contents
        for c in para.contents:
            print('\tContents:', c)
            if isinstance(c, str):
                if c=='\n':
                    print('>\t\t\tNL(empty text)')
                    spans.append(NewLine(font))
                else:
                    # String uses main font
                    # TODO: Check whether it should use rolling font
                    add_line_of_text(font, c, align)
                    is_first_such_span=False
                    print(spans[-1])
            elif isinstance(c, bs4.element.Tag):
                # Misc element
                add_misc_element(font, c, is_first_such_span)
                is_first_such_span = False

        print(f'>\t\t\tEndOfPara()')
        # Prevents joins later
        spans.append(EndOfPara())

    print('')

"""
TODO: Fix variadic font families.
    Ex: Montserrat2
"""

print('Text Acquired')
pst.button()

# Log file
change_log_file('code tags')

print('Find Code Tags')

# Code tag style name in ODT file
code_tag_base_name = 'code_5f_marker'

#Search for code tags
for i in range(len(spans)):
    if isinstance(spans[i], TextSpan):
        if spans[i].font.isCodeMarker():
            print('->CodeTag', spans[i])
            # Convert to CodeTag
            spans[i] = CodeTag(spans[i].text, spans[i].font)

print("Clean CodeTags")
i=1
while i < len(spans):
    if isinstance(spans[i], CodeTag):
        # Remove blank code tags
        if len(spans[i].text)==0:
            spans.pop(i)
            i-=1
        # Merge neighboring CodeTags
        #(sometimes the xml format splits them up for no reason)
        elif isinstance(spans[i-1], CodeTag):
            # Combine function checks for newlines and shit
            did_combine = spans[i-1].combine(spans[i])
            # Remove if they were combined
            if did_combine:
                spans.pop(i)
                i-=1
                print('Combined:', spans[i])
    # Increment span index
    i+=1

pst.button()

# Font Management
change_log_file('styles')

# Currently, style_handler has the fonts that were found during span search

style_handler.assert_all_fonts_extant(spans, 'begin')

print('Finding dupes')
# Creates lookup dict and removes old fonts
style_handler.find_and_delete_dupes()

style_handler.assert_all_fonts_extant(spans, 'post_find')

print("Fixing Names")
# Removes symbols from tags
style_handler.fix_names()


style_handler.assert_all_fonts_extant(spans, 'post namefix')

print('Repl dict:{{{{{{{{{{{{{{{{{{{\n')

print(style_handler.repl_dict)

print('\n}}}}}}}}}}}}}}}}}}}')



print("Replacing fonts")
# Collects all fonts in span
style_handler.replace_fonts(spans)




style_handler.assert_all_fonts_extant(spans, 'post_repl')


# Make spans pickleable by replacing font objects with tags
style_handler.convert_to_tags(spans)

print("Deleting dupes")
# Deletes repl_dict as well
style_handler.cleanup_dupes()


style_handler.assert_all_fonts_extant(spans, 'end')


print("Finding files")
style_handler.find_files()

print(style_handler.fonts)
# exit(0)

style_handler.write('fonts_raw.json')

print('Writing')
change_log_file('writing')

import common.files as cf

cf.save_spans(spans, 'spans_raw.json')

logger_end()

# pst.unfinished(False)
print('>Xml Reader Done<')
pst.end()
