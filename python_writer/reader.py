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

def read_folder(folder):
    logger_start('reader')

    with open(os.path.join(folder, 'content.xml'), 'r') as f:
        file = f.read()
    # 'xml' is the parser used. For html files, which BeautifulSoup is typically used for, it would be 'html.parser'.
    content_soup = BeautifulSoup(file, 'xml')

    with open(os.path.join(folder,'styles.xml'), 'r') as f:
        file = f.read()
    style_soup = BeautifulSoup(file, 'xml')

    # Result not used
    # fams = find_font_families(style_soup)

    return soup_to_processed_spans(content_soup, style_soup)

def soup_to_processed_spans(content_soup, style_soup):
    # Process document styles
    style_handler = soup_to_styles(style_soup, content_soup)
    # Read XML to spans
    spans = soup_to_raw_spans(content_soup, style_handler)
    # Preliminary clean of code tags
    spans = clean_raw_code_tags(spans)
    # End step on styles
    manage_raw_styles(style_handler, spans)
    return style_handler, spans

def get_font_families(style_soup):
    change_log_file('families')

    # Move this later
    fams = find_font_families(style_soup)
    print('\n'.join(fams))
    pst.button()

    fams = style_soup.find_all('style:font-face')
    fams = [f['style:name'] for f in fams]
    return fams

def soup_to_styles(style_soup, content_soup):

    change_log_file('styles')
    try:
        master_styles = style_soup.find_all('style:style')
        sub_styles = content_soup.find_all('style:style')

        # print(soup.prettify())

        print(len(master_styles),'styles')
        # styles = styles[:60]

        style_handler = StyleHandler()
        style_handler.health_inspection()
        #
        for style in master_styles:
            print('Master style:', style['style:name'])
            # print(style['style:name'])
            # print(style.attrs)

            style_handler.read(style, is_sub_font=False)
                    # assert isinstance(font.size, double)

        style_handler.health_inspection()
        for style in sub_styles:
            print(style['style:name'])
            print(style.attrs)

            style_handler.read(style, is_sub_font=True)


        style_handler.health_inspection()
        print('Wo fill')
        print(style_handler.fonts)
        print(style_handler.sub_fonts)
        pst.click(3)

        print('Parents:')

        ss = ''
        for s in style_handler.sub_fonts.values():
            if s.parent is not None:
                ss += f'{s.tag} -> {s.parent}), '
        # s = ', '.join(s.tag+': '+ s.parent for s in style_handler.sub_fonts.values())
        print(ss)
        # ERR!
        style_handler.fill_masters()
        # print(fonts)
        print('Filled:')
        print(style_handler.fonts)
        print(style_handler.sub_fonts)
        pst.click(3)
    finally:
        logger_end()
    return style_handler


"""
 ================ Acquire Text =============
"""

class StateBasedHorseshit:
    # Sometimes fonts roll over to the next span
    # So these are global variables
    def __init__(self):
        self.is_first_such_span = True
        self.font = Font.body('base')
        self.align = 'l'
        self.style_handler = None

def soup_to_raw_spans(content_soup, style_handler):
    change_log_file('text')

    # Use BeautifulSoup to find paragraphs & headers
    paras = content_soup.find_all(['text:p', 'text:h'])

    spans = []
    state = StateBasedHorseshit()
    state.style_handler = style_handler

    # ==== Scrape all elements & fonts out of document
    for para in paras:
        newspans = para_to_spans(state, para)
        spans.extend(newspans)

    print('Text Acquired')
    pst.button()
    return spans

# Utilities

def get_line_of_text(state, text):
    """
    Adds either TextSpan or Header, depending on font
    """
    font = state.font
    align = state.align
    # If text is empty
    if len(text)==0:
        # Add NewLine with correct spacing
        print(f'>\t\t\tNL(empty maybe_header)')
        return NewLine(font)
    else:
        if font is None:
            assert False, 'None font for Header'
            print(f'(!)\t\t\tNull-font Header("{text}")', '\n' in text)
            return Header(font, text, align)

        # Header font means Header object
        elif font.isHeading():
            print(f'>\t\t\tHeader("{text}")', '\n' in text)
            return Header(font, text, align)
        else:
            # Non-header TextSpan
            print(f'>\t\t\tText("{text}")', '\n' in text)
            return TextSpan(font, text, align)

def add_spans(spans, obj):
    if isinstance(obj,list):
        spans.extend(obj)
    elif obj is None:
        pass
    else:
        spans.append(obj)

