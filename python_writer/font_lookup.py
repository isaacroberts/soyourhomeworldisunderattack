import numpy as np
import pandas as pd
import os

"""
size_cols = ['regvar', 'italvar', 'convar', 'kvar',
'w100', 'w200', 'w300', 'w400', 'w500',
'w600', 'w700', 'w800', 'w900',
'Iw100', 'Iw200', 'Iw300', 'Iw400', 'Iw500',
'Iw600', 'Iw700', 'Iw800', 'Iw900',

'Cw100', 'Cw200', 'Cw300', 'Cw400', 'Cw500',
'Cw600', 'Cw700', 'Cw800', 'Cw900',

'Kw100', 'Kw200', 'Kw300', 'Kw400', 'Kw500',
'Kw600', 'Kw700', 'Kw800', 'Kw900',
]
"""


"""
    Currently this does not handle co
def match_file(row, )ndensed
"""

df = pd.read_csv('data/font_locations.csv', index_col='name')

def family_name_cleaner(name):
    # Just to get the damn thing to work
    if name == 'PaLATINO':
        return 'Palatino'
    if name=='Garamond':
        return 'EB Garamond'
    rchars = '\\/'
    for c in rchars:
        name = name.replace(c, '')
    schars = '-_'
    for c in rchars:
        name = name.replace(c, ' ')
    name = name.strip()
    if name[-1]=='2':
        return name[:-1]
    return name

if __name__ == "__main__":
    print(df)

def drop_word(sentence):
    sp = sentence.rindex(' ')
    # if sp==-1:
    #     return sentence, False
    # else:
    return sentence[:sp]


def find_font_row(family):
    family = family_name_cleaner(family)

    orig_family = family

    # Sometime the font faily is "EB Garamond Medium" and we need "EB Garamond"
    cont = True
    while cont:
        if family in df.index:
            if family != orig_family:
                replacements.add((orig_family, family))
            row = df.loc[family]
            return row
        elif ' '  in family:
            family = drop_word(family)
        else:
            cont = False
            # if not dropped:
            #     return fail()
    print(orig_family, 'not found')

    return None

def get_font_id(family):
    if family == 'Palatino':
        return 0
    elif family == 'Palatino Linotype':
        return 0
    if family == 'Rubik':
        return 1
    row = find_font_row(family)
    if row is None:
        assert False
        return None
    return row['Id']



def match_font_features_to_column(row, italic, weight):
    if italic:
        C = 'I'
        vkey = 'italvar'
    else:
        C = ''
        vkey = 'regvar'
    if row[vkey] != '-':
        return vkey
    else:
        def check_weight(weight):
            if weight <= 0 or weight >= 1000:
                return False, None
            key = f'{C}w{weight}'
            if row[key] == '-':
                return False, key
            else:
                return True, key

        dir = False
        dx = 0

        wrx, key = check_weight(weight)
        if wrx:
            return key

        for dx in range(1, 10):
            for dir in [False, True]:
                if dir:
                    w2 = weight + dx * 100
                else:
                    w2 = weight - dx * 100
                wrx, key = check_weight(w2)
                if wrx:
                    print('Match:', w2, key)
                    return key

        print('Font has no match')
        print(row.name, 'italic:', italic, 'weight', weight)

        return None


def match_font_to_column(font, row):
    col = match_font_features_to_column(row, font.italic, font.getWeight())
    if col is not None:
        return col
    else:
        # Try non-italic
        try_ital = not font.italic
        col = match_font_features_to_column(row, try_ital, font.getWeight())
        if col is not None:
            return col

        # Weight has already been tried
        print('Font has no match')
        print('Font:', font)
        print('Row:', row)

        assert False


def find_font_file(font):
    if len(font.family)==0:
        print("Font family is empty")
        print(font.tag)
        print(font)
        return '-'
    row = find_font_row(font.family)
    if row is not None:
        col = match_font_to_column(font, row)
        name = row.name
        if col is None:
            print('No match on font file')
            print('Font:', font)
            print('Row:', row)
            assert False

        else:
            print('Font file: ', name, 'x', col)
            print('File:', row[col])
            return row[col]
    else:
        return '-'
    # print(row)



replacements = set()

def get_font_size(family):
    family = family_name_cleaner(family)

    orig_family = family
    def fail():
        print(orig_family, 'not found')
        # assert False
        return None, False

    # Sometime the font faily is "EB Garamond Medium" and we need "EB Garamond"
    cont = True
    while cont:
        if family in df.index:
            if family != orig_family:
                replacements.add((orig_family, family))
            row = df.loc[family]
            return row['Height'], row['HeightMismatch']
        elif ' '  in family:
            family = drop_word(family)
        else:
            cont = False
            # if not dropped:
            #     return fail()
    return fail()


