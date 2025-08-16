import numpy as np
import copy as copy_lib
import common.flutter_tools as flutter_tools


class Font:
    static_body = None

    def __init__(self, tag, family='Def', size=0.0, italic=False, bold='normal',
                 weight=None, fontCol=None, bgCol=None, mono=False):
        self.tag = tag
        self.family = family
        self.size = size
        self.italic = italic
        self.defined = None
        if bold == True:
            self.bold = 'bold'
        elif bold == False:
            self.bold = 'normal'
        else:
            self.bold = bold

        self.fontCol = fontCol
        self.bgCol = bgCol
        self.mono = mono

        # These need to be None so traits can fall through
        self._strikethrough = None
        self._underline=None
        self._overline=None

        #Unimplemented
        self._small_caps = None

        # nrm / sub / sup
        self._subSuper = None
        # TODO: Add superscript / subscript

        # self.align = 'left'
        self.isSheeted = False
        # self.tags = set(self.tag)
        self._isHeading = False
        self.markedNotHeading=False
        self.isSub = False
        if Font.static_body is None:
            Font.static_body = 0
            Font.static_body = Font.body('.')

    def copy(self, tag_add):
        """
        Uses copy library to deep copy object.
        Adds parent tag to end of own tag.
            (I think for readability)
        """
        f = copy_lib.deepcopy(self)
        f.isSub = False
        f.tag += ':'+tag_add
        return f

    def body(tag):
        """
        Creates body font
        """
        f = Font(tag)
        f.family = 'Palatino'
        f.size = 12.0
        f.weight = 'w300'
        # f.fontCol = '000000'
        return f

    def codelike(tag):
        """
        Creates a mono font for utility
        """
        return Font(tag, family='Source Code Pro', size=12, italic=False, bold='normal', weight='w500', fontCol='#999999', bgCol=None, mono=True)

    def zombie(tag):
        """
        Creates a font with all None attributes.
        This is used in the parent paradigm to mean all attributes will be derived.
        """
        f = Font(tag, '', None, None, None, mono=None)
        # f.align = None
        f._isHeading = None
        f.isSub = True
        return f

    def isBody(self):
        """
        Used to simplify body elements.
        """
        if Font.static_body is None:
            Font.static_body = 0
            Font.static_body = Font.body('.')

        # print('isBody', self.family, self.size, self.fontCol)
        return self == Font.static_body

    def isZombie(self):
        return self.family == '' and self.size is None and self.italic is None and self.bold is None and self._strikethrough is None \
            and self._overline is None and self._underline is None \
            and self._subSuper is None \
            and self.fontCol is None and self.bgCol is None

    def isBodyMinusColor(self):
        if Font.static_body is None:
            Font.static_body = 0
            Font.static_body = Font.body('.')
        return self.equal_minus_color(Font.static_body)

    def isCodeMarker(self):
        return False
    def isHeading(self):
        return self._isHeading and not self.markedNotHeading
    def hasColor(self):
        if self.fontCol is None:
            return False
        if not self.fontCol:
            return False
        return self.fontCol != '#000000' and self.fontCol != '000000'

    def hasBgCol(self):
        if self.bgCol is None:
            return False
        if not self.bgCol:
            return False
        if len(self.bgCol) == 0:
            return False
        return self.bgCol != 'transparent'
        # return self.fontCol != '#000000' and self.fontCol!='000000'

    def strikethrough(self):
        if self._strikethrough is None:
            return False
        return self._strikethrough
    def underline(self):
        if self._underline is None:
            return False
        return self._underline
    def overline(self):
        if self._overline is None:
            return False
        return self._overline
    def subSuper(self):
        if self._subSuper is None:
            return 'nrm'
        else:
            return self._subSuper
    def small_caps(self):
        if self._small_caps is None:
            return False
        else:
            return self._small_caps
    def getWeight(self):
        if self.bold == 'normal':
            return 500
        elif self.bold == 'bold':
            return 800
        elif self.bold == 'light':
            return 200
        elif self.bold[0] == 'w':
            ww = self.bold[1:]
            ww = int(ww)
            ww = int(np.round(ww/100) * 100)
            return ww
        else:
            print(self)
            print(self.bold)
            assert False, 'Unrecognized font weight:'

    def varName(self):
        t = self.defined if self.defined is not None else self.tag
        return flutter_tools.flutterize_style_tag(t)

    def toJson(self):
        import json
        return json.dumps(self, default=lambda o: o.__dict__)

    def set_display_name(self, set):
        self.isSheeted = True
        self.sheetName = set

    def fill_null(self, other):
        """
        Fill None values with parent's attributes
        """
        vars = ['family', 'size', 'italic', 'bold',
                'fontCol', 'bgCol', 'mono',
                 '_strikethrough', '_underline', '_overline',
                 '_subSuper', '_small_caps']  # , 'align']
        # Heading-ness needs to propagate, because i mess with the fonts on the headings
        if self.markedNotHeading:
            other._isHeading=False
            other.markedNotHeading=True
        elif self._isHeading:
            print('\t Heading')
            other._isHeading = True

        for v in vars:
            ov = getattr(other, v, None)
            if ov is None or ov == '' or ov == 0.0:
                print('\t', v, getattr(self, v))
                setattr(other, v, getattr(self, v))

    def Err():
        """
        For debugging
        """
        return Font('?', family='ERR', size=-1, fontCol='ff0000')

    def __hash__(self):
        # blank if none
        def bif(var):
            if var is None:
                return ''
            else:
                return str(var)
        def bin(var):
            if var is None:
                return 'n'
            elif var:
                return '1'
            else:
                return '0'
        col = self.fontCol if self.hasColor() else ''
        s = self.family + '_'+str(self.size) + 'I' if self.italic else 'r' + \
            self.bold + '_'+col+'_'+bif(self.bgCol) \
            + bin(self._strikethrough) + bin(self._underline)+bin(self._overline)+ bif(self._subSuper)

        s += 'H' if self.isHeading() else 'x' if self.markedNotHeading else 'n'
        # t= s.encode()
        #
        # print('t', t, type(t))
        # return int(t)
        return hash(s)

    def base_atts_equal(self, other):
        if self.family != other.family:
            # print(f"\t\tf: '{self.family}', '{other.family}'")
            return False
        if self.size != other.size:
            # print('\t\ts')
            return False
        if self.italic != other.italic:
            # print("\t\ti")
            return False
        if self.bold != other.bold:
            # print('\t\tbold', self.bold, other.bold)
            return False
        if self.isHeading() != other.isHeading():
            return False
        return True
    def decorations_equal(self, other):
        #TODO: This function is not useful because of lack of purpose-clarity
        if self.strikethrough() != other.strikethrough():
            return False
        if self.underline() != other.underline():
            return False
        if self.overline() != other.overline():
            return False
        if self.subSuper() != other.subSuper():
            return False
        if self.small_caps() != other.small_caps():
            return False
        return True
    def colors_equal(self, other):
        shc = self.hasBgCol()
        ohc = other.hasBgCol()

        if shc != ohc:
            # print('\t\tbgCol')
            return False
        if shc:
            if self.bgCol != other.bgCol:
                return False

        shc = self.hasColor()
        ohc = other.hasColor()

        if shc != ohc:
            # print('\t\tcol mismatch', shc, ohc, self.fontCol, other.fontCol)
            return False
        if shc:
            if self.fontCol != other.fontCol:
                # print('\t\tCol', self.fontCol, other.fontCol)
                return False
        return True
    def __eq__(self, other):
        if self is None:
            return False
        if other is None:
            return False
        if not isinstance(other, Font):
            return False
        # CodeMarker
        if type(other).__name__ != "Font":
            return False
        if not self.base_atts_equal(other):
            return False
        if not self.colors_equal(other):
            return False
        if not self.decorations_equal(other):
            return False

        return True

    def equal_minus_color(self, other):
        if self is None:
            return False
        if other is None:
            return False
        if not isinstance(other, Font):
            return False
        # CodeMarker
        if type(other).__name__ != "Font":
            return False
        if not self.base_atts_equal(other):
            return False
        if not self.decorations_equal(other):
            return False
        return True


    def __str__(self):
        if self.isHeading():
            pre = 'H:'
        else:
            pre = ''

        if self.isSheeted:
            return '['+pre+self.sheetName+']'

        if isinstance(self.size, float):
            ps = str(int(self.size))
        elif isinstance(self.size, str):
            ps = self.size
        else:
            ps = str(self.size)

        s = '['+pre+self.family + ' ' + ps

        if self.italic:
            s += ' Italic'
        if self.bold is not None and self.bold != 'normal':
            s += ' '+self.bold
        if self.strikethrough():
            s += ' Struck'
        if self.underline():
            s += ' Underline'
        if self.overline():
            s += ' Overline'
        if self._subSuper is not None:
            s += ' '+self._subSuper
        if self._small_caps:
            s += " SMALL_CAPS"
        if self.bgCol:
            s += ' bg='+self.bgCol
        if self.fontCol:
            if self.fontCol != '000000':
                s += ' col='+self.fontCol
        s += ']'
        return s

    def __repr__(self):
        return str(self)

    def set_font_size(self, size):
        if isinstance(size, str):
            if 'pt' in size:
                size = size.replace('pt', '').strip()
                if '.' in size:
                    size = float(size)
                else:
                    size = int(size)
            else:
                assert False, 'new situation'
        self.size = size


    def set_value(self, name, value):
        """
        Sets values from xml attributes.

        Ex:
            @font-family":"@Papyrus","@monospace";
            "@font-size":"<dimension>";"@font-style"
            :"@italic";"@font-weight":"@normal";"
        """
        # print(name, value)
        if name == 'font-size':
            self.set_font_size(value)
        elif name in ['font-family', 'font-name']:
            if value[0] == "'" and value[-1] == "'":
                value = value[1:-1]
            self.family = value
        elif name == 'font-style':
            if value not in ['normal', 'italic']:
                print('\nWeird value for italic\n', self)
                print(name, value)
                exit(1)
            self.italic = value == 'italic'
        elif name == 'font-weight':
            if isinstance(value, (float, int)):
                self.bold = 'w'+str(int(value))
            elif value in ['normal', 'bold', 'light']:
                self.bold = value
            else:
                # TODO: Remove
                for c in value:
                    if not c.isalnum():
                        print('Weird value for it to be Bold')
                        print(self)
                        print(name, value, type(value))
                        print()
                        exit(1)
                self.bold = 'w'+value
        elif name == 'monospace':
            self.mono = True
        elif name == 'color':
            self.fontCol = value
        elif name == 'background-color':
            self.bgCol = value
        elif name == 'line-through':
            self._strikethrough = True
            print("Got strikethrough!")
        elif name == 'text-underline':
            self._underline=True
        elif name == 'text-overline':
            self._overline = True
        elif name == 'text-position':
            # sub 58%
            if value.startswith('sub'):
                self._subSuper = 'sub'
            elif value.startswith('super'):
                self._subSuper='sup'
            elif value.startswith('0%'):
                self._subSuper='nrm'
                # idk what this is
                pass
            else:
                print('TextPosition: ', value)
                t = input('U see this shit? (y/n)')
            # exit(0)
        elif name == 'text-shadow':
            pass
        elif name == 'font-variant':
            if value=='small-caps':
                self._small_caps = True
            else:
                print('!!! Unrecognized font-variant', value)
                exit(1)
        elif name == 'text-outline':
            value = bool(value)
            self._isHeading=value
            self.markedNotHeading=not value

        else:
            print('!!! Unrecognized style value', name)
            exit(1)
            # Prints missed values at end of script
            # missed_style_values.add(name)


