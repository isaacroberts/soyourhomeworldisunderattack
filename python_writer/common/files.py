import json
import jsonpickle
import common.flutter_tools

from objects import *

# ==

def get_defined_plus_generated_styles(font_name):

    f= open('temp/'+font_name, 'r')
    str1 = f.read()
    f.close()

    style_dict = get_defined_styles()

    new_styles = jsonpickle.decode(str1)

    print('style taggery')
    for st in new_styles.values():
        # print(st)
        # print(type(st))

        ot = st.tag
        st.tag = flutter_tools.codify_style_tag(st.tag)
        print(ot, '->', st.tag)

        style_dict[st.tag] = st

    print()

    return style_dict

def get_counted_styles():
    f= open('temp/fonts_cleaned.json', 'r')
    str1 = f.read()
    f.close()

    styles = jsonpickle.decode(str1)

    print(styles)

    style_dict = {}

    for tag, style in styles.items():
        style_dict[tag] = style

    return style_dict

def read_fonts(font_name):
    #font_name='fonts_m.json'
    f = open('temp/'+font_name, 'r')
    str1 = f.read()
    f.close()
    fonts = jsonpickle.decode(str1)
    return fonts

def read_spans_and_fonts(span_name, font_name):
    #span_name = 'spans_coded.json', ftname='fontsm.json'
    f= open('temp/'+span_name, 'r')
    str1 = f.read()
    f.close()
    spans = jsonpickle.decode(str1)

    fonts = read_fonts(font_name)

    print(len(spans), 'Spans')
    print(len(fonts), 'Fonts')

    # Remove ~ (sep characters)
    for s in spans:
        # Jsonpickle needed these for some reason
        s.removeTildes()

    prev_font = None

    def elemWalker():
        for s in spans:
            yield from s.elemWalker()

    prev_font = None
    for e in elemWalker():
        if e.hasFont():
            prev_font = tag_to_font(e, e.font, fonts, prev_font)

    return spans, fonts

# Replace tag with font object
def tag_to_font(elem, font_tag, fonts,  prev_font):
    """
        Converts tags to fonts

    """
    # nonlocal prev_font
    if not elem.hasFont():
        return prev_font

    # if isFont
    if hasattr(font_tag, 'isCodeMarker'):
        font = font_tag
        font_tag = font.tag

    if font_tag in fonts:
        elem.font = fonts[font_tag]
        prev_font = elem.font
    else:
        if font_tag == 'codelike':
            elem.font = Font.codelike('codelike')
        elif font_tag == 'body':
            elem.font = Font.body('body')
        else:
            print('Unrecognized font tag:', font_tag)
            # print(elem)
            print (elem.font)
            if isinstance(elem, NewLine):
                assert prev_font is not None, 'wtf first span has no font??: "'+str(elem)+'"'
                elem.font = prev_font
            else:
                print(elem, type(elem), font_tag)
                assert False, 'Unrecognized font tag:'+font_tag+' on elem '+str(elem)
            # print(fonts.keys())
    return prev_font


def save_spans(spans, filename):

    """
        For some reason
            One of the strings was not being
            null-terminated perhaps???

            Any character works
    """
    for sp in spans:
        sp.addTildes()

    def spanWalker():
        for sp in spans:
            yield from sp.elemWalker()

    for span in spanWalker():
        if hasattr(span, 'font'):
            f = span.font
            if hasattr(f, 'tag'):
                span.font = span.font.tag

    with open(f'temp/'+filename, 'w') as f:
        str1 = jsonpickle.encode(spans)
        f.write(str1)


def print_aligned(s, v, maxlen=40):
    if not isinstance(s, str):
        s = str(s)
    s += ' '*(maxlen-len(s))
    s = s[:maxlen]
    print(s, v)

def common_health_inspection(spans):
    print("Common health inspection!")

    for span in spans:
        if hasattr(span, 'font'):
            if isinstance(span.font, str):
                print("Uh oh!")
                print('Font:', span.font, type(span.font))
                print('Span:', span)
            assert not isinstance(span.font, str)

def chapter_health_inspection(chapters):
    print("Common health inspection!")

    for chapter in chapters:
        for span in chapter.spans:
            if hasattr(span, 'font'):
                if isinstance(span.font, str):
                    print("Uh oh!")
                    print('Font:', span.font, type(span.font))
                    print('Span:', span)
                assert not isinstance(span.font, str)

def convert_odt_align(value):
    if value=='start':
        return 'left'
    elif value == 'end':
        return 'right'
    elif value in ['center', 'justify']:
        return value
    else:
        print('Unusual align value:', value)
        print(self)
        exit(1)