def get_total_font_height(font):
    """
        Call this one
    """
    fam_height, mismatch = get_font_size(font.family)
    if fam_height is None:
        print(font.family, 'not found')
        assert False, 'Try "fc-list > data/font_table_raw.txt && python _font_lookup_creator.py"'
    #TODO:
    # if mismatch:
    #     pass

    # Remove Npy type
    fam_height = float(fam_height)
    height = font.size/3 * fam_height
    return height

def get_box_width(boxtext, font):
    FONTFOLDER="/usr/local/share/fonts/"
    import PIL.ImageFont

    fontfile = font.file
    fontpath = os.path.join(FONTFOLDER, fontfile)
    # print(fontpath)
    font = PIL.ImageFont.truetype(fontpath)
    print(fontfile)
    # print(font)
    # try:
    #     print(font.get_variation_axes())
    # except OSError:
    #     print('Not variable')
    ascent, descent = font.getmetrics()
    (width, baseline), (offset_x, offset_y) = font.font.getsize(boxtext)

    # box = font.getbbox(' ')
    # print('box')
    # print(box)
    # print(type(box))
    # print ('Ascent', ascent,'Descent',  descent)
    # print('Width', width, 'Baseline', baseline, 'o_x', offset_x, 'o_y', offset_y)
    return font.size/3 * width



# Consdensed Italic = K

size_cols = ['regvar', 'italvar', 'convar', 'kvar',
'w100', 'w200', 'w300', 'w400', 'w500',
'w600', 'w700', 'w800', 'w900',
'Iw100', 'Iw200', 'Iw300', 'Iw400', 'Iw500',
'Iw600', 'Iw700', 'Iw800', 'Iw900',

'Cw100', 'Cw200', 'Cw300', 'Cw400', 'Cw500',
'Cw600', 'Cw700', 'Cw800', 'Cw900',

'Kw100', 'Kw200', 'Kw300', 'Kw400', 'Kw500',
'Kw600', 'Kw700', 'Kw800', 'Kw900',
]



def pubspec_asset(file, weight, style):
    if file == '-':
        return ''
    BULLET_LINE = '         - '
    TAB_LINE = '           '
    s= ''
    fname = os.path.basename(file)
    s += f'{BULLET_LINE}asset: assets/fonts/{fname}\n'
    s += f'{TAB_LINE}weight: {weight}\n'
    assert style in ['normal', 'italic', 'condensed', 'condenseditalic']
    s += f'{TAB_LINE}style: {style}\n'

    return s

def pubspec_var_asset(file, style):
    if file == '-':
        return ''
    BULLET_LINE = '         - '
    TAB_LINE = '           '
    s= ''
    fname = os.path.basename(file)
    s += f'{TAB_LINE}# Variable\n'
    s += f'{BULLET_LINE}asset: assets/fonts/{fname}\n'
    # s += f'{TAB_LINE}weight: {weight}'
    assert style in ['normal', 'italic', 'condensed', 'condenseditalic']
    s += f'{TAB_LINE}style: {style}\n'

    return s

def pubspec_line(row):

    s = ''
    family = row.name
    s += f'     - family: {family}\n'
    s += '       fonts:\n'

    def addall(rvar, ch, style):
        """
            rvar: regvar, italvar
            ch: _, I, C, K
            style: normal, italic
        """
        has_var = row[rvar] != '-'

        if has_var:
            return pubspec_var_asset(row[rvar], style)
        else:
            s = ''
            for w in range(1, 10):
                weight = w * 100
                key = ch + 'w' + str(weight)
                s += pubspec_asset(row[key], weight, style)
            return s

    s += addall('regvar', '', 'normal')
    s += addall('italvar', 'I', 'italic')
    s += addall('convar', 'C', 'condensed')
    s += addall('kvar', 'K', 'condenseditalic')

    return s

def make_pubspec():
    s = ''
    for key, row in df.iterrows():
        s += pubspec_line(row)
    print(s)
    return s

if __name__ == "__main__":
    print("Vampire war font size:")
    print(get_font_size('Vampire Wars'))
    print()
    print('Pubspec:')
    make_pubspec()
    print()

def end_step():
    for orig_family, family in replacements:
        print('Found as ', family, '(from', orig_family,')')