WANTED_ATTRIBUTES = [
    'font-size', 'font-family', 'font-style', 'font-weight', 'color', 'background-color',
    'line-through',
    'text-position', 'font-variant',
    'text-outline',
    'text-shadow',
    # 'text-align'
]

#Redirect to wanted_attribute
RDR_ATTRIBUTES = {
    'font-name': 'font-family',
    'font-family-complex': 'font-family',
    'font-name-complex': 'font-family',
'font-size-complex': 'font-size',
'font-style-complex': 'font-style',
'font-weight-complex': 'font-weight',

# Lines thru
'text-line-through-style': 'line-through',
'text-line-through-type': 'line-through',
'text-line-through-color': 'line-through',
'text-underline-style': 'text-underline',
'text-underline-width': 'text-underline',
'text-underline-color': 'text-underline',
'text-overline-style': 'text-overline',
'text-overline-width': 'text-overline',
'text-overline-color': 'text-overline',
}

UNWANTED_ATTRIBUTES = [
    #Could be used to give fallbacks.
    # "serif", "sans-serif", "cursive", "fantasy", "monospace".
'font-family-generic',
# Regular
'font-style-name',
# Width (?) of monospace fonts
'font-pitch',
# International
'font-name-asian',
'font-family-asian',
'font-family-generic-asian',
'font-pitch-asian',
'font-size-asian',
'font-style-asian',
'font-weight-asian',
# TODO: The complex might be important
'font-family-generic-complex',
'font-pitch-complex',
'font-style-name-complex',
# TODO: Save letter spacing
'letter-spacing',
'letter-kerning',

# Maybe TODO: Save to Color
'opacity',
'font-relief',

# Eh
'text-underline-width',
'text-underline-color',
'text-overline-style',

#libreOffice shit
'use-window-font-color',
'char-shading-value',
#???
'rsid',
'paragraph-rsid',

]


