import numpy as np
import hashlib
import copy as copy_lib
import common.flutter_tools as flutter_tools
class Font:
    static_body = None
    def __init__(self, tag, family='Def', size=0.0, italic=False, bold='normal',weight=None, fontCol=None, bgCol=None, mono=False):
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
        self._strikethrough = False
        # TODO: Add superscript / subscript

        # self.align = 'left'
        self.isSheeted=False
        # self.tags = set(self.tag)
        self.isHeading = False
        self.isSub=False
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
        f.isSub=False
        f.tag += ':'+tag_add
        return f

    def body(tag):
        """
        Creates body font
        """
        f= Font(tag)
        f.family = 'Palatino'
        f.size = 12.0
        f.weight = 'w300'
        # f.fontCol = '000000'
        return f

    def codelike(tag):
        """
        Creates a mono font for utility
        """
        return Font(tag, family='Source Code Pro', size=12, italic=False, bold='normal',weight='w500', fontCol='#999999', bgCol=None, mono=True)

    def zombie(tag):
        """
        Creates a font with all None attributes.
        This is used in the parent paradigm to mean all attributes will be derived.
        """
        f = Font(tag, '', None, None, None, mono=None)
        # f.align = None
        f.isHeading = None
        f._strikethrough=None
        f.isSub=True
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
        return self.family=='' and self.size is None and self.italic is None and self.bold is None and self._strikethrough is None \
            and self.fontCol is None and self.bgCol is None

    def isBodyMinusAlign(self):
        #TODO: Refactor out
        # Made redundant by removing align
        return self.isBody()

    def isBodyMinusColor(self):
        if Font.static_body is None:
            Font.static_body = 0
            Font.static_body = Font.body('.')
        return self.equal_minus_color(Font.static_body)

    def isCodeMarker(self):
        return False

    def hasColor(self):
        if self.fontCol is None:
            return False
        if not self.fontCol:
            return False
        return self.fontCol != '#000000' and self.fontCol!='000000'

    def hasBgCol(self):
        if self.bgCol is None:
            return False
        if not self.bgCol:
            return False
        if len(self.bgCol)==0:
            return False
        return self.bgCol != 'transparent'
        # return self.fontCol != '#000000' and self.fontCol!='000000'

    def strikethrough(self):
        if self._strikethrough is None:
            return False
        return self._strikethrough

    def getWeight(self):
        if self.bold == 'normal':
            return 500
        elif self.bold == 'bold':
            return 800
        elif self.bold == 'light':
            return 200
        elif self.bold[0]=='w':
            ww = self.bold[1:]
            ww = int(ww)
            ww = int(np.round(ww/100) * 100 )
            return ww
        else:
            print(self)
            print(self.bold )
            assert False, 'Unrecognized font weight:'


    def toFlutterCode(self):
        ital = str(self.italic).lower()

        boldP = ''
        # TODO: Consider always using weight
        if self.bold == 'normal':
            boldP = 'bold: false'
        elif self.bold == 'bold':
            boldP = 'bold: true'
        elif self.bold[0]=='w':
            boldP = 'weight: '+self.bold[1:]

        sparams = ''

        if self.hasColor():
            col = self.fontCol
            if col[0]=='#':
                col = col[1:]
            sparams += ', color: 0xff'+col
        return f"FontInterm('{self.family}', {self.size}, {ital}, {boldP} {sparams})"

    def varName(self):
        t = self.defined if self.defined is not None else self.tag
        return flutter_tools.flutterize_style_tag(t)

    def toTextStyle(self):
        s = f"const TextStyle {self.varName()}Font = TextStyle("
        s += f"fontFamily: '{self.family}', fontSize: {self.size} * fontScale, "
        if self.hasColor():
            col = self.fontCol
            if col[0]=='#':
                col = col[1:]
            s += f'color: Color(0xff{col}), '
        else:
            s += f'color: textColor, '
        if self.italic:
            s += 'fontStyle: FontStyle.italic,'
        weight = self.getWeight()
        s += f'fontWeight: FontWeight.w{weight},'
        s += ');'
        return s


    def toJson(self):
        return json.dumps(self, default=lambda o: o.__dict__)

    def set_display_name(self, set):
        self.isSheeted=True
        self.sheetName=set

    def fill_null(self, other):
        """
        Fill None values with parent's attributes
        """
        vars = ['family', 'size', 'italic', 'bold', 'fontCol','bgCol','mono']#, 'align']
        # Heading-ness needs to propagate, because i mess with the fonts on the headings
        if self.isHeading:
            print('\t Heading')
            other.isHeading = True
        for v in vars:
            ov = getattr(other, v, None)
            if ov is None or ov=='' or ov==0.0:
                print('\t', v, getattr(self, v))
                setattr(other, v, getattr(self, v))

    def Err():
        """
        For debugging
        """
        return Font('?', family='ERR', size=-1, fontCol='ff0000')

    def __hash__(self):
        #blank if none
        def bif(var):
            if var is None:
                return ''
            else:
                return str(var)

        col = self.fontCol if self.hasColor() else ''
        s= self.family + '_'+str(self.size) + 'I' if self.italic else 'r' + self.bold +'_'+col+'_'+bif(self.bgCol)#+ self.align[0]
        # t= s.encode()
        #
        # print('t', t, type(t))
        # return int(t)
        return hash(s)

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
        # TODO: Add similar hasColor
        if self.bgCol != other.bgCol:
            # print('\t\tbgCol')
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

        if self.strikethrough() != other.strikethrough():
            # print('\t\tstrike')
            return False
        # print ('\t\t==')
        return True

    def equal_minus_color(self, other):
        # TODO: Refactor to equal_minus_color
        if self is None:
            return False
        if other is None:
            return False
        if not isinstance(other, Font):
            return False
        if self.family != other.family:
            return False
        if self.size != other.size:
            return False
        if self.italic != other.italic:
            return False
        if self.bold != other.bold:
            return False
        if self.strikethrough() != other.strikethrough():
            return False
        return True

    def __str__(self):
        if self.isHeading:
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

        s = '['+pre+self.family +' '+ ps
        if self.strikethrough():
            s += ' Struck'
        if self.italic:
            s += ' Italic'
        # if self.weight is not None:
        #     s += ' w'+ str(int(self.weight))
        if self.bold is not None and self.bold!='normal':
            s +=' '+self.bold
        # if self.align and self.align != 'left':
        #     s += ' ['+self.align+']'
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
    # def set_align(self, value):
    #     if value=='start':
    #         self.align = 'left'
    #     elif value == 'end':
    #         self.align = 'right'
    #     elif value in ['center', 'justify']:
    #         self.align = value
    #     else:
    #         print('Unusual align value:', value)
    #         print(self)
    #         exit(1)
    def set_value(self, name, value):
        """
        Sets values from xml attributes.

        Ex:
            @font-family":"@Papyrus","@monospace";
            "@font-size":"<dimension>";"@font-style"
            :"@italic";"@font-weight":"@normal";"
        """
        # print(name, value)
        if name=='font-size':
            self.set_font_size(value)
        elif name in ['font-family', 'font-name']:
            if value[0] =="'" and value[-1]=="'":
                value = value[1:-1]
            self.family = value
        elif name=='font-style':
            if value not in ['normal', 'italic']:
                print('\nWeird value for italic\n', self)
                print(name, value)
                exit(1)
            self.italic = value=='italic'
        elif name=='font-weight':
            if isinstance(value, (float, int)):
                self.bold = 'w'+str(int(value))
            elif value in ['normal', 'bold', 'light']:
                self.bold = value
            else:
                #TODO: Remove
                for c in value:
                    if not c.isalnum():
                        print('Weird value for it to be Bold')
                        print(self)
                        print(name, value, type(value))
                        print()
                        exit(1)
                self.bold = 'w'+value
        elif name=='monospace':
            self.mono = True
        elif name=='line-through':
            self.strikethrough=True
        # elif name=='text-align':
        #     self.align = value
        elif name=='color':
            self.fontCol = value
        elif name=='background-color':
            self.bgCol = value
        else:
            print ('Unrecognized stype value', name)
            # Prints missed values at end of script
            missed_style_values.add(name)


WANTED_ATTRIBUTES = [
    'font-size', 'font-family', 'font-style','font-weight', 'color','background-color',
    # 'text-align'
]
BOOLEAN_TAGS = [
    'monospace', 'line-through'
]


# Manual list of variable weight fonts
variable_weight_fonts = ['Montserrat', 'Heebo', 'Raleway', 'Noto Sans', 'Comfortaa', 'EB Garamond', 'Reddit Sans', 'Playfair', 'Plus Jakarta Sans', 'Noto Serif', 'Azeret Mono' ]

variable_weight_weights = {'thin': 100,'extralight': 200,'light': 300,'normal': 400,'medium': 500,'semibold': 600,'bold': 700,'extrabold':800,'black': 900}


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
    name = ''.join(w for w in name if (w.isalpha() or w==' '))
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
    #TODO: This function is a duplicate
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
        print('Unmatched weight:', weight)
        print('Options:')
        for k, v in variable_weight_weights.items():
            print('\t', k, ':', v)
        w = pst.response('Enter weight of '+weight)
        try:
            weight = int(w)
            return weight
        except:
            exit(1)
