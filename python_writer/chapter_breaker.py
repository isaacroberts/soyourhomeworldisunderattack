from objects import *
from objects.code_objects import *

import common.files as cf
from common.logger import *

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst
pst.DEBUG=False

def run_all(use_saved_responses=None, spans_in='spans_coded.json',fonts_in='fonts_clean.json', chapters_out='chapters.json'):
    """
    Files in -> File out

    Handles splitting spans into chapters,
    programmatic keywords, bookmarks, links, etc
    """

    pst.use_logger(print)
    logger_start('chapter_breaker')
    change_log_file('breaking')

    spans, _ = cf.read_spans_and_fonts(spans_in, fonts_in)

    if use_saved_responses is None:
        pst.click(5)
        print('Have chapters changed?')
        r= pst.response('y/n')
        if r=='n':
            use_saved_responses=True
    if use_saved_responses:
        pst.USE_SAVED_RESPONSES=True
        pst.recall_saved_responses('data/chapterbreaker_responses')

    chapters = break_chapters(spans)
    chapters = clean_chapters(chapters)

    write(chapters, chapters_out)

def write(chapters, filename='chapters.json'):
    """
    Write chapters to json
    """
    print("Preparing for pickle")

    # Prevent pickling recursion in nexts
    for chapter in chapters:
        if chapter.next is not None:
            chapter.next = chapter.next.id

    pst.print_and_save_responses('data/chapterbreaker_responses')

    print('Saving files:')

    for chapter in chapters:
        chapter.prepare_for_save()

    import json
    import jsonpickle

    with open('temp/'+filename, 'w') as f:
        str1 = jsonpickle.encode(chapters)
        f.write(str1)

    print('Saved!')

def break_chapters(spans):
    chapters = []

    if not isinstance(spans[0], ChapterStart):
        spans.insert(0, ChapterStart.leadingTitleChapter())

    # Om nom nom
    while len(spans) > 0 :
        print(spans[0], type(spans[0]))
        print(len(spans))
        print(ChapterStart)
        assert (isinstance(spans[0], ChapterStart))
        i_next = nextChapterStart(1, spans)
        if i_next is not None:
            chapter = Chapter(spans[0], spans[1:i_next])
            spans = spans[i_next:]
            chapters.append(chapter)
        else: #i_next is None:
            # Last element
            chapter = Chapter(spans[0], spans[1:])
            chapters.append(chapter)
            spans = []

    # Indexes
    for i in range(len(chapters)):
        chapters[i].index = i

    #Default next
    for i in range(len(chapters)-1):
        chapters[i].next = chapters[i+1]

    chapters[-1].next=None
    chapters[0].bookmarks.append('home')
    return chapters

def clean_chapters(chapters):
    # QA
    health_inspection(chapters)
    #needed for bookmarks
    for c in range(len(chapters)):
        chapters[c] = resolve_id_keywords(chapters[c])
    # QA
    health_inspection(chapters)
    # misc keywords
    for c in range(len(chapters)):
        chapters[c] = resolve_misc_keywords(chapters[c])
    # QA
    health_inspection(chapters)
    # bookmark-related keywords
    for c in range(len(chapters)):
        chapters[c] = read_bookmark_keywords(chapters[c], chapters)
    # QA
    health_inspection(chapters)
    # Ensure all keywords deleted
    for c in range(len(chapters)):
        # doesn't return
        check_for_keywords(chapters[c])
    # QA
    health_inspection(chapters)
    # Strip whitespace from beginning & end
    for c in range(len(chapters)):
        remove_whitespace(chapters[c])
    # QA
    health_inspection(chapters)
    # Make sure varnames don't collide
    ensure_varnames_unique(chapters)
    # QA
    health_inspection(chapters)
    # Mark chapters as their Part
    collect_parts(chapters)
    # QA
    health_inspection(chapters)
    return chapters


def remove_invisible_headline(chapter):
    """
    Returns which span was removed
    """
    print("Removing InvisibleHeadline.")

    only_headline = None
    for i in range(len(chapter.spans)):
        if isinstance(chapter.spans[i], Header):
            if only_headline is not None:
                only_headline = None
                break
            else:
                only_headline = i

    if only_headline is not None:
        chapter.spans.pop(i)
        return i

    for i in range(len(chapter.spans)):
        if isinstance(chapter.spans[i], Header):
            print(chapter.spans[i])
            r = pst.saveable_response('Is this the headline?')
            if r=='y':
                chapter.spans.pop(i)
                return i

    r = pst.saveable_response('No headline found. Remove a line anyway?')
    if r=='y':
        for i in range(len(chapter.spans)):
            r = pst.saveable_response('Remove this? (y=yes, d=done)')
            if r=='y':
                chapter.spans.pop(i)
                return i
            elif r=='d':
                return None

