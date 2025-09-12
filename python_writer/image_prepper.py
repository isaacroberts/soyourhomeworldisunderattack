from objects import *
from objects.code_objects import *

import common.files as cf
from common.logger import *

import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst
pst.DEBUG=False

import os
import numpy as np

from PIL import Image
from PIL.ExifTags import TAGS

from sklearn.cluster import KMeans

# dev
import matplotlib.pyplot as plt

"""
TODO: Cache these in a JSON file
"""

def prep_images_from_file(use_saved_responses=None, chapters_in='chapters.json',fonts_in='fonts_clean.json', chapters_out='chapters.json'):
    """
    Files in -> File out

    Handles splitting spans into chapters,
    programmatic keywords, bookmarks, links, etc
    """

    pst.use_logger(print)
    logger_start('chapter_breaker')
    change_log_file('breaking')

    chapters, fonts = cf.read_chapters_and_fonts(chapters_in, fonts_in)

    for chapter in chapters:
        prep_images_in_chapter(chapter)

    write(chapters, chapters_out)
    pst.end()

def open_image(url):
    if url is None:
        return None
    path = '../server/images/'+url

    if not os.path.exists(path):
        print("Missing image:", url)
        return None
    print('found image', url)
    image = Image.open(path)

    exifdata = image.getexif()
    for tag_id in exifdata:
        #TODO: Use other script to put author name in metadata
        # get the tag name, instead of human unreadable tag id
        tag = TAGS.get(tag_id, tag_id)
        data = exifdata.get(tag_id)
        # decode bytes
        if isinstance(data, bytes):
            data = data.decode()
        print(f"{tag:25}: {data}")
    # print ('Exif: ', exifdata)

    return image

def display_palette(colors):
    width=300
    palette = np.zeros((50, width, 3), np.uint8)
    steps = width/len(colors)
    for idx, centers in enumerate(colors):
        palette[:, int(idx*steps):(int((idx+1)*steps)), :] = centers
    return palette
def palette(clusters):
    colors = []
    for idx, centers in enumerate(clusters.cluster_centers_):
        colors.append(centers)
    return colors
def show_img_compare(img_1, img_2 ):
    f, ax = plt.subplots(1, 2, figsize=(10,10))
    ax[0].imshow(img_1)
    ax[1].imshow(img_2)
    ax[0].axis('off') #hide the axis
    ax[1].axis('off')
    f.tight_layout()
    plt.show()
def np_color_to_hex_str(color):
    color = (color).astype(int)
    # print('RGB:', color)
    hexi = color[0]*65536 + color[1] * 256 + color[2]
    hexs = str(hex(hexi))
    hexs = hexs[2:]
    # Pad R channel
    while len(hexs)<6:
        hexs = '0'+hexs
    return hexs
def get_color_hint(image):
    data = np.asarray(image)
    print('image shape:', data.shape)
    if data.shape[2]==4:
        data = data[:,:,:3]
    # Downsample x4
    data = data[::4, ::4, :]
    # Get 5 colors
    clt = KMeans(n_clusters=5)
    clt.fit(data.reshape(-1, 3))
    pal = palette(clt)
    pal = sorted(pal, key= lambda x: x.mean())
    # show_img_compare(data, display_palette(pal))
    # TODO: You could center around a preferred darkness
    pal = [pal[0], pal[1], pal[3]]
    # Only 3 / 5
    colors = [np_color_to_hex_str(p) for p in pal]

    print("ColorHint:", colors)
    return colors

def fill_span_info(span):
    assert (span.isCode())
    assert (span.obj == 'Image')

    url = span.params.main()
    image = open_image(url)

    if image is None:
        # Default colorHint is grey
        span.params.dparams['colorHint']=[]
    else:
        width = image.width
        height = image.height
        aspectRatio = width/height
        colorHint = get_color_hint(image)
        ars = str(aspectRatio);
        # Max precision: 0.333333
        ars = ars[:8]
        span.params.dparams['w']=width
        span.params.dparams['h']=height
        span.params.dparams['aspectRatio']=ars
        span.params.dparams['colorHint']=colorHint
        print('Params:=', span.params)


def prep_images_in_chapter(chapter):
    for span in chapter.spans:
        if span.isCode():
            if span.obj == 'Image':
                fill_span_info(span)


def write(chapters, filename='chapters.json'):
    """
    TODO: Move to common file
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

if __name__=="__main__":
    #TODO: Common
    # use_saved_responses = read_param_use_saved_responses()
    use_saved_responses=False
    prep_images_from_file(use_saved_responses=use_saved_responses)
