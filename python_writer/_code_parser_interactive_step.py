
from objects import *
from objects.code_objects import *

import common.files as cf
from common.logger import *

# python_script_tools
import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst


"""
PO - uniquely_parsed_objects    ex: 'TimedAudio'
        These are stripped, saved, and sent directly to a separate parser.
        CodeTags there will have to be handled by the parser
# Removed:
# SO - span_holding_objects:      Ex: 'Article'
#         These objects have unique features but hold spans. They may include other code tags.
#     Ex: Article
BO - block_objects:             Ex: 'Shirt'
        These objects are a single block of spans.
        They are uniquely displayed by Flutter code.
        They can't contain other code objects.
LO - single_line_objects:       Ex: 'WHLAd'
        These objects are single line.
"""


class InteractiveMatchingStep():

    classTypes = {
        'k': 'Keyword',
        'p': 'ParsedObject',
        # 's': 'SpanObject',
        'b': 'BlockObject',
        't': 'Tag',
    }
    def create_class_dict():
        # Import from custom_code.py
        import objects.custom_code as cc
        poClasses = cc.uniquely_parsed_objects()
        # soClasses = cc.span_holding_objects()
        koClasses = cc.chapter_keywords()
        boClasses = cc.block_objects()
        loClasses = cc.single_line_objects()
        # Convert to dict
        classes = {}
        for p in poClasses:
            assert p not in classes
            classes[p]='p'
        for b in boClasses:
            assert b not in classes
            classes[b]='b'
        for l in loClasses:
            assert l not in classes
            classes[l]='l'
        for k in koClasses:
            assert k not in classes
            classes[k]='k'
        return classes

    def __init__(self):
        import objects.custom_code as cc

        self.classTextReplacements = cc.code_tag_replacements()

        self.classes = InteractiveMatchingStep.create_class_dict()

        print()
        print('Classes:')
        print(self.classes)
        print('ClassTextReplacements:')
        print(self.classTextReplacements)

        # classes_to_add = {'a':['Article', 'Journal'], 'b':['Block1', 'Block2']}
        self.classes_to_add = {}
        for c in InteractiveMatchingStep.classTypes:
            self.classes_to_add[c] = []

        print()
        self.openPO   = None
        self.openPOIx = None

        self.openBO   = None
        self.openBOIx = None

        change_log_file('interactive')

    def main(self, spans):
        self.spans = spans
        # save memory
        del spans

        self.i = 0
        while self.i < len(self.spans):
            i = self.i
            self.print_radius(i)
            self.printOpenObjects()

            # If ChapterStart
            if isinstance(self.spans[i], ChapterStart):
                print('ChapterStart', self.spans[i].get_text())
                if self.hasOpenObject('b'):
                    print('New chapter.')
                    print('Close',self.openBO,'CustomBlock?')
                    print(f'ChapterStart: {i}, openBO: {self.openBOIx}')
                    r = pst.saveable_response('Close?  y/c=close, x=exit, \nm=move ChapterStart before CustomBlock,\nd=delete ChapterStart,\n p=print')
                    if r=='p':
                        self.print_range(self.openBOIx-5, i+5)
                        r = pst.saveable_response('Close?  y/c=close, x=exit, \nm=move ChapterStart before CustomBlockd=delete ChapterStart')
                    if r in ['y', 'c']:
                        # close open CustomSpan
                        self._close_custom_block(has_end_tag=False)
                        self.decrement()
                        continue
                    elif r == 'd':
                        self._deleteChapterStart(i)
                    elif r == 'm':
                        self._moveChapterStart(i, self.openBOIx)
            #} ChapterStart
            # else if CodeTag
            elif isinstance(self.spans[i], CodeKeywordTag):
                pass
            elif isinstance(self.spans[i], CodeTag):
                obj = self.spans[i].obj
                hasColon = self.spans[i].hasColon

                if obj in self.classTextReplacements:
                    obj = self.classTextReplacements[obj]
                    self.spans[i].obj = obj

                classType = self.getObjectClassType(obj)
                #Check if '' is caught

                if len(obj.strip())==0:
                    print("Delete whitespace ", i)
                    self.spans.pop(i)
                    self.decrement()
                elif obj == '//':
                    pass
                elif classType is None:
                    caught = False
                    print('classType = None')
                    if self.hasOpenObject('b'):
                        print(obj, 'x', self.openBO.obj, '(',i, self.openBOIx,')')
                        if self._matches_classname_for_close(obj, self.openBO.obj):
                            self._close_custom_block(has_end_tag=True)
                            caught = True

                    if not caught:
                        print('Uncaught tag:', obj)
                        self.print_pos(i)
                        print('Uncaught tag:', f"'{obj}'")
                        if self.hasOpenObject('b'):
                            print('Hanging CustomBlock:', self.openBO)
                        print('Match?')
                        prompt = "Continue?" + \
                            ("o = matches CustomBlock," if self.openBO is not None else '') + \
                        """
                        w = add ParsedBlock, a=add CustomBlock, z=add tag,
                        k = convert to keyword,
                        d=delete, t=convert to mono_text, b=convert_to_body,
                        p=print, x=exit
                        """

                        r = pst.saveable_response(prompt)
                        if r=='p':
                            self.print_range(0, len(self.spans))
                            r = pst.saveable_response(prompt)
                        if r=='t':# convert to mono text
                            self.convert_to_text(i)
                            caught=True
                        elif r=='b': # convert to body
                            self.convert_to_body(i)
                            caught=True
                        elif r=='d': # delete
                            self.spans.pop(i)
                            self.decrement()
                            caught=True
                        elif r=='a': # add CustomBlock
                            # self._close_custom_block_if_open()
                            # self.i = i
                            # self._open_custom_block(i)
                            self.add_class(obj, 'b')
                            classType = 'b'
                        elif r=='k':
                            classType = 'k'
                            caught = True
                        elif r=='z': # Add CodeTag
                            self.spans[i].obj = obj
                            self.add_class(obj, 't')
                            classType = 't'
                        elif r =='o': # o = matches CustomBlock
                            assert self.openBO is not None
                            self._close_custom_block(has_end_tag=True)
                            caught = True
                        elif r=='w': # Matches ParsedBlock
                            raise NotImplementedError('Adding ParsedBlock on the fly (how dare you)')
                            classType = 'p'
                        else:
                            print("I must've missed an option.")
                            assert False
                # If ladder restarts to allow added objects
                # Keyword
                if classType == 'k':
                    # If Blocks clash with keyword
                    if self.hasOpenObject('b'):
                        print(f'CustomBlock {self.openBO} blocking Keyword {obj}.')
                        print(self.spans[i])
                        print('x', self.openBO)
                        self.print_range(self.openBOIx, i)
                        r = pst.saveable_response('Closing. Y=yes, p=print, n=exit')
                        if r=='p':
                            self.print_range(0, len(self.spans))
                            r = pst.saveable_response('Closing. Y/c=yes, x=exit')
                        if r in ['y', 'c']:
                            # close open Block
                            self._close_custom_block(has_end_tag=False)
                        elif r=='x':
                            exit(1)
                        elif r == 'n':
                            assert False
                        else:
                            assert False

                    self._change_to_keyword(i)
                # } Keyword
                elif classType == 'p':
                    # Close all objects
                    if self.hasOpenObject('b'):
                        # Block clashes with ParsedBlock
                        print(f'CustomBlock {self.openBO} blocking ParsedObject {obj}.')
                        print(self.spans[i])
                        print('x', self.openBO)
                        self.print_range(self.openBOIx, i)
                        r = pst.saveable_response('Closing. Y=yes, p=print, n=exit')
                        if r=='p':
                            self.print_range(0, len(self.spans))
                            r = pst.saveable_response('Closing. Y=yes, x=exit')
                        if r=='y':
                            # close open CustomSpan
                            self._close_custom_block(has_end_tag=False)
                        elif r == 'n':
                            assert False
                        else:
                            assert False

                    print('Detouring to object')
                    self.parsed_object_detour(i)
                    self.decrement()
                #}ParsedBlock
                elif classType == 'b':
                    # BlockObject{
                    if self.hasOpenObject('b'):
                        if self._matches_classname_for_close(obj, self.openBO.obj):
                            if hasColon:
                                print(f'{obj} ({i}) has a colon. Closing & Starting new object.')
                                self._close_custom_block(has_end_tag=False)
                                i = self.i
                                self._open_custom_block(i)
                            else:
                                self._close_custom_block(has_end_tag=True)
                                i = self.i
                        else:
                            print('Clashing CustomBlocks.')
                            print(self.spans[i],'/', obj, f"({i})")
                            print('x', self.openBO, f"({self.openBOIx})")

                            r = pst.saveable_response('Continue? n=no, m = match, c=add close, p=print')
                            if r=='m':
                                self._close_custom_block(has_end_tag=True)
                            if r=='c':
                                self.decrement()
                                self._close_custom_block(has_end_tag=False)
                            if r in ['n', 'x']:
                                assert False
                            if r=='p':
                                self.print_range(0, len(self.spans))
                                exit(0)
                    else:
                        # No open BO
                        self._open_custom_block(i)
                #}BlockObject
                #Tag
                elif classType == 't':
                    self.spans[i].obj = obj
                    print(obj, 'Tag is good')
                #}Tag
            # /if CodeTag
            self.i += 1
        return self.spans, self.classes_to_add



    """ ================================================================
                API
        ================================================================
    """
    def decrement(self):
        self.i -= 1

    def convert_to_text(self, i):
        self.spans[i] = TextSpan(Font.codelike('codelike'), self.spans[i].text, 'l')

    def convert_to_body(self, i):
        self.spans[i] = TextSpan(Font.body('body'), self.spans[i].text, 'l')

    def getObjectClassType(self, obj):
        if obj in self.classes:
            return self.classes[obj]
        else:
            return None
    def hasAnyOpenObject(self):
        return self.openBOIx is not None or self.openPOIx is not None
    def hasOpenObject(self, type = None):
        if type == None:
            return self.hasAnyOpenObject()
        elif type == 'p':
            return self.openPOIx is not None
        # elif type == 's':
        #     return self.openSOIx is not None
        elif type == 'b':
            return self.openBOIx is not None
        elif type == 't':
            return False
        elif type == 'k':
            return False
        else:
            raise ValueError('Unrecognized ClassType: '+type)
    def getOpenObject(self, type):
        if type == 'p':
            return self.openPO
        # elif type == 's':
        #     return self.openSO
        elif type == 'b':
            return self.openBO
        elif type in ['t', 'k']:
            return None
        else:
            raise ValueError('Unrecognized ClassType: '+type)
    def getOpenObjectIx(self, type):
        if type == 'p':
            return self.openPOIx
        # elif type == 's':
        #     return self.openSOIx
        elif type == 'b':
            return self.openBOIx
        elif type in ['t', 'k']:
            return None
        else:
            raise ValueError('Unrecognized ClassType: '+type)

    def add_class(self, obj, type):
        self.classes_to_add[type].append(obj)
        self.classes[obj] = type

    """ ================================================================
                Span Internals
        ================================================================
    """

    def match_obj_keyword(self, obj):
        import objects.custom_code as cc
        koClasses = cc.chapter_keywords()

        if obj in koClasses:
            return obj
        else:
            print("Checking related keywords.")
            for kw in koClasses:
                if kw in obj:
                    r = pst.saved_response(f"Does object '{obj}' mean '{kw}'? y/n\n")
                    if r=='y':
                        return obj

                elif obj in kw:
                    r = pst.saved_response(f"Does object '{obj}' mean '{kw}'? y/n\n")
                    if r=='y':
                        return obj
            print ("Checking all keywords.")
            for kw in koClasses:
                r = pst.saved_response(f"Does object '{obj}' mean '{kw}'? y/n\n")
                if r=='y':
                    return obj
            #Not a keyword
            assert False

    def _change_to_keyword(self, i):
        # print(self.spans[i], type(self.spans[i]))
        assert isinstance(self.spans[i], CodeTag)

        self.spans[i] = CodeKeywordTag(self.spans[i])

        obj = self.match_obj_keyword(self.spans[i].obj)
        self.spans[i].obj = obj

        print('Upgraded span to keyword: ', self.spans[i])

    def _open_custom_block(self, i):
        print('Opening CustomBlock')
        self.print_pos(i)

        assert isinstance(self.spans[i], CodeTag)
        if self.openBO is not None:
            # TODO: PST prompt
            assert False

        self.openBO = self.spans[i]
        self.openBOIx = i
        print('Opening CustomBlock', self.openBO, self.openBOIx)

    def _close_custom_block(self, has_end_tag):
        if not has_end_tag:
            self.decrement()
        i = self.i
        print('Close CustomBlock:')
        self.print_pos(self.openBOIx)
        self.print_pos(i)
        print(f'Moving {self.openBOIx}:{i} into CodeSection')

        assert self.hasOpenObject('b')
        assert not self.hasOpenObject('p')
        assert self.openBOIx < i

        self.print_range(self.openBOIx, i)

        assert (isinstance(self.spans[self.openBOIx], CodeTag))
        if has_end_tag:
            assert (isinstance(self.spans[i], CodeTag))

        subspans = self.spans[self.openBOIx+1: i]

        #   (span, codetag, codeMarker):
        newSection = CodeSection(subspans, self.openBO, self.openBO.codeMarker)

        # l = len(self.spans)
        print('Spans: ', len(self.spans))
        self.spans = self.spans[:self.openBOIx] + [newSection] + self.spans[i+1:]
        print(' -> spans ', len(self.spans))
        # ldiff = l - len(self.spans)
        assert (isinstance(self.spans[self.openBOIx], CodeSection))

        i = self.openBOIx
        self.i = i

        self.openBO=None
        self.openBOIx = None

        print('i := ', i)
        self.print_radius(i)

    def _close_custom_block_if_open(self):
        if self.openBO is None:
            assert self.openBOIx is None
        else:
            print(self.openBO)
            assert self.openBOIx is not None
            self._close_custom_block(has_end_tag=False)

    """ ================================================================
                ChapterStarts
        ================================================================
    """
    def _moveChapterStart(self, moveFrom, moveTo):
        # We want the ChapterStart before moveTo
        assert moveFrom > moveTo, 'implement the reverse direction'

        print(f"Moving {moveTo} <- {moveFrom}")
        assert moveFrom != moveTo
        assert isinstance(self.spans[moveFrom], ChapterStart)
        print(f'Moving {self.spans[moveTo]} <- {self.spans[moveFrom]}')
        self.spans.insert(moveTo, self.spans.pop(moveFrom))
        # print(f'Moved  {self.spans[moveTo]} <- {self.spans[moveFrom]}')
        self.print_range(moveTo, moveFrom)
        self._update_ixes_after_move(moveFrom, moveTo)

    def _deleteChapterStart(self, moveFrom):
        print(f"Deleting ChapterStart @ {moveFrom}")
        assert isinstance(self.spans[moveFrom], ChapterStart)

        self.spans.pop(moveFrom)
        # print(f'Moved  {self.spans[moveTo]} <- {self.spans[moveFrom]}')
        self.print_pos(moveFrom, hilite=True)
        self._update_ixes_after_delete(moveFrom)


    """ ================================================================
                General Internals
        ================================================================
    """
    def _update_ixes_after_move(self, moveFrom, moveTo):
        if self.hasOpenObject('b'):
            assert self.openBOIx != moveFrom
            # TODO: This looks wrong but I don't want to touch it
            #       (shouldn't moveFrom and moveTo be flipped?)
            if self.openBOIx < moveFrom and self.openBOIx >= moveTo:
                self.openBOIx += 1
            assert isinstance(self.spans[self.openBOIx], CodeTag)
        if self.hasOpenObject('p'):
            assert self.openPOIx != moveFrom
            # TODO: This looks wrong (as above)
            if self.openPOIx < moveFrom and self.openPOIx >= moveTo:
                self.openPOIx += 1
            # assert isinstance(self.spans[self.openPOIx], CodeTag, Parsed)

    def _update_ixes_after_delete(self, moveFrom):
        if self.hasOpenObject('b'):
            assert self.openBOIx != moveFrom
            if self.openBOIx > moveFrom:
                self.openBOIx -= 1
            assert isinstance(self.spans[self.openBOIx], CodeTag)
        if self.hasOpenObject('p'):
            assert self.openPOIx != moveFrom
            if self.openPOIx > moveFrom:
                self.openPOIx -= 1
            # assert isinstance(self.spans[self.openPOIx], CodeTag, Parsed)

    """ ================================================================
                Utility
        ================================================================
    """
    def _matches_classname_for_close(self, obj, tag):
        """
        Matches start to end tags.
            Article = obj
                "Blahblahblah"
            /Article = tag
        """
        # - always assumed to be close
        if tag == '-':
            return True
        # Anything with a ':' is definitely a new object
        if ':' in tag:
            return False
        # compare without symbols
        tag = self._strip_tag(tag)
        obj = self._strip_tag(obj)
        if tag == obj:
            return True
        if obj in tag:
            return True
        if tag in obj:
            return True
        return False

    def _strip_tag(self, tag):
        tc = tag.lower()
        tc = ''.join(ch for ch in tc if ch.isalnum())
        return tc

    """ ================================================================
                ParsedObjects
        ================================================================
    """
    def find_parsed_object_close(self, i):
        """
        Because ParsedObjects have fucky formatting, the user must do them manually.

        To avoid 1000 "nos", uses "no_bother":
            No_bother = [0 (most desparate), 5 (only correct answers)]
        """
        start_i = i
        self.openPO = self.spans[i]
        obj = self.openPO.obj
        print(f'Looking for end of {obj}.')

        self.no_bother = 0

        skip_unlabelled = False

        i += 1

        while i < len(self.spans):

            self.print_pos(i)

            if isinstance(self.spans[i], ChapterStart):
                print('ChapterStart:')
                self.print_pos(i)
                r = pst.saveable_response('You must close '+str(self.openPO)+' ParsedBlock.')
                return i, False
            elif isinstance(self.spans[i], Header):
                if self.no_bother <= 4:
                    print('Header:')
                    self.print_pos(i)
                    # print('Close',self.openPO,'ParsedBlock?')
                    closed, is_end = self._offer_parsed_object_close(4, i, False)
                    if closed:
                        return i, is_end

            elif isinstance(self.spans[i], CodeTag):
                clashingObj = self.spans[i].obj
                print('Found CodeTag:', clashingObj)
                if clashingObj.startswith('//'):
                    closed, is_end = self._offer_parsed_object_close(0, i, True)
                    if closed:
                        return i, is_end

                if clashingObj in self.classTextReplacements:
                    clashingObj = self.classTextReplacements[clashingObj]
                    print(f'({clashingObj})')

                clashingClassType = self.getObjectClassType(clashingObj)

                if clashingClassType=='p':
                    # TODO: Do this first.
                    print('ParsedBlock.', clashingObj)
                    if clashingObj == obj:
                        print('Matching ParsedBlock tag. ')
                        closed, is_end = self._offer_parsed_object_close(5, i, True)
                        if closed:
                            return i, is_end
                    else:
                        print("Different ParsedBlock.")
                        closed, is_end = self._offer_parsed_object_close(4, i, False)
                        if closed:
                            return i, is_end

                elif clashingClassType=='p':
                    print('CustomBlock', clashingObj)
                    closed, is_end = self._offer_parsed_object_close(2, i, False)
                    if closed:
                        return i, is_end
                elif clashingClassType=='t':
                    print('CustomTag', clashingObj)
                    closed, is_end = self._offer_parsed_object_close(1, i, False)
                    if closed:
                        return i, is_end

                else:
                    if self.no_bother<=0:
                        print('Unrecognized CodeTag.')
                        closed, is_end = self._offer_parsed_object_close(0, i, True)
                        if closed:
                            return i, is_end


            i += 1

        return None, None

    def parsed_object_detour(self, i):
        """
        ParsedObjects are parsed differently from the rest
        So this doesn't use the main loop.
        """
        self.openPO = self.spans[i]
        obj = self.openPO.obj

        # Pass once to find end of ParsedObject
        end_of_parsed_object, has_end_tag = self.find_parsed_object_close(i)

        if end_of_parsed_object is None:
            print('Unable to close ParsedObject.')
            self.print_pos(i)
            assert False

        self._snip_out_parsed_object(i, end_of_parsed_object, has_end_tag)
        print('Fixed ParsedObject!!')

    def _offer_parsed_object_close(self, match_ranking, print_i, counts_as_end_tag):
        """
        Ask user if this element closes the ParsedObject.

        Ranks matches. Only offers matches at the correct level.
            This allows the script to look for Rank5 matches, then Rank4, etc
            0 = No way. 5 = Most def

        Returns (is_match, has_end_tag)
        """

        if match_ranking==5:
            # Means perfect match
            return True, counts_as_end_tag
        if match_ranking < self.no_bother:
            return False, False
        # Already tried these
        extra_option = ''
        if counts_as_end_tag:
            extra_option  = 's= Close and move this tag to separate end tag'
        else:
            extra_option = 'i= Close and include this end tag'
        print(f'(Closing {self.openPO})')
        r = pst.saveable_response('Close ParsedBlock? yc=close, n=no, p=print \n' + \
            "l=Ask less \n" + \
            # 'm=Ask more?\n' + \
            extra_option)
        if r == 'p':
            self.print_range(start_i, print_i)
            r = pst.saveable_response('Close ParsedBlock? yc=close, n=no')
        if r in ['y', 'c']:
            return True, counts_as_end_tag
        if r == 's':
            return True, False
        if r == 'i':
            return True, True
        if r == 'l':
            self.no_bother += 1
            return False, False
        return False, False

    def _snip_out_parsed_object(self, start_i, end_i, includes_end_tag):
        # if includes_end_tag:
        #     end_i -= 1
        i = start_i

        print()
        print('Snipping ParsedBlock:')
        print(f'Moving {start_i}:{end_i} into multispan')

        parsedObject = self.spans[start_i]
        subspans = self.spans[start_i+1: end_i]

        #   (span, codetag, codeMarker):
        newSection = ToBeParsedCodeBlock(subspans, parsedObject)

        l = len(self.spans)
        print('Spans: ', len(self.spans))

        next_start = end_i
        if includes_end_tag:
            next_start += 1

        self.spans = self.spans[:start_i] + [newSection] + self.spans[next_start:]
        print(' -> spans ', len(self.spans),'(', len(self.spans)-l, 'diff)')

        assert (isinstance(self.spans[start_i], ToBeParsedCodeBlock))

        self.i = start_i + 1

        print('i := ', self.i)
        self.print_radius(self.i)

    """ ================================================================
                Print
        ================================================================
    """
    def printOpenObjects(self):
        for type, name in InteractiveMatchingStep.classTypes.items():
            if self.hasOpenObject(type):
                object = self.getOpenObject(type)
                ix = self.getOpenObjectIx(type)
                print(f'Current open {name}:')
                print('\t', ix, object)
                assert self.spans[ix] == object

    def print_pos(self, i, hilite=False):
        if i < 0 or i >= len(self.spans):
            return

        ld = '>>> ' if hilite else '    '

        c = type(self.spans[i]).__name__
        CL = 9
        if len(c)>CL:
            c = c[0:5] +'.'+ c[-3:]
        elif len(c) < CL:
            c = c+ ' '*(CL-len(c))

        c = ld + str(i)+' '+ c + '\t'

        if self.spans[i].isCode():
            print(c, self.spans[i])
        else:
            if self.spans[i].hasText():
                print(c,'\t', self.spans[i].get_text().replace('\n', '\t'))
            elif isinstance(self.spans[i], MultiSpan):
                print(c,'\t', self.spans[i].get_text().replace('\n', '\t')[:100])
            else:
                print(c)

    def print_radius(self, code_tag_position):
        print('\n{{{')
        e0 = max(code_tag_position-2, 0)
        e1 = min(code_tag_position+3, len(self.spans))
        for i in range(e0, e1):
            self.print_pos(i, hilite= (i==code_tag_position))
        print('}}}')

    def print_range(self, x1, x2):
        print('\n{{{')
        e0 = max(x1-5, 0)
        e1 = min(x2+5, len(self.spans))
        for i in range(e0, e1):
            if i==x1:
                print('>>>')
            self.print_pos(i)
            if i==x2:
                print('<<<')
        print('}}}')
