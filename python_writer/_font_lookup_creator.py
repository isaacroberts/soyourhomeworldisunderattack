import numpy as np
import pandas as pd
import PIL.ImageFont

import objects.fonts

import os
import sys

sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst
pst.DEBUG=True


FONTFOLDER="/usr/local/share/fonts/"

# fc-list > data/font_table_raw.txt
table = 'data/font_table_raw.txt'
df = None

axes_types = set()

"""
    TODO:  Friggen RobotoMono-variable has the same italic file listed for both italic and regular
"""

PARIAH_FONTS = ['padmaa', 'D050000L', 'Noto Color Emoji', 'padmaa\-Bold.1.1', 'Dingbats', 'LKLUG', 'MathJax_Vector', 'MathJax_Vector-Bold']

def is_pariah(family):
    if family in PARIAH_FONTS:
        return True
    if 'padmaa' in family:
        return True
    if 'MathJax_Vector' in family:
        return True

class FontFile():
    def __init__(self, params):
        self.path = params[0]
        self.folder = os.path.dirname(self.path)
        # print(self.folder)
        self.file = os.path.basename(self.path)
        # print(self.file)
        self.familyOpts = params[1].split(',')
        self.family = self.familyOpts[0]
        # self.variable = 'variable' in fname.lower()
        print('Path:', self.path)
        if is_pariah(self.family):
            self.pariah = True
            self.bad = True
            return
        # if self.folder!='/usr/local/share/fonts':
        #     self.bad = True
        #     return
        # if self.variable:
        try:
            font = self.getFont()
            self.bad = False
        except Exception as e:
            print(self.family)
            print(e)
            print("!!!")
            exit(0)
            return
        try:
            axes = font.get_variation_axes()
            [{'minimum': 100, 'default': 400, 'maximum': 900, 'name': b'Weight'}, {'minimum': 62, 'default': 100, 'maximum': 100, 'name': b'Width'}]
            self.variable = True
            self.var_axes = {}
            for ax in axes:
                name = ax['name'].decode('utf-8').lower()
                axes_types.add(name)
                defau = ax['default']
                self.var_axes[name] = defau
        except OSError:
            self.variable = False
            self.var_axes = {}
                # print('Not variable')
            # print(font.getmetrics())


        self.styleOpts = []
        self.weight = 500

        self.italic = False
        # all obliques are also italic; not all italics are oblique
        self.oblique = False
        self.condensed = False

        if self.family == 'Ubuntu':
            print('Ubuntu')
            print(self.file)
            p = self.file.split('.')[0]
            print(p)
            p = p.replace('Ubuntu-', '')
            print(p)

            self.italic = p[-1] == 'I'
            if p[-1] == 'I':
                p = p[:-1]
            WW = {'R':400, 'M':500, 'B':700, 'L':300, 'Th': 200}
            assert p in WW
            self.weight = WW[p]
        else:

            if len(params)>2:
                assert len(params)==3
                stylep = params[2]
                if 'style=' in stylep:
                    stylep = stylep.replace('style=','')
                    styles = stylep.split(',')
                    for s in styles:
                        self.styleOpts.append(s)

                if 'weight' in self.var_axes:
                    self.weight = None

            print('Orig style opts:', self.styleOpts)

            # Remove italic word
            si = 0
            while si < len(self.styleOpts):
                ss = self.styleOpts[si]
                if 'italic' in ss.lower():
                    self.italic = True
                    ss = ss.replace('Italic', '')
                    ss = ss.replace('italic', '')
                    ss = ss.replace('  ', '')
                    ss = ss.strip()
                    if len(ss)==0:
                        self.styleOpts.pop(si)
                        si-=1
                    else:
                        self.styleOpts[si] = ss
                if 'oblique' in ss.lower():
                    self.italic = True
                    self.oblique = True
                    assert self.italic
                    ss = ss.replace('Oblique', '')
                    ss = ss.replace('oblique', '')
                    ss = ss.replace('  ', '')
                    ss = ss.strip()
                    if len(ss)==0:
                        self.styleOpts.pop(si)
                        si-=1
                    else:
                        self.styleOpts[si] = ss
                if 'condensed' in ss.lower():
                    self.condensed = True

                    ss = ss.replace('condensed', '')
                    ss = ss.replace('Condensed', '')
                    ss = ss.replace('  ', '')
                    ss = ss.strip()
                    if len(ss)==0:
                        self.styleOpts.pop(si)
                        si-=1
                    else:
                        self.styleOpts[si] = ss

                if 'regular' in ss.lower():
                    ss = ss.replace('Regular', '')
                    ss = ss.replace('regular', '')
                    ss = ss.replace('  ', '')
                    ss = ss.strip()
                    if len(ss)==0:
                        self.styleOpts.pop(si)
                        si-=1
                    else:
                        self.styleOpts[si] = ss

                si += 1



            #Remove foreign style names (cursiva, obliqua)
            si = 0
            while si < len(self.styleOpts):
                # print(self.styleOpts[si])
                def is_foreign(word):
                    word = word.lower()
                    for c in word:
                        if c in ' ,':
                            pass
                        elif ord(c) < ord('a'):
                            return True
                        elif ord(c) > ord('z'):
                            return True
                    return False

                if is_foreign(self.styleOpts[si]):
                    # print('Foreign word! ', self.styleOpts[si])
                    self.styleOpts.pop(si)
                    si -= 1
                si += 1

            # Remove duplicates
            self.styleOpts = list(set(self.styleOpts))

            print('Style opts:', self.styleOpts)
            si = 0
            while si < len(self.styleOpts):
                w, match = objects.fonts.try_every_word_for_weight(self.styleOpts[si])
                if w is not None:
                    # if not variable axis
                    if self.weight is not None:
                        if self.weight != 500:
                            print("Clashing weights - font marked bad")
                            print('Is Padma?', self.family=='padmaa', self.family)
                            # Only happens to padma.ttf
                            self.bad = True
                            print(self.weight)
                            print(self.styleOpts[si])
                            print(w)
                            print(self.file)
                            # r = pst.response('')
                            # assert False
                        self.weight = w

                    if len(self.styleOpts[si]) > len(match):
                        self.styleOpts[si] = self.styleOpts[si].replace(match, '')
                        self.styleOpts[si] = self.styleOpts[si].replace('  ', ' ')
                        print('styleOpts=', self.styleOpts)
                    else:
                        self.styleOpts.pop(si)
                        si -=1
                si += 1
            else:
                other = ''

        assert os.path.exists(self.path)

    def is_variable_weight(self):
        return self.variable and 'weight' in self.var_axes

    def getFont(self):
        return PIL.ImageFont.truetype(self.path)

    def __repr__(self):
        if self.variable:
            keys = ' | '.join('Var'+k[0].upper()+k[1:] for k in self.var_axes.keys() if k != 'weight')
            keys += ' '
        else:
            keys = ''

        p = ''
        if self.oblique:
            p += 'Oblique '
        elif self.italic:
            p += 'Italic '
        if self.weight is None:
            p += 'VarWeight '
        else:
            p += 'W='+str(self.weight)+' '
        if len(self.styleOpts)>0:
            k2 = 'Styles=' + ','.join(self.styleOpts)
            k2 = k2[:40]
            if len(keys)>0:
                keys += ';'
            keys += k2

        L = 30
        s= self.family[:L]+(' '*(L-len(self.family)))
        s += ' '
        s += self.file[:L] + (' '*(L-len(self.file)))
        s+=  '|\t'+ p + keys
        return s

