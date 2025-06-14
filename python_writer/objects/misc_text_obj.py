
from objects.text_obj import * 

class EndOfPara:
    def __init__(self):
        pass
    def align(self):
        return 'left'
    def get_text(self):
        return '||'
    def __repr__(self):
        return '||'
    def __str__(self):
        return '||'
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

class MiscToken:
    TYPES = ['page-break', 'soft-page-break']

    def __init__(self, type):
        # self.font = font
        # self.font = None
        self.type = type
        assert self.type in MiscToken.TYPES

    def align(self):
        return 'center'

    def get_text(self):
        return self.type

    def __repr__(self):
        return self.type
    def __str__(self):
        return self.__repr__()

    def isNL(self):
        # Gonna count as true
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
