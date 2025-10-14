from objects.text_obj import *
from objects.binary import *

# Causing circular imports
# from common.fmt_writer_functions import *
import os

class ChapterStart:
    IDMaxLen = 15
    DisplayMaxLen = 75

    def __init__(self, headline_text):
        # self.index=None
        assert headline_text is not None
        self.headline_text = headline_text
        self.part = None
        # self.id = ChapterStart.create_var_name(self.headline_text)
        # self.display_name = ChapterStart.abbrev_name(headline_text.strip(), ChapterStart.DisplayMaxLen)
        # self.next = None

    def leadingTitleChapter():
        c= ChapterStart('Title')
        c.index=0
        c.display_name='Help! My Homeworld!'
        c.id='title'
        return c

    # TODO: Delete
    def filename(self):
        ixstr = f"{self.index}_" if self.index is not None else ""
        return f"part_{ixstr}{self.id}.bin"

    def create_var_name(input_text):
        var_name = ChapterStart.abbrev_name(ChapterStart.clean_for_varname(input_text), ChapterStart.IDMaxLen)
        var_name = var_name.replace('.', '_')
        return var_name

    def abbrev_name(name, MLV):
        if len(name) > MLV+3:
            name = name[:MLV-3] + '...'
        # elif len(name) > MLV:
        #     name = name[:MLV]
        else:
            pass
        return name

    def clean_for_varname(text):
        if len(text)==0:
            return ''
        s = [c for c in text if c.isalpha()]
        s = ''.join(s)
        if len(s)==0:
            # Convert symbols to text
            import text_utils
            spelled_text = text_utils.spell_out_symbols(text)
            return spelled_text
        return s

    def align(self):
        return 'left'
    def get_text(self):
        return '|- '+str(self.headline_text)+' -|'
    def __repr__(self):
        return self.get_text()
    def __str__(self):
        return self.get_text()
    def isNL(self):
        return True
    def hasText(self):
        return False
    def hasFont(self):
        return False
    def addTildes(self):
        # If something breaks add tildes here
        pass
    def removeTildes(self):
        pass
    def isCode(self):
        return False
    def elemWalker(self):
        yield self