fonts = []

def read_table():
    f= open(table, 'r')
    txt = f.read()
    f.close()
    f=None

    lines = txt.split('\n')
    for line in lines:
        line = line.strip()
        params = line.split(':')
        for i in range(len(params)):
            params[i] = params[i].strip()
        if len(params)>1:
            # assert
            # pes = '1' if pe else '0'

            font = FontFile(params)
            if hasattr(font, 'pariah'):
                pass
            elif font.bad:
                print('Bad font')
                print('file:', font.file)
                print('family:', font.family)
                exit(0)
                font=None
            else:
                print(font)
                fonts.append(font)
        else:
            print('Bad','\t', line)
read_table()
# exit(0)

print('\n\n\n')
fonts = sorted(fonts, key= lambda font: font.family)

for font in fonts:
    print(font)

print()
print('Variation axes')
print(', '.join(axes_types))
print()

class FamilyGroup:
    def __init__(self, font):
        self.name = font.family

        rchars = '\\/'
        for c in rchars:
            self.name = self.name.replace(c, '')
        schars = '-_'
        for c in rchars:
            self.name = self.name.replace(c, ' ')
        self.name = self.name.strip()

        if self.name == 'Palatino Linotype':
            self.name = 'Palatino'

        self.ital = []
        self.reg = []
        self.condensed = []
        self.conital = []

        self.hasVarReg = False
        self.hasVarItal = False
        self.hasConVar = False
        self.hasKVar = False

        self.addfont(font)
    def to_pandas_row(self):
        d= {'name': self.name}
        if self.hasVarReg:
            d['regvar'] = self.reg.path
        else:
            for ff in self.reg:
                s = f'w{ff.weight}'
                d[s] = ff.path
        if self.hasVarItal:
            d['italvar'] = self.ital.path
        else:
            for ff in self.ital:
                s = f'Iw{ff.weight}'
                d[s] = ff.path

        if self.hasConVar:
            d['convar'] = self.condensed.path
        else:
            for ff in self.condensed:
                s = f'Cw{ff.weight}'
                d[s] = ff.path
        if self.hasKVar:
            d['kvar'] = self.conital.path
        else:
            for ff in self.conital:
                s = f'Kw{ff.weight}'
                d[s] = ff.path

        return d


    def __repr__(self):
        s = self.name
        L = 30
        s = s[:L] + ' '*(L-len(s))
        s += '|'
        if self.hasVarReg and self.hasVarItal:
            s += 'VarPair'
        else:
            if self.hasVarReg:
                s += 'Vr'
            else:
                if len(self.reg)==1 and not self.hasVarItal and len(self.ital)==0:
                    s += '.'
                elif len(self.reg)>0:
                    s += f'{len(self.reg)}R'
                else:
                    s += '-'
            s += ' '
            if self.hasVarItal:
                s += 'Vit'
            else:
                if len(self.ital)>0:
                    s +=f"{len(self.ital)}I"

        return s
    def addfont(self, font):
        slot = ''
        if font.italic:
            if font.condensed:
                if self.hasKVar:
                    return
                else:
                    if font.is_variable_weight():
                        self.conital = font
                        self.hasKVar = True
                    else:
                        self.conital.append(font)
            else:
                if self.hasVarItal:
                    return
                else:
                    if font.is_variable_weight():
                        self.ital = font
                        self.hasVarItal = True
                    else:
                        self.ital.append(font)
        else:
            if font.condensed:
                if self.hasConVar:
                    return
                else:
                    if font.is_variable_weight():
                        self.condensed = font
                        self.hasConVar = True
                    else:
                        self.condensed.append(font)

            if self.hasVarReg:
                return
            else:
                if font.is_variable_weight():
                    self.reg = font
                    self.hasVarReg = True
                else:
                    self.reg.append(font)

