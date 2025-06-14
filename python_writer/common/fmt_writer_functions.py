

from objects import *
from objects.binary import *
import objects.code_objects as code_objects

import common.files as cf
import common.flutter_tools as flutter_tools

import random

import font_lookup as fl

"""
font characters:

TODO: Sub/super script
WOUSI= Weight Overline Underline Strikethrough Italics

# Specially coded predef, like Gator (so i can add effects)
Prdf    0x01 id: uint8

# Modified predef (add lator)
# CsPr    0x02 id: uint8 size:f32 wousi:byte underline:byte color:byte+

# Font file stored in app
Bkwd    0x02 ff_id: uint32 size:f32
Inln    0x04 ff_id: uint32 size:f32 wousi:byte color:byte+
CxIn    0x05 ff_id: uint32 size:f32 it+Wt:byte  ...

# Rare font file - will be sent at end of chapter
Chpt    0x03 ff_id: uint32 preload:byte size:f32

# SVG, for extra-rare files
Svgr    0x06 string: svg_url


Have 3 Font Categories
    Predefined (Gator, Gator Caption, etc) : PredefinedFontTextHolder(Holder) [can be overridden]
    Bookwide: Stored in the app.
    Chapterwide: Stored at the end of the binary. (why would you load the fonts first)
    Listed in-line. (font_file_id, size)
    Complex in-line. (font_file_id, size, +variadic_weight)

    Possibly an SVG-rasterizer (using an InlineImageSpan)
"""

TYPES = ['prdf', 'cspd', 'bkwd', 'inln', 'cxin', 'svgr']

def pack_typed_font(font, type, curChapter):
    assert type in TYPES
    ix = TYPES.find(type)
    code = ix + 1

    typebyte = pack_untyped_short(code)

    def byte(x):
        return pack_untyped_short(x)
    def uint(x):
        return pack_untyped_uint(x)
    def f32(x):
        return pack_untyped_float(x)

    match type:
        case 'prdf':
            fontId = get_predef_id(font)
            return [typebyte, byte(fontId)]
        case 'bkwd':
            fontId = get_bookwide_font_id(font)
            return [typebyte, uint(fotext_in_stylentId), f32(font.size)]
        case 'chpt':
            fontId = get_chapter_font_id(font)
            preload = font.get_preload()
            return [typebyte, uint(fontId), byte(preload), f32(font.size)]
        case 'inln':
            assert False, 'Unimplemented.'
            # pass
        case _:
            assert False, f'Unrecognized type {type} in pack_typed_font'
            #ff_id: uint32 size:f32 wousi:byte color:byte+


def pack_wousi(font):
    b = BinList("wousi")
    weight = font.getWeight()//10
    # TODO: Get overline / underline / strikethrough
    o = False
    u = False
    s = font.strikethrough()
    i = font.italic
    wousi = weight
    wousi = wousi << 1
    wousi += int(o) * 8
    wousi += int(u) * 4
    wousi += int(s) * 2
    wousi += int(i) * 1
    print(wousi)
    return struct.pack('!B', wousi)

def pack_font(font):
    if font.isBodyMinusAlign():
        return
    assert font is not CodeTag
    print('pack header font font=', font, 'type=',type(font))
    b = BinList('pack_font')
    # TODO: Move the parenthesis here for clarity
    if not hasattr(font, 'fileId'):
        font.fileId = fl.get_font_id(font.family)
    b += pack_typed_uint(font.fileId)
    b += pack_untyped_float(font.size)

    b += pack_wousi(font)
    return b

def pack_header_font(font):
    # TODO: If header has been modified
    assert font is not CodeTag

    b = BinList('pack_header_font')
    b += '('
    if not hasattr(font, 'fileId'):
        font.fileId = fl.get_font_id(font.family)
    b += pack_typed_uint(font.fileId)
    b += pack_untyped_float(font.size)

    b += pack_wousi(font)
    b += ')'
    return b

def get_align(span):
    align = span.align if hasattr(span, 'align') else 'l'
    if callable(align):
        align = align()
    return align[0]

def pack_ta_only(span):
    tab_amt = span.tabs if hasattr(span, 'tabs') else 0
    align = get_align(span)
    if tab_amt==0 and align=='l':
        return ''
    else:
        tabb = pack_untyped_short(tab_amt)
        alignb = pack_untyped_char(align)
        return  '(', tabb, alignb, ')'