BOOLEAN_TAGS = [
    'monospace', 'line-through'
]


# Manual list of variable weight fonts
variable_weight_fonts = ['Montserrat', 'Heebo', 'Raleway', 'Noto Sans', 'Comfortaa',
                         'EB Garamond', 'Reddit Sans', 'Playfair', 'Plus Jakarta Sans', 'Noto Serif', 'Azeret Mono']

variable_weight_weights = {'thin': 100, 'extralight': 200, 'light': 300, 'normal': 400,
                           'medium': 500, 'semibold': 600, 'bold': 700, 'extrabold': 800, 'black': 900}


def match_variable_weight(family):
    """
    Match family name like 'Montserrat Light'
    Returns 'Montserrat'
    """
    for vfam in variable_weight_fonts:
        if family.startswith(vfam):
            return vfam
    return None


def is_variable_weight(family):
    """
        Returns true if family matches manually added variable weight fonts
    """
    for vfam in variable_weight_fonts:
        if family.startswith(vfam):
            return True
    return False


def try_every_word_for_weight(name):
    """
    Takes a font_family name like 'Montserrat Light'
    returns (300, 'Light'), or (None, None)
    """
    name = ''.join(w for w in name if (w.isalpha() or w == ' '))
    name = name.lower()

    words = name.split(' ')
    for word in words:
        if word in variable_weight_weights:
            return variable_weight_weights[word], word
    return None, None


