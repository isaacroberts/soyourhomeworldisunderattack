
from objects.code_objects import *
from objects.binary import *
from common.fmt_writer_functions import *


import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst


class MtgCodeObject(ParsedCodeBlockBase):
    def __init__(self, codetag):
        super().__init__('Magic')
        self.codetag = codetag
        self.items = []
    def add_item(self, name, price):
        self.items.append((name, price))

    def elemWalker(self):
        while False:
            yield None

    def get_binary(self):
        b = BinList('SoupMenuCodeObject.get_binary')
        # amt_timings : uint    total_span_amt : uint   [  t[spans]  t[spans] ... ]
        # b += pack_untyped_uint(len(self.timed_spans))
        # gen = self.elemWalker()
        # total_len = sum(1 for _ in gen)
        # b += pack_untyped_uint(total_len)
        b += pack_literal('[')
        for name, price in self.items:
            b += pack_text(name)
            b += '.'
            b += pack_text(price)
            b += ';'
        b += pack_literal('];')
        return b

def strip_text(spans):
    text = ''
    for span in spans:
        if span.hasText():
            text += span.get_text() + '\n'
    return text

def parse(tbpspan):
    print ("Parsing mtg card")
    obj = MtgCodeObject(tbpspan.codetag)
    text = strip_text(tbpspan.spans)
    print (text)
    print ('--')
    obj.params.dparams['Name'] = 'Fairie Flyer'
    obj.params.dparams['Cost'] = '2U'
    obj.params.dparams['Rules'] = 'When this card enters, draw a card.'
    obj.params.dparams['Flavor'] = "What's that in the sky?"
    obj.params.dparams['Type'] = "Creature - Fairie"
    print ("Returning:")
    print (obj)
    print (obj.params)
    print('-')
    pst.pause()
    return obj
