from objects import *
from objects.code_objects import *

import common.files as cf
from common.logger import *

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst
pst.DEBUG=False

pst.use_logger(print)
logger_start('chapter_breaker')


pst.click()
print('Have chapters changed?')
r= pst.response('y/n')
if r=='n':
    pst.USE_SAVED_RESPONSES=True
    pst.recall_saved_responses('data/chapterbreaker_responses')

import objects.custom_code as cc

spans, fonts = cf.read_spans_and_fonts('spans_coded.json', 'fonts_cleaned.json')
#Don't need fonts
del fonts

change_log_file('breaking')

chapters = []

def nextChapterStart(startFrom, spans):
    for i in range(startFrom, len(spans)):
        if isinstance(spans[i], ChapterStart):
            return i
    return None

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

change_log_file('keywords')
print('Resolving keywords')

def remove_invisible_headline(chapter):
    print("Removing InvisibleHeadline.")
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

user_inputted_bookmarks = {}

def silent_match_chapter(bookmark):
    if bookmark in user_inputted_bookmarks:
        return user_inputted_bookmarks[bookmark]
    # Try all bookmarks
    for chapter in chapters:
        if bookmark in chapter.bookmarks:
            return chapter
    return None


# Adds expanded searching
def chapter_from_bookmark(bookmark):
    print("Matching next:", bookmark)
    bookmark = bookmark.strip()
    if len(bookmark)==0:
        assert False, "Empty chapter bookmark"
    if bookmark.lower() in ['none', 'null']:
        return None
    else:
        match = silent_match_chapter(bookmark)
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
                    correction = silent_match_chapter(r)
                    if correct is None:
                        print("Not found.")

        # Give up
        raise ValueError(f"Bookmark: {bookmark} not found in chapter bookmarks")


print('Adding labels:')

for chapter in chapters:
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
                    r = pst.response(f'No params found on {obj} CodeTag: {span}. (Any to continue)')
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1

print("Misc Keywords")

for chapter in chapters:
    i=0
    while i < len(chapter.spans):
        span = chapter.spans[i]
        if isinstance(span, CodeKeywordTag):
            obj = span.obj
            if obj == 'InvisibleHeadline':
                chapter.spans.pop(i)
                i-=1
                rmvd = remove_invisible_headline(chapter)
                if rmvd is not None:
                    if rmvd < i:
                        i -= 1
                # Delete keyword
            if obj in ['Audio', 'UnskippableAudio', 'CopSting']:
                # TODO: Match audio to URL
                if obj == 'CopSting':
                    audio = 'copsting.wav'
                else:
                    audio = chapter.spans[i].params[0]

                # TODO: Check other params
                chapter.audio = audio
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
            if obj == 'EndOfBook':
                raise NotImplementedError('EndOfBook')
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1

print('Resolving keywords:')
for chapter in chapters:
    i=0
    while i < len(chapter.spans):
        if isinstance(chapter.spans[i], CodeKeywordTag):
            obj = chapter.spans[i].obj
            if obj == 'Next':
                nextBookmark = chapter.spans[i].params[0]
                print("Matching next:", nextBookmark)
                chapter.next = chapter_from_bookmark(nextBookmark)
                # Delete keyword
                chapter.spans.pop(i)
                i-=1
        i += 1

# All Keywords should be fixed
for chapter in chapters:
    i=0
    while i < len(chapter.spans):
        if isinstance(chapter.spans[i], CodeKeywordTag):
            obj = chapter.spans[i].obj
            print(chapter.spans[i])
            assert False, f'Unhandled Keyword: "{obj}"'
        i += 1


pst.print_and_save_responses('data/chapterbreaker_responses')

print('Saving files:')

for chapter in chapters:
    chapter.prepare_for_save()

import json
import jsonpickle

with open(f'temp/chapters.json', 'w') as f:
    str1 = jsonpickle.encode(chapters)
    f.write(str1)

print('Saved!')