def match_weight_name(weight):
    """
    Takes name like 'Light'
    returns 300, or None
    """
    weight = ''.join(w for w in weight if w.isalpha())
    weight = weight.lower()
    if weight in variable_weight_weights:
        return variable_weight_weights[weight]
    else:
        return None


def word_from_weight(w):
    """
    Inputs 300
    Returns 'Light'
    """
    w = 100 * (w//100)
    if w < 0:
        assert False, 'Antimatter font weight'
        return 'antimatter'
    elif w == 0:
        return 'ghost'
    elif w == 1000:
        return 'extrablack'
    elif w > 1000:
        assert False, 'Impossiblythick font weight'
        return 'impossiblythick'
    else:
        for k, ww in variable_weight_weights.items():
            if w == ww:
                return k
        assert False, 'bug in word_from_weight '+str(w)
        return 'bug'


def get_variable_weight(family):
    # TODO: This function is a duplicate
    """
        Inputs 'Montserrat Light'
        Returns 300
    """
    weight = family.split(' ')[1:]
    weight = ''.join(weight)
    weight = match_weight_name(weight)
    if weight is not None:
        return weight
    else:
        import python_script_tools as pst
        print('Unmatched weight:', weight)
        print('Options:')
        for k, v in variable_weight_weights.items():
            print('\t', k, ':', v)
        w = pst.response('Enter weight of '+weight)
        try:
            weight = int(w)
            return weight
        finally:
            return 500
