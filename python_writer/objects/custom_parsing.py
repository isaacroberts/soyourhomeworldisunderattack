
from objects.code_objects import *
from objects.binary import *
from common.fmt_writer_functions import *

class TimedAudioTiming():
    def __init__(self, time):
        # Make it like 100 milliseconds or something
        self.time = time
        self.list = []
    def add(self, span):
        self.list.append(span)

class TimedAudioCodeObject(ParsedCodeBlockBase):
    def __init__(self, codetag):
        super().__init__('TimedAudio')
        self.codetag = codetag
        self.timed_spans = [TimedAudioTiming(0)]
    def add_span(self, span):
        self.timed_spans[-1].add(span)
    def update_time(self, time):
        self.timed_spans.append(TimedAudioTiming(time))

    def elemWalker(self):
        for timing in self.timed_spans:
            for span in timing.list:
                yield span

    def get_binary(self):
        b = BinList('TimedAudioCodeObject.get_binary')
        # amt_timings : uint    total_span_amt : uint   [  t[spans]  t[spans] ... ]
        b += pack_untyped_uint(len(self.timed_spans))
        gen = self.elemWalker()
        total_len = sum(1 for _ in gen)
        b += pack_untyped_uint(total_len)
        b += pack_literal('[')
        for timing in self.timed_spans:
            # t . seconds:uint [  spans... ]
            b += pack_untyped_char('t')
            b += pack_untyped_uint(timing.time)
            b += pack_literal('[')
            for span in timing.list:
                b += typedLine(span)
            b += pack_literal(']')
        b += pack_literal('];')
        return b

def determine_if_time(span):
    if not span.hasText():
        return None
    text = span.text

    # TODO: Find time parsing code

    return None

def parse_timed_audio(span):

    timedAudio = TimedAudioCodeObject(span.codetag)
    spans = span.spans
    print('sdfsd')
    for span in spans:
        time = determine_if_time (span)
        if time is not None:

            timedAudio.update_time(time)
        else:
            if span.isCode():
                pass
            else:
                timedAudio.add_span(span)
    return timedAudio

class ColumnCodeObject(ParsedCodeBlockBase):
    def __init__(self, codetag, obj):
        super().__init__(obj)
        self.codetag = codetag
        self.columns = [ [] ]
    def add_span(self, span):
        self.columns[-1].append(span)
    def next_col(self):
        self.columns.append( [] )
    def elemWalker(self):
        for col in self.columns:
            for span in col:
                yield span

    def get_binary(self):
            b = BinList('ColumnCodeObject.get_binary')
            b += pack_untyped_uint(len(self.columns))
            # col_amt:short  total_span_length:uint  [ col[spans] col[spans] ... ];
            gen = self.elemWalker()
            total_len = sum(1 for _ in gen)
            b += pack_untyped_short(total_len)
            b += pack_literal('[')
            for col in self.columns:
                # c  len(col):uint   [spans...]
                b += pack_untyped_char('c')
                b += pack_untyped_uint(len(col))
                b += pack_literal('[')
                for span in col:
                    b += typedLine(span)
                b += pack_literal(']')
            b += pack_literal('];')
            return b

def determine_if_colbreak(span):
    if not span.hasText():
        return False
    text = span.text
    if '---' in text:
        return True
    return False

def parse_columns(span):
    colObj = ColumnCodeObject(span.codetag, 'Columns')

    for span in span.spans:
        isBreak = determine_if_colbreak (span)
        if isBreak:
            colObj.next_col()
        else:
            if span.isCode():
                print (' ??? How is there a codeObject in Columns')
                print(span)
            else:
                colObj.add_span(span)
    return colObj

def parse_sign_columns(span):
    colObj = ColumnCodeObject(span.codetag, 'SignColumns')

    for span in span.spans:
        isBreak = determine_if_colbreak (span)
        if isBreak:
            colObj.next_col()
        else:
            if span.isCode():
                print (' ??? How is there a codeObject in SignColumns')
                print(span)
            else:
                colObj.add_span(span)
    return colObj




class SoupMenuCodeObject(ParsedCodeBlockBase):
    def __init__(self, codetag):
        super().__init__('SoupMenu')
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

def parse_soup_menu(tbpspan):

    menu = SoupMenuCodeObject(tbpspan.codetag)
    spans = tbpspan.spans
    print('soupmenu')
    for span in spans:

        if span.hasText():
            text = span.get_text()

            text = text.replace('…', '.')
            if '.' in text:
                items = text.split('.')
                items = [i for i in items if len(i)>0]

                if len(items)>=2:
                    name = items[0]
                    price = items[-1]
                    print('Menu:', name, price)
                    menu.add_item(name, price)
    return menu




class TextsCodeObject(ParsedCodeBlockBase):
    def __init__(self, codetag):
        super().__init__('iMessageTexts')
        self.codetag = codetag
        self.items = []
        self.characters = []

    def add_item(self, from_, msg):
        if from_ not in self.characters:
            self.characters.append(from_)
        self.items.append((from_msg))

    def elemWalker(self):
        while False:
            yield None

    def get_binary(self):
        b = BinList('iMessageTexts.get_binary')

        b += pack_unsigned_int(len(self.characters))

        b += pack_literal('[')
        for frm, msg in self.items:
            b += pack_text(frm)
            b += ':'
            b += pack_text(msg)
            b += ';'
        b += pack_literal('];')
        return b

def parse_imessage_object(tbpspan):
    msgsObj = TextsCodeObject(tbpspan.codetag)
    spans = tbpspan.spans
    print('imessages')
    for span in spans:

        if span.hasText():
            text = span.get_text()

            if ':' in text:
                items = text.split(':')

                frm = items[0]
                msg = items[1:].join(':')
                # items = [i for i in items if len(i)>0]
                msgsObj.add_item(frm, msg)
    return menu
