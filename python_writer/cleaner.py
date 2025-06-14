
from bs4 import BeautifulSoup
import bs4

import os

from objects import *
from common.logger import *
from common.style_handler import StyleHandler
import common.files as cf

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst

logger_start('cleaner')

if __name__=="__main__":
    # pst.DEBUG=True
    pass


REDACT=False
COLORED_BOXES=False

spans, fonts = cf.read_spans_and_fonts('spans_raw.json', 'fonts_cleaned.json')

health_inspection_count = 0
def health_inspection():
    global health_inspection_count
    health_inspection_count+=1
    print("Health inspection! {",health_inspection_count,"}")

    cf.common_health_inspection(spans)


health_inspection()

change_log_file('headers')


print('Upgrade to Headers')
# for sp in spans:
for i in range(len(spans)):

    if isinstance(spans[i], TextSpan):
        if spans[i].font.isHeading:
            print('->Heading', spans[i])
            spans[i] = Header(spans[i].font, spans[i].text, spans[i].align())

print('//////')
print ("Combining Headers")

prev = spans[0]
# pi = 0
i = 1
while i < len(spans):
    if isinstance(spans[i], Header):
        # print('i:', i, 'pi:', pi)
        if isinstance(prev, Header):
            # Combine
            # if '\n' in spans[pi].text:
            #     # Assume two diff headers; keep next
            #     exhdr = spans[i]
            #     spans[i] = TextSpan(exhdr.font, exhdr.font)
            #     print('Demote consecutive header', spans[i])
            # else:

            print('H:Combined:', prev.text, spans[i].text)
            prev.text += spans[i].text
            spans.pop(i)
            i -= 1
    prev = spans[i]
    # pi+=1
    i+=1

print()
print ("Disabling Repeated Headers")

recentHeader = None
# pi = 0
i = 1
while i < len(spans):
    if isinstance(spans[i], Header):
        # print('i:', i, 'pi:', pi)
        if recentHeader is not None:
            # Combine
            # Assume two diff headers; keep next
            exhdr = spans[i]
            print('Demote consecutive header', spans[i])
            spans[i] = TextSpan(exhdr.font, exhdr.text, exhdr.align())
        else:
            recentHeader = spans[i]
            # else:
    elif recentHeader is not None:
        # If any real text between lines
        if isinstance(spans[i], TextSpan):
            # Break
            if len(spans[i].text.strip()) > 0:
                # print('Break:', spans[i].text)
                recentHeader = None
        if isinstance(spans[i], MultiSpan):
            # Break
            # print('Break:')
            recentHeader = None
    # pi+=1
    i+=1

print()
print('Deleting empty headers')

i = 0
while i < len(spans):
    if isinstance(spans[i], Header):
        print(spans[i])
        if len(spans[i].chp_name())==0:
            print('delete empty header')
            spans.pop(i)
            i-=0
            pst.click()
    i += 1

print('That\'s the headers')

health_inspection()

pst.button()
# print("Replacing headers")
# for i in range(len(spans)):

# pst.unfinished()
# print('\n'.join(str(s) for s in spans))


change_log_file('text smoothing')