class Chapter:
    def __init__(self, chapterStart, spans):
        self.headline_text = chapterStart.headline_text
        self.spans = spans
        self.index = None
        # info
        self.id = self.create_var_name(self.headline_text)
        self.bookmarks = [self.id]
        self.display_name = self.abbrev_name()
        # Ordering
        self.next = None
        self.part = False
        self.hidepart=False
        # fx
        self.audio=None
        # Details like subtitle, where, when
        self.data = {}

    # === Getters ===
    def matches_bookmark(self, tag):
        if tag in self.bookmarks:
            return True

    def varName(self):
        return self.id

    def leadingTitleChapter():
        c= ChapterStart('Title')
        c.index=0
        c.display_name='>'
        c.id='title'
        return c


    # ======= Text Formatting ==================
    def set_id(self, orig_id):
        id = self.create_var_name(orig_id)
        self.id = id
        self.bookmarks.append(orig_id)
        if id != orig_id:
            self.bookmarks.append(id)

    def add_id(self, id):
        self.bookmarks.append(id)
    def filename(self):
        ixstr = f"{self.index}_" if self.index is not None else ""
        return f"part_{ixstr}{self.id}.bin"

    def create_var_name(self, text):
        text = ChapterStart.clean_for_varname(text)
        text = text[:ChapterStart.IDMaxLen]
        return text

    def abbrev_name(self):
        name = self.headline_text.strip()
        MLV = ChapterStart.DisplayMaxLen
        if len(name) > MLV+3:
            name = name[:MLV-3] + '...'
        return name

    def clean_for_varname(text):
        if len(text)==0:
            return ''
        s = [c for c in text if c.isalpha()]
        s = ''.join(s)
        if len(s)==0:
            return 'Sym'
        return s

    # ======= Binary ===================

    def setup_binary(self):
        id = self.id
        self.output = BinList('ChapterOutput.header('+id+')')
        self.header = BinList('ChapterOutput.output('+id+')')

        self.header += '$'
        #
        # self.header += pack_untyped_uint(self.index)
        # self.header += '='
        #
        # self.header += pack_text(id)
        # self.header += '/'
        # self.header += pack_text(self.display_name)
        self.header += '/'
        def textornull(s):
            if s is None:
                return pack_text('')
            return pack_text(s)
        # self.header += '('
        self.header.pack_json(self.data)
        # self.header += textornull(self.subtitle)
        # self.header += ','
        # self.header += textornull(self.where)
        # self.header += ','
        # self.header += textornull(self.when)
        # self.header += ')'
        # self.header += '/'
        # if self.audio is None:
        #     self.header += '_'
        # else:
        #     self.header += pack_url(self.audio)
        self.header += '/'
        self.binary_length = None

    def isBlank(self):
        return len(self.output)==0;

    def writeChapter(self):
        import common.fmt_writer_functions as fmt

        assert hasattr(self, 'book_id')
        f= open(f'generated_book/{self.book_id}/'+self.filename(), 'wb')

        self.header += fmt.pack_literal('&zoinks&')
        self.header += '\n'
        f.write(self.header.bstr)

        if len(self.output)==0:
            self.output += fmt.newLine(24)

        self.output += '\n'
        self.output += fmt.newLine(24)

        f.write(self.output.bstr)
        f.close()

    def chapter_info(self):
        import common.fmt_writer_functions as fmt

        bin = BinList('chapter_for_index')
        bin += '('
        bin += fmt.pack_untyped_uint(self.index)
        # bin += '='
        bin += fmt.pack_text(self.id)
        # bin += ':'
        bin += fmt.pack_text(self.display_name)
        # bin += '^'
        bin += fmt.pack_untyped_uint(self.partId)
        # bin += '@'
        filename = self.filename()
        filename = self.book_id+'/'+filename
        bin += fmt.pack_text(filename)
        bin += '>'
        if self.next is None:
            bin += fmt.pack_none()
        else:
            bin += fmt.pack_typed_uint(self.next.index)

        if self.part:
            if self.hidepart:
                bin += 'v'
            else:
                bin += '^'

        # bin += '*'

        p = './generated_book/' + filename
        file_size = os.path.getsize(p)
        print('Chapter', self.display_name, file_size, 'bytes')

        # In theory this could fuck up the encoding, since it approaches max int
        if file_size > 500000000:
            gb = file_size / 1073741824
            print(f"Yoooo chapter is {gb} Gigabytes")
            assert False

        # bin += fmt.pack_untyped_uint(file_size)
        bin += ')';
        bin += ';'
        return bin

    def json_chapter_info(self):
        import common.fmt_writer_functions as fmt
        data = {}

        data['ix'] = self.index
        # bin += '='
        data['var'] = self.id
        # bin += ':'
        data['display'] = self.display_name
        # bin += '^'
        data['partId'] = self.partId
        # bin += '@'
        filename = self.filename()
        filename = self.book_id+'/'+filename
        data ['filename'] = filename
        if self.next is None:
            data['next'] = None
        else:
            data['next'] = self.next.index

        if self.part:
            if self.hidepart:
                data['isPart'] = 'v'
            else:
                data['isPart'] = '^'
        else:
            data['isPart'] = '0'
        return data

    # ===== Processing ===========
    def prepare_for_save(self):
        self.addTildes()
        self.convertFontsToTags()

    def addTildes(self):
        """
        In JsonPickle, the strings were not being null-terminated.
        """
        for sp in self.spans:
            sp.addTildes()

    def convertFontsToTags(self):
        # Save space
        for span in self.spanWalker():
            if hasattr(span, 'font'):
                f = span.font
                if hasattr(f, 'tag'):
                    span.font = span.font.tag

    def removeTildes(self):
        for sp in self.spans:
            sp.removeTildes()

    def spanWalker(self):
        for s in self.spans:
            yield from s.elemWalker()
    #Some interfaces uses a different name
    def elemWalker(self):
        for s in self.spans:
            yield from s.elemWalker()