def pack_font_section(span):
    tab_amt = span.tabs if hasattr(span, 'tabs') else 0
    align = get_align(span)

    tabb = pack_untyped_short(tab_amt)
    alignb = pack_untyped_char(align)

    print(span.font.tag)

    font = span.font

    b = BinList('pack_font_section')

    # Align is already handled
    if font.isBodyMinusAlign():
        if tab_amt==0 and align=='l':
            return None
        else:
            return b.add('(', tabb, alignb, ')')
    else:
        fb = pack_font(font)

        if font.hasBgCol():
            color = flutter_tools.flutterColor(font.bgCol)
            bgB = pack_hex(color)
            if font.hasColor():
                fg = flutter_tools.flutterColor(font.fontCol)
                fcB = pack_hex(fg)
                print('ColA:', color, 'fg', fb, font.tag)
                return b.add('(', tabb, alignb, '&', fb, '&', bgB, '&', fcB, ')')
            else:
                print('ColB:', color, font.bgCol, font.tag)
                return b.add('(', tabb, alignb, '&', fb, '&', bgB, ')')
        elif font.hasColor():
            bgB = pack_none()
            color = flutter_tools.flutterColor(font.fontCol)
            fcB = pack_hex(color)
            print('ColC:', 'None', color, font.tag)
            return b.add('(', tabb, alignb, '&', fb, '&', bgB, '&', fcB, ')')
        else:
            return b.add('(', tabb, alignb, '&', fb, ')')


def text_in_style(span):
    if span.isCode():
        assert False

    b = BinList('text_in_style')
    b += pack_text(span.text)
    b += pack_font_section(span)
    b += ';'
    return b


def headerElement(span):
    b = BinList('hdrElem')
    b += 'H'
    b += pack_text(span.text)
    #TODO: Add this
    # if !span.font.isHeading():
    if False:
        b += '('
        b += pack_font(span)
        b += ')'
    b += ';'
    return b

def fragText(span):
    if span.isCode():
        assert False

    b = BinList('fragText')

    b += pack_text(span.text)
    font = span.font
    if font.isBodyMinusAlign():
        # Align is already handled
        b += ';'
        return b
    else:
        b += '('
        b += pack_font(font)

        if font.hasBgCol():
            b += '&'
            b += pack_hex(font.bgCol)
            if font.hasColor():
                b += '&'
                b += pack_hex(font.fontCol)
        elif font.hasColor():
            b += pack_none()
            b += '&'
            b += pack_hex(font.fontCol)
    b += ');'
    return b

def multispanText(multispan):
    # Spans should be list of tuples
    #      (text, style)
    b = BinList('multispanText')

    b += 'S('
    b += pack_untyped_uint(len(multispan.spans))
    b += pack_untyped_short(multispan.tabs)
    b += pack_untyped_char(get_align(multispan))
    b += ')'


    b2 = BinList('multispan.body')
    for span in multispan.spans:
        if isinstance(span, ColoredBoxSpan):
            b2 += packColorBox(span)
        else:
            b2 += fragText(span)

    b.pack_span_list(b2)

    print('MultiSpan:')
    print(b)
    return b

def newLine(height):
    b  = BinList('newLine')
    b.add('N', pack_untyped_float(height) ,';')
    print("Newline H:", height, " B:", b)
    return b

def packColorBox(span):
    if span.isCode():
        assert False

    b = BinList('fragColorBox')

    b += 'b'
    b += pack_untyped_float(span.width)
    b += pack_untyped_float(span.height)
    b += pack_hex(span.color)
    b += ';'
    return b

def pageBreak(type):
    b  = BinList('pageBreak')
    return b.add( 'P', pack_untyped_char(type), ';')

import font_lookup as fldb