def get_contents(state, c):
    spans = []
    print('\t', 'contents:', c.contents)
    #Check contents of span
    for cc in c.contents:
        # If tag
        if isinstance(cc, bs4.element.Tag):
            # Then it's not text
            line = get_misc_element(state, cc)
            add_spans(spans, line)
        else: #Else
            # Must be string
            assert(isinstance(cc, str))
            # Add line of text with rolling font
            line = get_line_of_text(state, cc)
            add_spans(spans, line)
        state.is_first_such_span=False
    return spans

def get_misc_element(state, c):
    """
    Handle non-standard object.
    Returns a list
    """

    font = state.font
    align = state.align
    assert font is not None, f"! None font in handle_Misc: c='{c}' first_span = '{state.is_first_such_span}'"
    spans = []

    print('\t\tMisc:', c)
    # Span
    if c.name=='span':
        # If has font
        if 'text:style-name' in c.attrs:
            # Update rolling font
            temp_font_name = c.attrs['text:style-name']
            # Assumed to be in []
            # subfonts are a COMBINATION of 'P32' + arbitary parent font
            state.font, state.align = \
                state.style_handler.fill_sub(temp_font_name, font)
            font = state.font
            align = state.align

            add_spans(spans, get_contents(state, c))
        return spans
    # Tab element
    elif c.name == 'tab':
        print(f'>\t\t\tTextSpan("\\t")')
        return TextSpan(font, '\t', align)
    # Page break
    elif c.name == 'soft-page-break':
        print(f'>\t\t\tMiscToken("{c.name}")')
        return MiscToken(c.name)
    # Single space
    elif c.name=='s':
        # Single space
        spc = ' '
        # Count
        if 'text:c' in c.attrs:
            count = int(c.attrs['text:c'])
            spc = ' ' * count
        print(f'>\t\t\tText("{spc}")')
        return TextSpan(font, spc, align)
    # Line break
    elif c.name=='line-break':
        if state.is_first_such_span:
            # Add fixed NewLine
            print(f'>\t\t\tNL(starting line break)')
            return NewLine(font)
        else:
            # Prevents joins later.
            # I think there's another NewLine added later
            print(f'>\t\t\tEndOfPara()')
            return EndOfPara()
    # Only other types of elements
    elif c.name in ['bookmark-start', 'bookmark-end']:
        print('Skipping', c.name)
        return None
    elif c.name == 'a':
        # We could later auto-fill this,
        # but for now we're assuming that the
        # author will wrap it in a Source widget
        print("\tLink:", c)
        # span = c.attrs['text:span']

        ct =  get_contents(state, c)
        print(f'>\t\t\tLink => {ct}')
        return ct
        # return get_misc_element(state, span)
    else:
        # Crash just to make sure we don't miss something
        print('Unhandled element: ', c)
        assert False, 'Unhandled text type: "'+ c.name +'"'
        return None

def para_to_spans(state, para):
    spans = []
    # font tag
    tag = para.attrs['text:style-name']

    # Guaranteed to have the font & align, unless something's wrong
    font, align = state.style_handler.get_font(tag)

    # Newline
    if len(para.contents)==0:
        print(f'>\t\t\tNL(empty paragraph)')
        spans.append(NewLine(font))
        print(spans[-1])

    # Process paragraph
    else:

        # Sometimes fonts roll over to the next span
        # So these are global variables
        state.font = font
        state.align = align

        # Beginning of span
        state.is_first_such_span = True
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
                    span = get_line_of_text(state, c)
                    print(span)
                    add_spans(spans, span)
                    state.is_first_such_span=False
            elif isinstance(c, bs4.element.Tag):
                # Misc element
                span = get_misc_element(state, c)
                print(span)
                add_spans(spans, span)
                state.is_first_such_span = False

        print(f'>\t\t\tEndOfPara()')
        # Prevents joins later
        spans.append(EndOfPara())

    return spans

# Top-level

def clean_raw_code_tags(spans):
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
    return spans

# Top-level

def manage_raw_styles(style_handler, spans):
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

    logger_end()


def xml_folder_to_raw_file(folder, spans_file='spans_raw.json', fonts_file='fonts_raw.json'):
    logger_start('reader')

    style_handler, spans = read_folder(folder)

    change_log_file('writing')
    style_handler.write(fonts_file)

    print("Log style handler:")
    style_handler.log()

    print('Writing')

    import common.files as cf

    cf.save_spans(spans, spans_file)

    logger_end()



if __name__=="__main__":
    # pst.DEBUG=True
    assert len(sys.argv)>=2, 'Must provide input unzipped folder'
    folder = sys.argv[1]
    xml_folder_to_raw_file(folder)
    # pst.unfinished(False)
    print('>Xml Reader Done<')
    pst.end()
