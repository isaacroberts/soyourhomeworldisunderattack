from objects.fonts import Font

class TextSpan:
    def __init__(self, font, text, align):
        assert hasattr(font, 'isBody')
        assert len(text) > 0
        self.font = font
        self.text = text
        self.tabs = 0
        self._align = align

    def get_text(self):
        return self.text
    def __repr__(self):
        pt = self.text
        pt = pt.replace('\n','↵')
        pt = pt.replace('\t','[\\t]')
        return str(self.font)+'"'+pt+'"'

    def align(self):
        assert hasattr(self, '_align'), f'TextSpan missing align? self={self} type={type(self)} dict = {self.__dict__}'
        return self._align
        # return str(self.font)+'"'+self.text.replace('\n','↵')[:50]+'"'
    def __str__(self):
        return self.__repr__()
    def isNL(self):
        return False
    def hasText(self):
        return True
    def hasFont(self):
        return True
    def addTildes(self):
        self.text += '~'
    def removeTildes(self):
        if self.text.endswith('~'):
            self.text = self.text[:-1]
    def isCode(self):
        return False
    def elemWalker(self):
        yield self
# header_name_repl = {
#     '///': 'Continue',
# }

class Header:
    def __init__(self, font, text, align):
        self.font = font
        self.text = text
        self._align = align
        # print('Text:', self.text)
        # assert '\n' not in self.text
        # assert '\t' not in self.text
    def chp_name(self):
        if len(self.text)==0:
            return ''
        # if self.text in header_name_repl:
        #     return header_name_repl[self.text]
        s = [c for c in self.text if c.isalpha()]
        s = ''.join(s)
        if len(s)==0:
            return 'Sym'
        return s[:10]

    def get_text(self):
        return self.text
    def __repr__(self):
        pt = self.text
        # pt = pt.replace('\n','↵')
        # pt = pt.replace('\t','[\\t]')
        return 'H:'+pt

    def align(self):
        return self._align
        # return str(self.font)+'"'+self.text.replace('\n','↵')[:50]+'"'
    def __str__(self):
        return self.__repr__()
    def isNL(self):
        return False
    def hasText(self):
        return True
    def hasFont(self):
        return True
    def addTildes(self):
        self.text += '~'
    def removeTildes(self):
        if self.text.endswith('~'):
            self.text = self.text[:-1]
    def isCode(self):
        return False
    def elemWalker(self):
        yield self

class MultiSpan:
    def __init__(self, spans):
        self.spans = spans
        self.tabs = 0

    def align(self):
        # return 'left'
        return self.spans[0].align()

    def verify(self):
        align = self.spans[0].align
        for span in self.spans:
            if span.font.align != align:
                print('Align mismatch:', align, span.font.align)
            assert span.font.align == align

    def get_text(self):
        return ''.join(s.text for s in self.spans if s.hasText())

    def __repr__(self):
        return 'M'+ ''.join(s.__repr__() for s in self.spans)

    def __str__(self):
        return self.__repr__()

    def isNL(self):
        return False

    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        for span in self.spans:
            span.addTildes()
    def removeTildes(self):
        for span in self.spans:
            span.removeTildes()
    def isCode(self):
        return False
    def elemWalker(self):
        for span in self.spans:
            yield span


class NewLine:
    def __init__(self, font):
        # You need the font for the height of the spacing
        self.font = font
        self.amt = 1

    def align(self):
        return 'left'

    def get_text(self):
        return '\n'
    def __repr__(self):
        s = '↵'
        if self.amt>1:
            s *= self.amt
        if self.font.size is None:
            return s+' [?]'
        if self.font.size!=12:
            s+f' [{int(self.font.size)}]'
        return s

    def __str__(self):
        return self.__repr__()
    def isNL(self):
        return True
    def hasText(self):
        return False
    def hasFont(self):
        return True
    def addTildes(self):
        pass
    def removeTildes(self):
        pass
    def isCode(self):
        return False
    def elemWalker(self):
        yield self

class ColoredBoxSpan:
    def __init__(self, text, font, align, pos):
        self.text = text
        assert isinstance(font, Font)
        self._font = font
        self._align = align
        assert pos in ['leading', 'tail', 'main']
        self.pos = pos
        # assert self.font.hasBgCol()
        if self._font.hasBgCol:
            self.color = self._font.bgCol
        else:
            self.color = None
        # These will be set by an outside element
        self.width = None
        self.height = None
    def align(self):
        return self._align
    def get_text(self):
        if self.text is None:
            return ''
        else:
            return self.text
    def __repr__(self):
        return '[SpcCol]'
    def __str__(self):
        return self.__repr__()
    def isNL(self):
        return False
    def hasText(self):
        return self.text is not None and len(self.text)>0
    def hasFont(self):
        return False
    def addTildes(self):
        pass
        # self.text = self.text + '~'
    def removeTildes(self):
        pass
        # if self.text.endswith('~'):
        #     self.text = self.text[:-1]
    def isCode(self):
        return False
    def elemWalker(self):
        yield self

class NewLineSized:
    def __init__(self, height):
        # You need the font for the height of the spacing
        self.height = height

    def align(self):
        return 'left'

    def get_text(self):
        return '\n'
    def __repr__(self):
        s = '↵'
        return s+' ' +str(int(self.height))

    def __str__(self):
        return self.__repr__()
    def isNL(self):
        return True

    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        pass
    def removeTildes(self):
        pass
    def isCode(self):
        return False
    def elemWalker(self):
        yield self
