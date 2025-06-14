

def san_text(text):
    # text = text+'_'
    text = text.replace("\\", "\\\\")
    text = text.replace('\n', '\\'+'n')

    text = text.replace('$', '\\$')
    # Tab = 5 spaces
    # text = text.replace('\t', '     ')
    text = text.replace('"', '\\"')
    text = text.replace("'", "\\'")

    return text

def flutterColor(color):
    if len(color)==0:
        print("Warning: Transparent color")
        return f"0x00ffffff"
    if color[0]=='#':
        color = color[1:]
    return f"0xff{color}"


def codify_style_tag(tag):
    tag = tag.replace(' ','')
    return tag[0].upper() + tag[1:]

    # return tag.title()#.replace(' ','')

def flutterize_style_tag(tag):
    # t = tag.title().replace(' ', '')
    # tag = tag.replace(' ','')

    t = tag[0].lower()
    t += tag[1:]
    t = t.replace(':', "_")
    return t