def resolve_id_keywords(chapter):
    i=0
    while i < len(chapter.spans):
        if isinstance(chapter.spans[i], CodeKeywordTag):
            span = chapter.spans[i]
            obj = span.obj
            if obj in ['Chapter', 'Section', 'Label']:
                if len(span.params)>0:
                    chapter.set_id(span.params[0])
                else:
                    print('Chapter:', chapter.headline_text)
                    print('Text:', span.get_text())
                    label = pst.saveable_response(f'No params found on {obj} CodeTag: {span}. (Enter keyword / Blank to continue / x to exit)')
                    label = label.strip()
                    if len(label)>0:
                        chapter.set_id(label)
                        print("Set ID to label")
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1
    return chapter

def resolve_misc_keywords(chapter):
    """
    Call second
    """
    print("Misc Keywords")

    i=0
    while i < len(chapter.spans):
        span = chapter.spans[i]
        if isinstance(span, CodeKeywordTag):
            obj = span.obj
            if obj == 'InvisibleHeadline':
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
                remove_invisible_headline(chapter)
            elif obj == 'Subtitle':
                value = chapter.spans[i].params[0]
                chapter.subtitle = value
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            elif obj == 'When':
                value = chapter.spans[i].params[0]
                chapter.when = value
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            elif obj == 'Where':
                value = chapter.spans[i].params[0]
                chapter.where = value
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            elif obj in ['Audio', 'UnskippableAudio', 'CopSting']:
                # TODO: Match audio to URL
                audio = chapter.spans[i].params[0]

                # TODO: Check other params
                chapter.audio = audio
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            elif obj == 'EndOfBook':
                raise NotImplementedError('EndOfBook')
                #TODO: Move this to BookMark keywords so you can cut the chapter list at this one
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            elif obj == 'Part':
                chapter.part = True
                partName = chapter.display_name
                if len(span.params[0])>0:
                    p0 = span.params[0]
                    if '|' not in p0:
                        partName = p0
                chapter.partName = partName

                hide = read_param(span.params, 'Hide')
                if hide is None:
                    hide = False
                elif hide=='1':
                    hide = True
                else:
                    hide = False
                chapter.hidepart = hide
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1
    return chapter

def read_bookmark_keywords(chapter, chapters):
    print('Resolving bookmark keywords:')
    i=0
    while i < len(chapter.spans):
        if isinstance(chapter.spans[i], CodeKeywordTag):
            obj = chapter.spans[i].obj
            if obj == 'Next':
                nextBookmark = chapter.spans[i].params[0]
                print("Matching next:", nextBookmark)
                chapter.next = chapter_from_bookmark(nextBookmark, chapters)
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1
    return chapter

def check_for_keywords(chapter):
    """
    All Keywords should be fixed by this point
    This function checks to make sure all have been handled
    """
    i=0
    while i < len(chapter.spans):
        if isinstance(chapter.spans[i], CodeKeywordTag):
            obj = chapter.spans[i].obj
            print(chapter.spans[i])
            r = pst.response("Unhandled keyword. Skip? (y/n)")
            if r=='y':
                chapter.spans.remove(i)
            else:
                assert False, f'Unhandled Keyword: "{obj} in chapter {chapter.id}"'
        i += 1


def remove_whitespace(chapter):
    print("Removing whitespace from ", chapter.id)

    print('first element: ', chapter.spans[0])
    while len(chapter.spans)>0 and isinstance(chapter.spans[0], (NewLine, NewLineSized)):
        print('remove newline from start', chapter.spans[0])
        chapter.spans.pop(0)

    if isinstance(chapter.spans[0], Header) and len(chapter.spans)>1:
        print('first nonheader element: ', chapter.spans[1])
        while len(chapter.spans)>1 and isinstance(chapter.spans[1], (NewLine, NewLineSized)):
            print('remove newline from after header', chapter.spans[1])
            chapter.spans.pop(1)

    print('last element: ', chapter.spans[-1])
    cont = True
    while cont and isinstance(chapter.spans[-1], (NewLine, NewLineSized)):
        nl = chapter.spans[-1]
        print('remove newline from end', nl)

        if isinstance(nl, NewLine):
            # Remove, because NewLines aren't supposed to be here
            chapter.spans.pop(-1)
        if isinstance(nl, NewLineSized):
            if nl.height > 150:
                print('Leaving newline of height', nl)
                cont = False
            else:
                # clean small heights
                chapter.spans.pop(-1)


""" ============================
       Testing & Such
============================="""

