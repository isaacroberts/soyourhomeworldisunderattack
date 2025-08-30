from objects import *
from objects.code_objects import *

import common.files as cf
from common.logger import *

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst

from _code_parser_interactive_step import InteractiveMatchingStep
import objects.custom_code as cc

def code_parse_files( use_saved_responses=None, \
    in_spans='spans_clean.json', in_fonts='fonts_clean.json', out_spans='spans_coded.json'):

    pst.use_logger(print)

    logger_start('code_parser')
    change_log_file('start')

    spans, _ = cf.read_spans_and_fonts(in_spans, in_fonts)

    spans = code_parse(spans, use_saved_responses)

    print('Saving:')
    cf.save_spans(spans, out_spans)
    print('Written ')

    logger_end()

def code_parse(spans, use_saved_responses=None):

    any_code_tags = has_any_code_tags(spans)

    if any_code_tags:
        # pst.click(2)
        if use_saved_responses is None:
            print('Has code parse changed?')
            r= pst.response('y/n')
            if r=='n':
                use_saved_responses=True
        if use_saved_responses:
            pst.USE_SAVED_RESPONSES=True
            pst.recall_saved_responses('data/codeparse_responses')

    change_log_file('book_info')

    book_info = get_book_info(spans)
    write_book_info(book_info)
    change_log_file('auto')
    if any_code_tags:
        spans = handle_cut_keywords(spans)
    spans = align_chapters(spans)
    if any_code_tags:
        spans = remove_comments(spans)
        # Big step
        spans = match_custom_code(spans)
        # Calls outside scripts
        spans = parse_customs(spans)
    return spans

def get_book_info(spans):
    # Book info
    # BookId: kevin
    # BookTitle: Kevin Stops Fascism
    # BookByline: Kevin McAllister takes on his old nemesis, Donald Trump.
    # BookColor: #631500

    book_info = {}

    # for i in range(len(spans)):
    i=0
    while i < len(spans):
        if isinstance(spans[i], CodeTag):
            if spans[i].obj == 'BookId':
                book_info['id'] = spans[i].params[0]
                spans.pop(i)
            elif spans[i].obj == 'BookTitle':
                book_info['title'] = spans[i].params[0]
                spans.pop(i)
            elif spans[i].obj == 'BookByline':
                book_info['byline'] = spans[i].params[0]
                spans.pop(i)
            elif spans[i].obj == 'BookColor':
                # Hex parsing
                book_info['color'] = spans[i].params[0]
                spans.pop(i)
            else:
                i += 1
        else:
            i += 1
        # i += 1
    return book_info

def write_book_info(book_info):
    if book_info is not None:
        with open(f'temp/book.json', 'w') as f:
            import jsonpickle
            str1 = jsonpickle.encode(book_info)
            f.write(str1)

def handle_cut_keywords(spans):
    for i in range(len(spans)):
        if isinstance(spans[i], CodeTag):
            if spans[i].obj in ['CutHere', 'EndOfBook', 'EndBook']:
                # We need access to the TextObj
                print(spans[i-5: i])
                r = pst.saveable_response(f'Cut here?')
                if r == 'y':
                    return spans[:i]
    return spans


def align_chapters(spans):
    print('Aligning Chapters')

    if not isinstance(spans[0], ChapterStart):
        spans.insert(0, ChapterStart.leadingTitleChapter())

    i = 0
    while i < len(spans):
        if isinstance(spans[i], Header):
            if not isinstance(spans[i-1], ChapterStart):
                spans.insert(i, ChapterStart(spans[i].get_text()))
                i+=1
        elif isinstance(spans[i], CodeTag):
            obj = spans[i].obj
            params = spans[i].params

            if obj == 'EndChapter':
                print('Ending chapter.')
                is_headline=False
                i2 = i+1
                r = ''
                for ip in range(i-4, i+5):
                    if ip >=0 and ip < len(spans):
                        print('>>>' if ip==i else '   ' , spans[ip])
                while not is_headline:
                    print(spans[i2])
                    r = pst.saveable_response('Is this the next headline? (y=yes, c=no; create new chapter after,\n h=create new headline)')
                    if r in ['y', 'c', 'h']:
                        is_headline = True
                        break
                    else:
                        i2 += 1

                if r == 'c':
                    t = pst.saveable_response('Enter ChapterTitle')
                    spans.insert(i2, ChapterStart(t))
                elif r=='h':
                    t = pst.saveable_response('Enter text of headline.')
                    # Chapter will be added later
                    spans.insert(i2, Header(t))
                elif r=='y':
                    if isinstance(spans[i2], Header):
                        pass
                    else:
                        t = spans[i2].get_text()
                        spans.insert(i2, ChapterStart(t))

                print('Removing ChapterEnd.')
                spans.pop(i)
                i -= 1

        i+=1
    return spans

def remove_comments(spans):
    # Disabled: Remove comments
    i=0
    while i < len(spans):
        if spans[i].isCode():
            if spans[i].obj == '//':
                spans.pop(i)
                i-=1
        i+=1
    return spans

def match_custom_code(spans):

    change_log_file('custom_code')

    print()
    print('Searching custom_code')

    print('-------------------------------------')
    print('-------------------------------------')
    print('-------------------------------------')

    im = InteractiveMatchingStep()
    spans, to_add = im.main(spans)

    print('Finished InteractiveMatchingStep')

    pst.print_and_save_responses('data/codeparse_responses')
    change_log_file('homework')
    print_to_add(to_add)
    logger_end()
    return spans

def print_to_add(to_add):
    total_to_add_len = 0
    for sublist in to_add.values():
        total_to_add_len += len(sublist)

    if total_to_add_len > 0:
        print('Don\'t forget to add:')

    for type, sublist in to_add.items():
        typename = InteractiveMatchingStep.classTypes[type]
        print(f'{typename}:')
        print('\n'.join(f"'{q}'," for q in sublist))


def parse_customs(spans):

    change_log_file('parse_customs')
    print('Parsing:')
    # TODO: Find ToBeParsedCodeBlocks and parse them
    i = 0
    while i < len(spans):
        if isinstance(spans[i], ToBeParsedCodeBlock):
            obj = cc.parse_custom(spans[i], spans[i].obj)
            if obj is not None:
                spans[i] = obj
            else:
                assert False, f'Parse {obj} failed.'
                # print('Removing ')
                # spans.pop(i)
                # i-=1
        i += 1
    print("Parsed")
    return spans

# ========== Utilities =========

def has_any_code_tags(spans):
    for s in spans:
        if isinstance(s, Header):
            print('>', s.get_text().strip())
        elif isinstance(s, CodeTag):
            print('\t#', s)
            print(len(s.params))
            return True


if __name__=="__main__":
    code_parse_files()