if COLORED_BOXES:
    print('Finding colored boxes')

    i0 = 0
    while i0 < len(spans):
        if isinstance(spans[i0], TextSpan):
            # if '  ' in spans[i0]:
            # Match any number of spaces at beginning or end
            hasBg = spans[i0].font.hasBgCol()
            t = spans[i0].text
            num_leading_spaces = 0
            while num_leading_spaces < len(t) and t[num_leading_spaces]==' ':
                num_leading_spaces+=1
            span_consumed = (num_leading_spaces == len(t))

            if num_leading_spaces > 0:
                if num_leading_spaces > 2 or hasBg:
                    pos = 'leading' if span_consumed else 'main'
                    lsp = ColoredBoxSpan(t[:num_leading_spaces], spans[i0].font, pos, spans[i0].align())
                    print('Moved L space span:', num_leading_spaces, 'spaces')
                    spans[i0].text = t[num_leading_spaces:]
                    t = spans[i0].text
                    print('leftover t:', f"'{t}'")
                    assert not t.startswith(' ')
                    spans.insert(i0, lsp)
                    i0 += 1
            if len(t) == 0:
                assert span_consumed
                spans.pop(i0)
                i0-=1
            else:
                num_tail_spaces = 0
                while len(t) > num_tail_spaces+1 and t[-num_tail_spaces-1] == ' ':
                    num_tail_spaces+=1
                if num_tail_spaces >0 and hasBg:
                    rsp = ColoredBoxSpan(t[-num_tail_spaces:], spans[i0].font, 'tail', spans[i0].align())
                    print('Moved R space span:', num_tail_spaces, 'spaces')
                    spans[i0].text = t[:-num_tail_spaces]
                    t = spans[i0].text
                    print(f"Leftover t: '{t}'")
                    assert not t.endswith(' ')
                    # if add_end_element:
                    spans.insert(i0+1, rsp)
                    i0 += 1
        i0 += 1

health_inspection()
print('Joining Text')

i0 = 0
while i0 < len(spans)-1:
    i1 = i0+1
    if spans[i0].hasFont() and spans[i0].hasText():
            if '\n' not in spans[i0].text:
                # if not spans[i1].isNL() and not spans[i1].isCode():
                if spans[i1].hasFont() and spans[i1].hasText():
                    if spans[i0].font == spans[i1].font:# and i1 < len(spans)-1:
                        print('join', spans[i0].text,'+', spans[i1].text)
                        spans[i0].text += spans[i1].text
                        spans.pop(i1)
                        i0-=1
    i0+=1
pst.click()

health_inspection()

print('Breaking Long Text')
i = 0
max_newlines = 4
max_newline_str = '\n' * max_newlines
while i < len(spans):
    if not spans[i].isNL():
        t = spans[i].text
        nlix = t.find(max_newline_str)
        if nlix != -1:
            nlix2 = nlix+1
            while nlix2 < len(t) and t[nlix2]=='\n':
                nlix2+=1
            print('break', spans[i])
            print('\tt="', t, '"')
            spans[i].text = t[:nlix]
            nl = NewLine(spans[i].font)
            nl.amt = nlix2-nlix
            print('\tamt:', nl.amt)
            spans.insert(i+1, nl)
            if nlix2 < len(t):
                print('\tadd after:')
                tt = TextSpan(spans[i].font, t[nlix2:], spans[i].align())
                print('\t', tt)
                spans.insert(i+2, tt)
            i+=1

    i+=1

pst.click()

health_inspection()
print('Checking for empty ')


i = 0
while i < len(spans):
    if spans[i].hasText():
        if len(spans[i].text)==0:
            spans[i] = NewLine(spans[i].font)
            # spans.pop(i)
            # i-=1
    i+=1

health_inspection()

print('Converting newlines & boxes')

import font_lookup as fldb

def convert_to_sized_newline(i):
    assert isinstance(spans[i], NewLine)
    height = fldb.get_total_font_height(spans[i].font)
    # print(height, type(height))
    spans[i] = NewLineSized(height)

def convert_to_sized_box(i):
    assert isinstance(spans[i], ColoredBoxSpan)
    width = fldb.get_box_width(spans[i].text, spans[i]._font)
    # We want this to be the same value as the rest of the text
    height = fldb.get_total_font_height(spans[i]._font)
    spans[i].width = width
    spans[i].height = height
    # Unceremoniously remove text
    spans[i].text = None
    del spans[i]._font

for i in range(len(spans)):
    if isinstance(spans[i], NewLine):
        convert_to_sized_newline(i)
    if isinstance(spans[i], ColoredBoxSpan):
        convert_to_sized_box(i)

health_inspection()

fldb.end_step()

# exit(0)
print("Joining Newlines")
# TODO: Do some actual cleaning, and straighten some of the lines
# TODO: Give flutter actual size of fonts

