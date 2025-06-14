
from objects.code_objects import *
from common.fmt_writer_functions import *

from objects.binary import *

def code_tag_replacements():
    """
        x -> y
    """
    return {
        'WHLSVG': 'WHLAd',
     'WHL':'WHLAd',
     'HJAd': 'HumanJacksAd',
        # 'UnskippableAudio': 'Audio',
        'menu': 'SoupMenu',
        'Menu': 'SoupMenu',
        'Button': 'GotoButton',
        'Goto': 'Next',
        # 'Chapter': 'ChapterStart',
    }


# These are all top-level. For low-level Keywords, you'll have to add another classtype
def chapter_keywords():
    return ['Chapter', 'Section', 'Label',
         'Next',
         'EndOfBook',
          "InvisibleHeadline",
      'Audio', 'UnskippableAudio', 'CopSting',

  ]


def uniquely_parsed_objects():
    """
        These are stripped, saved, and sent directly to a separate parser.
        CodeTags there will have to be handled by the parser
    """
    return [
        'TimedAudio', 'Columns', "SoupMenu", 'CheckboxRows',
        'Texts', 'Sign2Columns'
    ]

def block_objects():
    """
        These objects are a single block of spans.
        They are uniquely displayed by Flutter code.
        They can't contain other code objects.

        Object
                text
        /obj

        TODO: Distinguish between blocks that need their spans and blocks that replace them (like BallotBox or CharacterSelectionScreen)
    """
    return [
# Single Lines
        'EndWithLine','LineThenText',
        'PollScreen',
        'FullBgAd',

        # Replacing
        'Title',
        'FlatEarthAndyThumbnail',
        'TicketsToGreenlandGame',
        'CharacterSelectionScreen',
        'HJLogo','SRABusinessCard1',

# Regular
        'GotoButton',
        'Song', #'Letter',
        'BG','FullBG','AdBG',
        'GiftCard',
        'Shirt', 'ChapterShirt', 'PrintExactShirt',
        'BumperSticker',
        'Expando',
        'Terminal',
         'Art', 'Ballot', 'Ticket', 'Sign',
         'Tweet',
        'GreyedOutButton',
        'InvisiText','BallotBox',
        'HJArt',

    ]

#TODO: Add TextDumpers that delete their text
# TODO: Add OneLiners (take in the following line )

# TODO: Rename these to NoLiners
def single_line_objects():
    """
        These objects are single line.

        Label: AbeLincoln
        Four score and several years ago
    """
    return ['WHLAd',
        'Divider',
        'BackButton',
        'HumanJacksAd',
        'Read', 'Icon'

    ]

"""
    Process Steps
"""

import objects.custom_parsing as custom_parsing



def parse_custom(span, obj):
    print("Parsing", obj, '(ParsedBlock)')
    if obj == 'Columns':
        return custom_parsing.parse_columns(span)
    elif obj == 'SoupMenu':
        return custom_parsing.parse_soup_menu(span)
    elif obj == 'TimedAudio':
        return custom_parsing.parse_timed_audio(span)
    elif obj == 'Sign2Columns':
        return custom_parsing.parse_sign_columns(span)
    elif obj == 'CheckboxRows':
        return parse_span_parsed_block(span)
    else:
        return parse_span_parsed_block(span)
        # assert False, 'Unhandled custom parse function '+str(obj)
        # return None

def post_matching_step(spans, styles):
    pass

def chapter_processing(spans, styles):
    pass



class BlankParsedBlock(ParsedCodeBlockBase):
    def __init__(self, span):
        super().__init__('BlankParsedBlock')
        self.codetag = span.codetag
        self.obj = span.obj
    def elemWalker(self):
        while False:
            yield None
    def get_binary(self):
        b = BinList('BlankParsedBlock.get_binary')
        b += '#'
        return b

def blank_parsed_block(span):
    return BlankParsedBlock(span)

class SpanParsedBlock(ParsedCodeBlockBase):
    def __init__(self, span):
        super().__init__('BlankParsedBlock')
        self.codetag = span.codetag
        self.obj = span.obj
        self.spans = span.spans
    def elemWalker(self):
        for s in self.spans:
            yield s
    def get_binary(self):
        b = BinList('SpanParsedBlock.get_binary')
        gen = self.elemWalker()
        for span in self.spans:
            b += typedLine(span)
        return b

def parse_span_parsed_block(span):
    return SpanParsedBlock(span)