def health_inspection(chapters):
    """
    Health inspection!
    """
    # Check for nones
    for i in range(len(chapters)):
        assert chapters[i] is not None, f"Chapter {i} is None."




def ensure_varnames_unique(chapters):
    # Ensure varname uniqueness
    print("Checking varname uniqueness")
    varnames = set()

    # Collect varnames
    for chapter in chapters:
        chapter.id = resolve_varname(chapter.id, varnames)
        varnames.add(chapter.id)
    return chapters

def resolve_varname(varname, varnames):
    if varname in varnames:
        # Add numbers
        i=2
        while True:
            try_var = varname+str(i)
            if try_var not in varnames:
                print("Renamed Chapter", varname, 'to', try_var)
                return try_var
            i+=1
    else:
        return varname

def collect_parts(chapters):
    """
    Mark which Part chapters are in, based on position
    """
    print("Collecting parts")

    lastPart = None

    # Collect parts
    for chapter in chapters:
        if chapter.part:
            id = pst.saveable_response("Enter part id "+ chapter.partName)
            id = int(id)
            chapter.partId = id
            lastPart = id
        else:
            if lastPart is None:
                # Probably the title
                lastPart = pst.saveable_response("Enter first part id")
                lastPart = int(lastPart)
            chapter.partId = lastPart
    return chapters


# ======= Utility ===========

def chapter_from_bookmark(bookmark, chapters):
    """
    Try escalating methods to match a bookmark,
        finally prompting the user
        to click through all of them
    """
    print("Matching next:", bookmark)
    bookmark = bookmark.strip()
    if len(bookmark)==0:
        assert False, "Empty chapter bookmark"
    if bookmark.lower() in ['none', 'null']:
        return None
    else:
        match = silent_match_chapter(bookmark, chapters)
        if match is not None:
            return match

        # Try headlines
        for chapter in chapters:
            if chapter.headline_text==bookmark:
                return chapter

        # Try bkmk substrings
        for chapter in chapters:
            for bkmk in chapter.bookmarks:
                if bkmk in bookmark:
                    r = pst.saveable_response(f'By "{bookmark}", did you mean: "{bkmk}"?')
                    if r=='y':
                        return chapter

        # Try substrings
        for chapter in chapters:
            if chapter.headline_text in bookmark:
                r = pst.saveable_response(f'By "{bookmark}", did you mean: "{chapter.headline_text}"?')
                if r=='y':
                    return chapter

        # Try substrings (vice versa)
        for chapter in chapters:
            if bookmark in chapter.headline_text:
                r = pst.saveable_response(f'By "{bookmark}", did you mean: "{chapter.headline_text}"?')
                if r=='y':
                    return chapter

        return manually_select_bookmark_match(bookmark, chapters)

def silent_match_chapter(bookmark, chapters):
    """
    Try first pass at getting chapter by exact
    """
    for chapter in chapters:
        if chapter.matches_bookmark(bookmark):
            return chapter
    return None


def manually_select_bookmark_match(bookmark, chapters):
    """
    Prompt user for bookmark match
    """
    print('Looking for:', bookmark)
    correction = None

    for i in range(len(chapters)):
        print(i, chapters[i].bookmarks)

    while correction is None:
        r = pst.saveable_response("Select", bookmark, 'id')
        if r=='x':
            exit(1)
        elif r=='p':
            for i in range(len(chapters)):
                print(i, chapters[i].bookmarkS)

        else:
            try:
                ix = int(r)
                if ix < len(chapters):
                    correction = chapters[ix].bookmark
                else:
                    print('Ix out of range:', ix, '/', len(chapters))
            except:
                correction = silent_match_chapter(r, chapters)
                if correct is None:
                    print("Not found.")

    # Give up
    raise ValueError(f"Bookmark: {bookmark} not found in chapter bookmarks")


def read_param(params, key):
    """
    Look for equals sign
    """
    for param in params:
        if param.startswith(key):
            value = param.replace(key, '')
            value = value.strip()
            if value.startswith('='):
                value = value[1:]
                value = value.strip()
            return value
    return None

def nextChapterStart(startFrom, spans):
    """
    """
    for i in range(startFrom, len(spans)):
        if isinstance(spans[i], ChapterStart):
            return i
    return None


""" ================================
         For Command Line
================================="""
def read_param_use_saved_responses():
    """ y = use_saved_responses
        n = no
        blank = prompt
    """
    if len(sys.argv)>1:
        if 'y' in sys.argv:
            return True
        if 'n' in sys.argv:
            return False
    return None

if __name__=="__main__":
    use_saved_responses = read_param_use_saved_responses()
    run_all(use_saved_responses=use_saved_responses)