groups = {}

for font in fonts:
    family = font.family
    if family in groups:
        groups[family].addfont(font)
    else:
        groups[family] = FamilyGroup(font)

for group in groups.values():
    print(group)

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

df = pd.DataFrame(columns=['name'].extend(size_cols))

for group in groups.values():
    df = df._append(group.to_pandas_row(), ignore_index=True)

df = df.fillna('-')
print(df.columns)
print(df)
print()
print((df!='-').astype(int))


print('Pcts filled')
m=(df.values!='-').mean(axis=0)
m = (m*100).astype(int)/100.
print(m)

def get_size(fontfile):

    fontpath = os.path.join(FONTFOLDER, fontfile)
    # print(fontpath)
    font = PIL.ImageFont.truetype(fontpath)
    print(fontfile)
    # print(font)
    # try:
    #     print(font.get_variation_axes())
    # except OSError:
    #     print('Not variable')
    text = 'ABDEFGHJILKMONPQRSTUVWYXZabcdefghijklmnopqrstuvwxyz!.?-=[]'

    ascent, descent = font.getmetrics()
    (width, baseline), (offset_x, offset_y) = font.font.getsize(text)

    # box = font.getbbox(' ')
    # print('box')
    # print(box)
    # print(type(box))
    # print ('Ascent', ascent,'Descent',  descent)
    # print('Width', width, 'Baseline', baseline, 'o_x', offset_x, 'o_y', offset_y)

    x0, y0, x1, y1 = font.getmask(text).getbbox()

    # print("Box:", x0, y0, x1, y1)

    return y1 - y0

# Ensure df has all columns - they'll be removed if any are have no values

for style in size_cols:
    if style not in df.columns:
        df[style] = '-'


df['Height']=0.0
df['HeightMismatch']=False

for key, row in df.iterrows():
    # print(key, row)
    single_size = None
    first_style = None
    for style in size_cols:
        file = row[style]
        if file != '-':
            if first_style is None:
                first_style = style
            # print(row)
            # print(row['name'])
            # print(file, type(file))
            size = get_size(file)
            if size is None:
                assert False, 'size none'
            if single_size is None:
                single_size = size
                df.loc[key, 'Height'] = size
            else:
                if single_size != size:
                    print('Size mismatch', row['name'], first_style, single_size, style, size)
                    df.loc[key, 'HeightMismatch']=True

df['Id'] = np.arange(2, 2+df.shape[0])


for key, row in df.iterrows():
    family= row['name']
    if family in ['Palatino', 'Palatino Linotype']:
        df.loc[key, 'Id']=0
    elif family == 'Rubik':
        df.loc[key, 'Id']=1

df['Id'] = df["Id"].astype(int)

print(df)
print(df.size)
print("Any mismatch?", df['HeightMismatch'].values.any(), df['HeightMismatch'].values.mean())

df.to_csv('data/font_locations.csv')


# get_size('NotoSans-VariableFont_wdth,wght.ttf')