""" TODO:
Round newline heights to these values:

// L =  Line's actual size.
l (line))
    * [ 1, 2, 3, 5, 7, 10, 12 ],

u (bundle = 12 palatino lines)
    * [
        1u = break
        2u = dramatic tension
        3u = page
    ],

d = 2u
    // For computer-added spacing


// L line size

I feel like if previous & next are different, you wanna compute the value for both, and then find the midpoint of L and the midpoint of the units.

I feel like you wanna take the RMS, and maybe include Palatino.
"""

health_inspection()

i0 = 0
while i0 < len(spans)-1:
    i1 = i0+1
    if isinstance(spans[i0], NewLineSized):
        if isinstance(spans[i1], NewLineSized):
            if i0>0:
                print(spans[i0-1])
            print('Combine NL', i0, i1, spans[i0].height, spans[i1].height, end=' = ')
            spans[i0].height += spans[i1].height
            print(spans[i0].height)
            spans.pop(i1)
            i0-=1
    i0 += 1
pst.click()

health_inspection()

print ('Removing comments')
print()
import re
regex = re.compile("/\n\/\/.*\n/gm")


i = 0
while i < len(spans):
    if spans[i].hasText():
        if spans[i].text.startswith('//'):
            if '///' in spans[i].text:
                pass
            elif '\n' in spans[i].text:
                print('Removing comment line:')
                nn = spans[i].text.index('\n')
                print('Del :', spans[i].text[:nn])
                print('Keep:', spans[i].text[nn+1:])
                spans[i].text = spans[i].text[nn:]
            else:
                print('Deleting comment:')
                print('Cmnt:', spans[i].text)
                spans.pop(i)
                i-=1
        else:

            # result = regex.match(spans[i].text)
            tt = re.sub(regex, '', spans[i].text)
            if tt != spans[i].text:
                print('Replaced comment')
                print('Orig:', spans[i].text)
                print('Repl:', tt)
            else:
                if '//' in spans[i].text:
                    print('Mightve missed:')
                    print(spans[i].text)
            spans[i].text = tt
    i+=1
print()
print()

health_inspection()
print('Redacting')

if REDACT:
    word_repl = {'White House': 'White Hoe', 'Pentagon': 'Septagon', 'CIA':'CἹÅ', 'FBI': 'Female Body Inspectors', "Wray": 'Wrey', 'Bill Burns': "Bill Boourns"}

    print('TODO: Redact')
    i = 0
    while i < len(spans):
        if spans[i].hasText():
            text = spans[i].text
            # TODO:
            for key in word_repl.keys():
                if key in text:
                    text = text.replace(key, word_repl[key])
                    spans[i].text = text
        i+=1

print('Creating Multi Spans')
# Create multi spans
# Looking for spans that don't have line breaks

# No headings in spans
# Dont forget all alignments must match

health_inspection()

def span0_check(span0):
    t= type(span0).__name__
    print(t, span0)
    if t == 'TextSpan':
        print(span0.text)
        if '\n' in span0.text:
            print('\thas newline')
            return False
        if span0.font.isHeading:
            print('\theading')
            return False
        return True
    elif t == 'ColoredBoxSpan':
        # return span0.pos=='leading'
        return True
    else:
        return False

def span_check(span0, next):
    # Returns whether next can be joined into span0
    t= type(next).__name__
    print(t, next)
    if t == 'TextSpan':
        print(f'"{next.text}"')
        # No line breaks
        if '\n' in next.text[:-1]:
            print('\tHas newline within span')
            return False
        if next.font.isHeading:
            print('\theading')
            return False
        if next.align() != span0.align():
            print('\talign within span mismatch')
            return False
        if '\n' == next.text[-1]:
            print('\tlast')
            return 'last'
        return True
    elif t == 'ColoredBoxSpan':
        # TODO: This will eventually be limiting
        # if next.pos == 'tail':
        #     return 'last'
        return True
    else:
        # Multispan?
        return False

# Make Multi Spans

