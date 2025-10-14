
from objects.text_obj import MultiSpan
import copy as copy_lib


class CodeParams:
    def __init__(self, text=None):
        self.lparams = []
        self.dparams = {}

        if text is None:
            # Empty
            self.obj = '_'
        else:
            self.obj = None
            self.parse(text)
        # assert len)
    def check_params(self):
        assert len(self.lparams) <= 1, f"More than 1 param: {self.lparams}"
    def __str__(self):
        return f'{self.lparams} {self.dparams}'
    def __repr__(self):
        return f'{self.lparams} {self.dparams}'
    def main(self, defaultValue=None):
        if len(self.lparams)>0:
            return self.lparams[0]
        else:
            return defaultValue
    def parse(self, text):
        self.hasColon = ':' in text
        if text.startswith('//'):
            self.obj = '//'
            self.lparams = [text[2:].strip()]
        else:
            if self.hasColon:
                self.obj, params = split_str(text, ':')
                self.obj = self.obj.strip()
                params = params.strip()

                # common typo
                if '{' not in params:
                    # buttons right next to each other
                    params = params.replace('}', '|')

                params = params.split('|')
                for param in params:
                    param = param.strip()
                    if '=' in param:
                        key, val = split_str(param, '=')
                        # Remove space & case
                        key = key.strip().lower()
                        # Remove non-alnum characters
                        key = ''.join(ch for ch in key if ch.isalnum())
                        self.dparams[key] = val.strip()
                    else:
                        if len(param)>0:
                            self.lparams.append(param)
            else:
                self.obj = text.strip()

    def read_dict(self, name, default_value=None):
        name = name.lower().strip()
        if name in self.dparams:
            return self.dparams[name]
        else:
            return default_value

    def addTildes(self):
        for i in range(len(self.lparams)):
            self.lparams[i] += '~'

    def removeTildes(self):
        for i in range(len(self.lparams)):
            if self.lparams[i].endswith('~'):
                self.lparams[i] = self.lparams[i][:-1]

    def has_params(self):
        return len(self.lparams) > 0 or bool(self.dparams)

    def isEmpty(self):
        return not self.has_params()


class CodeTag: # virtual Inherits: TextObject
    def __init__(self, text, codeMarker):
        # Partial strip
        while len(text)>0 and text[0] == ' ':
            text = text[1:]
        self.text = text
        assert codeMarker.isCodeMarker()
        self.codeMarker = codeMarker
        self.isEndTag = False
        self.params = CodeParams(self.text)
        self.obj = self.params.obj

    def combine(self, other):
        if other.text.startswith('//'):
            return False
        if '\n' in self.text:
            return False
        self.text = self.text + other.text
        self.params = CodeParams(self.text)
        self.obj = self.params.obj
        return True

    def has_params(self):
        return self.params.has_params()

    def get_text(self):
        if not hasattr(self, 'obj'):
            return f'[#{self.text}]'

        if self.obj=='//':
            return f'[//{self.params}]'
        else:
            if not self.has_params():
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
        self.params.addTildes()
        self.obj += '~'

    def removeTildes(self):
        if self.text.endswith('~'):
            self.text = self.text[:-1]
        self.params.removeTildes()
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
        self.params.addTildes()
        self.obj += '~'

    def removeTildes(self):
        for span in self.spans:
            span.removeTildes()
        self.params.removeTildes()
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
        self.params = CodeParams()

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
        self.params.addTildes()
        self.obj += '~'

    def removeTildes(self):
        for span in self.spans:
            span.removeTildes()
        self.params.removeTildes()
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
        self.params = CodeParams()

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
        self.params.addTildes()
        self.obj += '~'

    def removeTildes(self):
        for span in self.elemWalker():
            span.removeTildes()
        self.params.removeTildes()
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
    def isHeading(self):
        return False
    # The rest are to avoid getting errors
    def __getattr__(self, name):
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
                # print('\t', v, getattr(self, v))
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
        if self.params.isEmpty():
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
        self.params.addTildes()

    def removeTildes(self):
        if self.obj.endswith('~'):
            self.obj = self.obj[:-1]
        self.params.removeTildes()

    def isCode(self):
        return True

    def elemWalker(self):
        yield self


def split_str(str, symbol):
    ix = str.find(symbol)
    # print('Split ix', str, symbol, ':', ix)
    if ix == -1:
        return str, None
    else:
        s1 = str[:ix].strip()
        s2 = str[ix+1:].strip()
        return s1, s2
