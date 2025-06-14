
from objects.text_obj import MultiSpan
import copy as copy_lib


class CodeTag: # virtual Inherits: TextObject
    def __init__(self, text, codeMarker):
        # Partial strip
        while len(text)>0 and text[0] == ' ':
            text = text[1:]
        self.text = text
        assert codeMarker.isCodeMarker()
        self.codeMarker = codeMarker
        self.isEndTag = False

        self.parse()
    def combine(self, other):
        if other.text.startswith('//'):
            return False
        if '\n' in self.text:
            return False
        self.text = self.text + other.text
        self.parse()
        return True

    def parse(self):
        self.params = []
        self.hasColon = ':' in self.text
        if self.text.startswith('//'):
            self.obj = '//'
            self.params = [self.text[2:].strip()]
        else:
            if self.hasColon:
                ix = self.text.find(':')
                self.obj = self.text[:ix].strip()
                self.params = self.text[ix+1:].strip()

                # common typo
                if '{' not in self.params:
                    # buttons right next to each other
                    self.params = self.params.replace('}', '|')

                self.params = self.params.split('|')
                for i in range(len(self.params)):
                    self.params[i] = self.params[i].strip()
            else:
                self.obj = self.text.strip()

    def get_text(self):
        if not hasattr(self, 'obj'):
            return f'[#{self.text}]'

        if self.obj=='//':
            return f'[//{self.params}]'
        else:
            if len(self.params) == 0:
                return f'[#{self.obj}]'
            else:
                return f'[#{self.obj}: {self.params}]'

    def __repr__(self):
        return self.get_text()
    def __str__(self):
        return self.get_text()

    def align(self):
        assert False

    def isNL(self):
        return False
    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        self.text += '~'
        for i in range(len(self.params)):
            self.params[i] += '~'
        self.obj += '~'

    def removeTildes(self):
        if self.text.endswith('~'):
            self.text = self.text[:-1]
        for i in range(len(self.params)):
            if self.params[i].endswith('~'):
                self.params[i] = self.params[i][:-1]
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]

    def isCode(self):
        return True

    def elemWalker(self):
        yield self

class CodeSection: # virtual Inherits: TextObject
    def __init__(self, spans, codetag, codeMarker):
        for span in spans:
            assert hasattr(span, 'hasText')
        assert codeMarker.isCodeMarker()
        assert isinstance(codetag, CodeTag)

        self.spans = spans
        self.codetag = codetag
        self.obj = self.codetag.obj
        self.params = self.codetag.params
        # self.font = self.codetag.font
        self.codeMarker = codeMarker

    def align(self):
        assert False, "CodeMarker does not have align"

    def get_text(self):
        return '##\n' +''.join(s.text for s in self.spans)+ '\n##'

    def __repr__(self):
        return'#' + self.codetag.obj +'{' + ''.join(s.__repr__() for s in self.spans)+ '}'

    def __str__(self):
        return self.__repr__()

    def isNL(self):
        return False

    def hasText(self):
        return True
    def hasFont(self):
        return False

    def addTildes(self):
        for span in self.spans:
            span.addTildes()

        for i in range(len(self.params)):
            self.params[i] += '~'
        self.obj += '~'

    def removeTildes(self):
        for span in self.spans:
            span.removeTildes()
        for i in range(len(self.params)):
            if self.params[i].endswith('~'):
                self.params[i] = self.params[i][:-1]
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]


    def isCode(self):
        return True
    def elemWalker(self):
        for span in self.spans:
            yield span


class ToBeParsedCodeBlock: # Inherits: TextObject
    def __init__(self, spans, codetag):
        for span in spans:
            assert hasattr(span, 'hasText')
        # assert codeMarker.isCodeMarker()
        assert isinstance(codetag, CodeTag)

        self.spans = spans
        self.codetag = codetag
        self.obj = self.codetag.obj
        self.params = []

    def align(self):
        assert False, 'TextObject does not have align'

    def get_text(self):
        return '##\n' +''.join(s.text for s in self.spans)+ '\n##'

    def __repr__(self):
        return'#' + self.codetag.obj +'{' + ''.join(s.__repr__() for s in self.spans)+ '}\\'+self.codetag.obj+'#'

    def __str__(self):
        return self.__repr__()

    def isNL(self):
        return False

    def hasText(self):
        return True
    def hasFont(self):
        return False

    def addTildes(self):
        for span in self.spans:
            span.addTildes()

        self.obj += '~'

    def removeTildes(self):
        for span in self.spans:
            span.removeTildes()
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]

    def isCode(self):
        return True
    def elemWalker(self):
        for span in self.spans:
            yield span