def typedLine(span):
    """
        Assuming no funny business - for the purpose of outside writers
    """
    span_type = type(span).__name__

    if span_type == 'NewLine':
        height = fldb.get_total_font_height(spans[i].font)
        if hasattr(spans[i], 'amt'):
            height *= spans[i].amt
        print ('??? Unsized Newline')
        return newLine(height)
    if span_type=='NewLineSized':
        return newLine(span.height)
    elif span_type=='Header':
        print('!!! Warning: False header')
        print(span.text)
        return headerElement(span)
    elif span_type=='TextSpan':
        return text_in_style(span)
    elif span_type == 'ColoredBoxSpan':
        return packColorBox(span)
    elif span_type=='MiscToken':
        # TYPES = ['page-break', 'soft-page-break']
        token = span.type
        if token == 'soft-page-break':
            return None
            # return pageBreak('s'), "SPB"
        elif token == 'page-break':
            return pageBreak('p')
        else:
            print('Unhandled MiscToken:', token)
            # return '', 'ForeignMiscToken'
            assert False
            return None
    elif span_type=='MultiSpan':
        return multispanText(span)
    elif span.isCode():
        assert False, f'Code {span_type} Must be handled by adult'
    elif span_type == 'EndOfPara':
        return None
    else:
        print('Unrecognized span type', span_type)
        print(span)
        print(type(span))
        assert False
        return None

"""
============= Code Functions =======================
"""
PACK_PARAMS = True

def pack_code_font_section(marker):
    tab_amt = span.tabs if hasattr(span, 'tabs') else 0

    # Align is already handled
    if font.isBodyMinusAlign():
        if tab_amt==0 and marker.align=='l':
            return None
        else:
            b = BinList('pack_code_font_section')
            b += '('
            b += pack_short_int(tab_amt)
            b += pack_char(marker.align)
            b += ')'
            return b

def code_tag_element(span):
    assert isinstance(span, code_objects.CodeTag)

    obj = span.obj
    print('Obj:', obj)
    assert ':' not in obj

    try:
        text = text.encode('ascii')
    except:
        print ("Text can't be Ascii encoded. ")
        print (f'"{obj}"')
        return []

    b = BinList('code_tag_element')

    b += 'T'
    b += obj.upper()
    b+=':'

    if PACK_PARAMS:
        if len(span.params)>0:
            b += '<'
            for p in span.params:
                b += pack_value(p)
            b += '>'

    b += ';'
    return b

def parsed_binary_element(span):
    assert isinstance(span, code_objects.ParsedCodeBlockBase)

    obj = span.obj
    assert ':' not in obj

    b = BinList('parsed_binary_element')
    # fname = f'handle_{obj.upper()}'
    b += 'D'
    b += pack_literal(obj.upper())
    b+=':'

    if PACK_PARAMS:
        if len(span.params)>0:
            b += '<'
            for p in span.params:
                b += pack_value(p)
            b += '>'

    bin = span.get_binary()
    b.pack_sub_binary(bin)
    b += ';'
    return b

def code_span_element(span):
    assert isinstance(span, code_objects.CodeSection)

    obj = span.obj
    # fname = f'handle_{obj.upper()}'
    b = BinList("code_span_element")
    b += 'C'
    b += pack_literal(obj.upper())
    b += ':'
    assert ':' not in obj

    if PACK_PARAMS:
        if len(span.params)>0:
            b += '<'
            for p in span.params:
                b += pack_value(p)
                b += ','
            b += '>'

    b2 = BinList('CodeSpan.spans')
    for ss in span.spans:
        if type(ss).__name__== "ChapterStart":
            print('Enclosing:', span)
            print('Subspan:', ss)
            assert False, 'ChapterStart should not be in a CodeSpan'
        elif ss.isCode():
            if isinstance(span, code_objects.ParsedCodeBlockBase):
                b2 += parsed_binary_element(ss)
            if isinstance(ss, code_objects.CodeTag):
                b2 += code_tag_element(ss)
            elif isinstance(ss, code_objects.CodeSection):
                b2 += code_span_element(ss)
            else:
                assert False, f'Unrecognized code {type(ss)}'
        else:
            b2 += typedLine(ss)

    b.pack_span_list(b2)
    b += ';'
    return b

def code_element(span):
    print(span.__class__.__bases__)
    if isinstance(span, code_objects.ParsedCodeBlockBase):
        return parsed_binary_element(span)
    elif isinstance(span, code_objects.CodeTag):
        return code_tag_element(span)
    elif isinstance(span, code_objects.CodeSection):
        return code_span_element(span)
    else:
        assert False, f'Unrecognized code_object {type(span)}'

    if hasattr(cc, fname):
        return getattr(cc, fname)(span)
    else:
        if obj not in needed_custom_code:
            needed_custom_code.append(obj)
        if obj in cc.unmatched_objects():
            return ccd.DEFAULT_tag_handler(span)
        else:
            return ccd.DEFAULT_handler(span)