i0= 0
while i0 < len(spans):
    if span0_check(spans[i0]):
        print(i0, 'check1')

        spanTo = i0+1
        while spanTo < len(spans):
            sp= span_check(spans[i0], spans[spanTo])
            if sp=='last':
                spanTo += 1
                break
            elif sp == False:
                break
            elif sp==True:
                spanTo += 1
        # i0 - i1 (exclusive)
        if spanTo-i0 >= 2:

            multi = MultiSpan(spans[i0:spanTo])
            spans = spans[:i0] + [multi] + spans[spanTo:]

            print('Spanning', i0, spanTo)
            print(multi.spans)
            print()
            # Clean new span
            done=False
            while len(multi.spans)>=2 and not done:
                done=True
                # Check for newline / spaces
                if multi.spans[-1].hasText():
                    # If entire last span is newline
                    if multi.spans[-1].text=='\n':
                        multi.spans[-2].text += '\n'
                        multi.spans.pop(-1)
                        print('Move newline')
                    # If span ends with newline
                    elif multi.spans[-1].text[-1]=='\n':
                        sp= multi.spans[-1].text[:-1]
                        all_space=True
                        for c in sp:
                            if c!=' ':
                                all_space=False
                                break
                        assert not all_space, 'Shouldve already been removed'
                        if all_space:
                            multi.spans[-2].text += '\n'
                            multi.spans.pop(-1)
                            print('Move space-newline')
                # TODO: Check if color
                # if multi.spans[-1].text == ' ':
                #     multi.spans.pop(-1)
                #     done=False
                #     print('Remove space')

            if len(multi.spans)==1:
                print('Un-span')
                spans[i0] = multi.spans[0]

    i0 += 1

# print ("Joining multi spans")

# for span in spans:
#     if isinstance(span, MultiSpan):

health_inspection()

# exit(0)
print("Removing EndOfPara spacers")
i0 = 0
while i0 < len(spans):
    if isinstance(spans[i0], EndOfPara):
        spans.pop(i0)
        i0-=1
    i0 += 1
pst.click()


health_inspection()
print('Extracting tabs')

# for span in spans:
i0 = 0
while i0 < len(spans):
    span = spans[i0]
    if isinstance(span, TextSpan):
        while len(span.text)>0 and span.text[0]=='\t':
            span.tabs+=1
            span.text = span.text[1:]
        if span.tabs > 0:
            print(f'Extracted {span.tabs} tabs from {span}')
        if len(span.text) == 0:
            print(f'Removing all-tabbed span ({span.tabs})')
            spans[i0] = NewLine(span.font)
            convert_to_sized_newline(i0)
    elif isinstance(span, MultiSpan):
        assert len(span.spans)>0
        done = False
        newline_height = 0

        # Start removing
        while not done:
            # Make sure MultiSpan not empty
            if len(span.spans)==0:
                # assert newline_height == 0
                spans[i0] = NewLineSized(newline_height)
                done = True
            # Make sure first span not empty
            elif span.spans[0].text is None:
                # Likely a ColoredBoxSpan
                newline_height = span.spans[0].height
                if span.spans[0].color is None:
                    print("Damn, somebody should convert this to a newline")
                done = True
            elif span.spans[0].text == '':
                # Calculate font height in case the MultiSpan gets emptied later
                if not span.spans[0].hasFont():
                    print("MultiSpan:")
                    print(span)
                    print("Offending Subspan:")
                    print(span.spans[0])
                    print("No font??? In a MultiSpan?? Idgi")
                    exit(1)
                height = fldb.get_total_font_height(span.spans[0].font)
                newline_height = max(newline_height, height)
                # Remove empty leading span
                span.spans.pop(0)
            # Check for leading tab
            elif span.spans[0].text[0] == '\t':
                span.tabs+=1
                span.spans[0].text = span.spans[0].text[1:]
            # Else done
            else:
                done = True

        if span.tabs > 0:
            print(f'Extracted {span.tabs} tabs from {span}')
    i0+=1

health_inspection()

print('Writing')
change_log_file('writing')

cf.save_spans(spans, 'spans_clean.json')

logger_end()

# pst.unfinished(False)
print('> Cleaner Done: spans_clean.json <')
pst.end()