class ParsedCodeBlockBase: # Inherits: TextObject
    def __init__(self, obj):
        self.obj = obj
        # TODO: Input this through the constructor, from the previous object
        # TODO: Run these through the tilde washer
        self.params = []

    # === Must override ===
    def elemWalker(self):
        pass

    def get_binary(self):
        pass

    # === For completeness ===
    def align(self):
        assert False
        return 'l'

    def get_text(self):
        return f'#[{self.obj}]'

    def __repr__(self):
        return f'#[{self.obj}]'

    def __str__(self):
        return self.__repr__()

    def isNL(self):
        return False
    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        for span in self.elemWalker():
            span.addTildes()
        self.obj += '~'

    def removeTildes(self):
        for span in self.elemWalker():
            span.removeTildes()
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]

    def isCode(self):
        return True

class CodeMarker: # Inherits: Font
    def from_font(font):
        return CodeMarker(font.tag, font.parent, fontCol=font.fontCol, bgCol=font.bgCol)

    def __init__(self, tag, parent=None, fontCol=None, bgCol=None):
        self.tag = tag
        self.parent = parent
        self.fontCol = fontCol
        self.bgCol = bgCol

        self.isSub = False
        self.isSheeted=False
    # The only line that matters
    def isCodeMarker(self):
        return True

    # The rest are to avoid getting errors
    def __getattr__(self, name):
        if name == 'isHeading':
            return False
        if name=='size':
            return 12
        elif name == 'family':
            return 'Palatino'
        elif name=='italic':
            return False
        elif name=='weight':
            return 'normal'
        elif name=='mono':
            return True
        elif name=='strikethrough':
            return False
        else:
            raise AttributeError(name+' in CodeMarker')

    def copy(self, tag_add):
        # TODO: Doesn't add the tag ??
        # CodeMarkers aren't all identical
        return copy_lib.deepcopy(self)
    def isBody(self):
        return False
    def isZombie(self):
        return False
    def isBodyMinusAlign(self):
        return False
    def isBodyMinusColor(self):
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
    def strikethrough(self):
        return False
    def getWeight(self):
        assert False, 'Why does CodeMarker have weight?'
        return 500
    def toFlutterCode(self):
        assert False, "CodeMarker should not be converted to flutter"
        return '#[xxx];'
    def varName(self):
        assert False
        return '#[xxx!]'
    def toTextStyle(self):
        assert False
        return ''

    def toJson(self):
        return json.dumps(self, default=lambda o: o.__dict__)
    def set_display_name(self, set):
        assert False, 'CodeMarker doesnt need a display name'
    def fill_null(self, other):
        vars = ['fontCol','bgCol']
        # assert isinstance(other, CodeMarker), 'Filling wrong'
        for v in vars:
            ov = getattr(other, v, None)
            if ov is None or ov=='' or ov==0.0:
                print('\t', v, getattr(self, v))
                setattr(other, v, getattr(self, v))
    def __hash__(self):
        #blank if none
        def bif(var):
            if var is None:
                return ''
            else:
                return str(var)
        s = '#'
        s += self.fontCol if self.hasColor() else ''
        s += '_'
        s += self.bgCol if self.hasBgCol() else ''
        return hash(s)

    def __eq__(self, other):
        if self is None:
            return False
        if other is None:
            return False
        if isinstance(other, CodeMarker):
            return True
        return False
    def equalMinusAlign(self, other):
        return self.__eq__(other)
    def equal_minus_color(self, other):
        return self.__eq__(other)
    def __str__(self):
        return '#[Code]'
    def __repr__(self):
        return str(self)
    def set_font_size(self, size):
        pass
    def set_value(self, name, value):
        pass

class CodeKeywordTag: # virtual Inherits: TextObject
    def __init__(self, codetag):
        self.obj = codetag.obj.strip()
        self.params = codetag.params

    def combine(self, other):
        assert False

    def get_text(self):
        if len(self.params) == 0:
            return f'[[{self.obj}]]'
        else:
            return f'[[{self.obj}: {self.params}]]'

    def __repr__(self):
        return self.get_text()
    def __str__(self):
        return self.get_text()

    def align(self):
        assert False

    def isNL(self):
        return False
    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        self.obj += '~'
        for i in range(len(self.params)):
            self.params[i] += '~'

    def removeTildes(self):
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]
        for i in range(len(self.params)):
            if self.params[i].endswith('~'):
                self.params[i] = self.params[i][:-1]

    def isCode(self):
        return True

    def elemWalker(self):
        yield self
