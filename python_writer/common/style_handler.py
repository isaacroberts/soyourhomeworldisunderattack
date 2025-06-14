import copy

import json
import jsonpickle

from objects.fonts import *
from objects.code_objects import CodeMarker
from objects.text_obj import *

import font_lookup as font_lookup

import common.files as cf

CODE_TAG_STYLE_NAME = 'code_5f_marker'

"""
    TODO: Rename StyleReader


"""



UNHANDLED = set()

class StyleHandler:
    """
        This is only really used by the XmlReader
    """
    def __init__(self):
        # {Tag: Font}
        self.fonts = {}
        # depend on parent fonts
        # {Tag: Font}
        self.sub_fonts = {}
        # {Tag: align (char)}
        self.aligns = {}
        # Allows for reparenting of identical fonts
        # {old_tag: new_tag}
        self.repl_dict = {}


    def read(self, style, is_sub_font=False):
        print(style['style:name'])
        print(style.attrs)
        # print(style.__dict__)

        def get_text_prop(style):
            for c in style.contents:
                if c.name=='text-properties':
                    return c
        def get_para_prop(style):
            for c in style.contents:
                if c.name=='paragraph-properties':
                    return c

        textprop = get_text_prop(style)
        paraprop = get_para_prop(style)
        # print(style.contents)
        name = style['style:name']
        source = style['style:family']
        # font = Font(tag=name, family=family)

        align = 'l'

        PID = 'style:parent-style-name'
        if PID in style.attrs:
            parent = style.attrs[PID]
            # font.parent = parent
        else:
            parent = None

        if name==CODE_TAG_STYLE_NAME:
            font = CodeMarker('#')
            if is_sub_font:
                self.sub_fonts[name] = font
            else:
                self.fonts[name] = font

            return font

        if is_sub_font:
            font = Font.zombie(name)
        else:
            if parent is None:
                if source == 'paragraph':
                    font = Font.body(name)
                else:
                    print('No parent: ', name)
                    font = Font(name, '', size=12)
            else:
                font = Font(name, '', size=12)
                # font = Font.null(name)
            # font.family = family
        font.parent = parent

        # if name == 'Heading':
        if 'Heading' in name:
            font.isHeading = True
        # if 'style:display-name' in style.attrs:
        #     font.set_display_name(style.attrs['style:display-name'])

        if paraprop is not None:
            if 'fo:text-align' in paraprop.attrs:
                odt_align = paraprop.attrs['fo:text-align']
                align = cf.convert_odt_align(odt_align)
                self.aligns[name] = align
                # font.set_align(align)
                print('Set align', align, paraprop)
            for att in paraprop.attrs:
                if att != 'fo:text-align':
                    UNHANDLED.add('(P)'+att)

        if textprop is None:
            pass
        else:
            print(textprop.attrs)
            other_tags = {'font-name': 'font-family'}

            for att in textprop.attrs:
                parts = att.split(':')
                category = parts[0]
                tag = parts[-1]

                # print(tag)
                if tag in WANTED_ATTRIBUTES:
                    value = textprop.attrs[att]
                    font.set_value(tag, value)
                    print('set', tag, value, font)
                elif tag in other_tags:
                    meaning = other_tags[tag]
                    value = textprop.attrs[att]
                    font.set_value(meaning, value)
                    print('set', tag, '('+meaning+')',value, font)
                else:
                    UNHANDLED.add(att)

        # Change Palatino Linotype -> Palatino
        if font.family == 'Palatino Linotype':
            font.family = 'Palatino'
        # TODO: This is caused by variadic font weights. I don't think it lines up one to one.
        if font.family.endswith('3') and not font.family == 'Z003':
            print('Remove font.family3')
            print(font)
            print(font.family)
            r = input('? y/n')
            if r=='y':
                font.family = font.family[:-1]
            else:
                pass
        assert font is not None
        if is_sub_font:
            self.sub_fonts[font.tag] = font
        else:
            self.fonts[font.tag] = font

        return font, align

    def get_font(self, tag):

        if tag in self.fonts:
            f= self.fonts[tag]
        else:
            if tag in self.sub_fonts:
                f= self.sub_fonts[tag]
            else:
                print("Font not found:", tag)
                exit(1)

        align = self.recursive_get_align(f)
        return f, align

    def recursive_fill_parent(self, child, parent):
        if parent.parent is not None:
            daddy = self.fonts[parent.parent]
            self.recursive_fill_parent(parent, daddy)
            parent.parent = None

        if parent.isCodeMarker():
            print(child.tag, '<#-', parent.tag)
            child= CodeMarker.from_font(child)
        else:
            print(child.tag, '<-', parent.tag)

        parent.fill_null(child)
        return child

    def fill_masters(self):
        """ Fills derived font attributes
            from their parent fonts.

            If a font's value is None, that means it extends the parent data
        """
        for font in self.fonts.values():
            if font.parent is not None:
                daddy = self.fonts[font.parent]
                font = self.recursive_fill_parent(font, daddy)
                self.fonts[font.tag] = font

        for font in self.sub_fonts.values():
            if font.parent is not None:
                assert font.parent in self.fonts
                daddy = self.fonts[font.parent]
                font = self.recursive_fill_parent(font, daddy)
                # Copy to parent
                font.isSub = False
                self.fonts[font.tag] = font

    def recursive_get_align(self, font):
        """
            Align was separated from fonts.
            This function mirrors the paradigm from fill_masters

        """
        # Check this font's align
        if font.tag in self.aligns:
            return self.aligns[font.tag]

        #Check parent align
        if font.parent is not None:
            daddy = self.fonts[font.parent]
            return self.recursive_get_align(daddy)

        # Default value
        return 'left'

    def fill_sub(self, subtag, parent):
        """
            Fills in inherited attributes from parent font.

            Subfonts are combinations with their parent
                - ie P32 adds italic+bold, which can sub Montserrat or Palatino

            'None' values are inherited from parent.
        """
        # If subtag missing
        if subtag not in self.sub_fonts:
            # Check main fonts
            if subtag in self.fonts:
                # Check align
                if subtag in self.aligns:
                    align = self.aligns[subtag]
                else:
                    print("(?)>\t Warning: style_handler.fill_sub assuming default align for "+subtag)
                    align = 'left'
                # Return found font
                return self.fonts[subtag], align
            assert False, f"Subfont not found: {subtag}"
        f = self.sub_fonts[subtag]

        if f is None:
            assert False, f"! None font. subtag: {subtag} parent: {parent}"
        if parent.isCodeMarker():
            f = CodeMarker.from_font(f)
        else:
            # Splices in parent tag
            f = f.copy(parent.tag)
        # Save new splice
        self.fonts[f.tag] = f
        parent.fill_null(f)

        align = self.recursive_get_align(f)
        return f, align


    def pick_best_name(tag1, tag2):
        """
        Decides which name to keep when merging fonts

        Returns true if the first one is best
        """
        def boolCmp(sb1, sb2):
            # If two disqualifiers are true
            if sb1==sb2:
                return None
            elif sb1:
                return False
            elif sb2:
                return True
            return None
        # We hate semicolons
        r = boolCmp(':' in tag1, ':' in tag2)
        if r is not None:
            return r
        # Avoid P124 and T242
        r = boolCmp(tag1[1].isnumeric(), tag2[1].isnumeric())
        if r is not None:
            return r
        # winner has shorter tag
        return len(tag1) > len(tag2)

    def find_and_delete_dupes(self):
        """
        Finds fonts with identical attributes.
        Saves the new font's location to repl_dict. {'old_tag': 'new_tag'}
        """

        v = self.fonts.values()
        v = list(v)
        # Purely diagnostic
        nJoins = 0
        i=0
        while i < len(v)-1:
            # Remove CodeTag / CodeMarkers
            if v[i].isCodeMarker():
                if v[i].tag != '#':
                    # Remove original
                    del self.fonts[v[i].tag]
                    v.pop(i)
                    i -= 1
            else:
                # Search all other fonts
                i2 = i+1
                while i2 < len(v):
                    # If fonts are equal
                    if v[i] == v[i2]:
                        f1 = v[i]
                        f2 = v[i2]
                        # Pick winning name
                        to_first = StyleHandler.pick_best_name(f1.tag, f2.tag)
                        nJoins += 1
                        if to_first:
                            # print(f2.tag, '->', f1.tag)
                            self.repl_dict[f2.tag] = f1.tag
                            # remove original
                            del self.fonts[f2.tag]
                            v.pop(i2)
                            i2 -= 1
                        else:
                            # print(f1.tag, '->', f2.tag)
                            self.repl_dict[f1.tag] = f2.tag
                            # remove original font
                            del self.fonts[f1.tag]
                            v.pop(i)
                            i -= 1
                            i2 -= 1
                            break
                    i2 += 1
            i += 1
        print('N Joins: ', nJoins)
        print(len(self.repl_dict.keys()), 'replacements')

    def replace_tag(self, tag):
        """
        Replaced tag with the tag that replaced it
        Returns the identical font's tag/key.
        """
        assert tag is not None
        assert self.is_tag_present(tag), f'Unrecognized tag {tag}'
        # Repl_dict can be multiple steps
        while tag in self.repl_dict:
            tag = self.repl_dict[tag]
            assert tag is not None
        return tag

    def _fix_name(name):
        """ Removes annoying or invalid symbols from font tag
        """
        # ODT Quirk
        name = name.replace('_20_', '_')
        # Tag splice separator
        name = name.replace(':', '_')
        return name

    def fix_names(self):
        """
        Removes invalid/annoying symbols from all fonts
        """
        newfonts = {}
        for key, font in self.fonts.items():
            tag = StyleHandler._fix_name(font.tag)
            if font.tag != tag:
                self.repl_dict[font.tag] = tag
            font.tag = tag
            newfonts[tag] = font
        self.fonts = newfonts

        for font in self.fonts.values():
            # print(font, type(font))
            if len(font.family)>2:
                if font.family[-1]=='1':
                    font.family = font.family[:-1]

    def replace_element_font(self, elem):
        """
            Checks & adds this element's font to font dict
        """
        if not hasattr(elem, 'font'):
            # print(elem, elem.codeMarker)
            return
        # print(elem, elem.font)
        if elem.font is None:
            return
        font = elem.font

        if font.isZombie():
            print("Zombie font:", font.tag)
            print('On:', elem)
            elem.font = '-'
        else:
            if font.isSub:
                # Font should be un-subbed by other function
                assert False, 'Font should not be sub anymore'
                print(font)
                print(elem)
                exit(1)

            tag = elem.font.tag
            print("orig tag", tag)
            tag = self.replace_tag(tag)
            assert self.is_tag_present(tag), "Unrecognized tag "+tag+ 'in elem '+str(elem)
            elem.font.tag = tag


    def replace_fonts(self, spans):
        """
        Brings in all fonts from span list
            Input: List<TextObj> spans
            Modifies span.font in place
        """
        for sp in spans:
            for elem in sp.elemWalker():
                if hasattr(elem, 'font'):
                    self.replace_element_font(elem)

    def is_tag_present(self, tag):
        if tag is None:
            return False
        elif tag == '#':
            return True
        elif tag == 'code_5f_marker':
            # Code tag
            return True
        elif tag in self.fonts:
            return True
        elif tag in self.sub_fonts:
            return True
        elif tag in self.repl_dict:
            return True
        # elif elem.font.isCodeMarker():
        #     return True
        else:
            return False
            # assert False, f'Font tag not found {tag} (step={step_name})'


    def assert_all_fonts_extant(self, spans, step_name=''):
        """
        Brings in all fonts from span list
            Input: List<TextObj> spans
            Modifies span.font in place
        """
        for sp in spans:
            for elem in sp.elemWalker():
                if elem.hasFont():
                    assert elem.font is not None, 'Element font is none. Elem=' + str(elem)
                    if isinstance(elem.font, str):
                        tag = elem.font
                    else:
                        tag = elem.font.tag

                    assert self.is_tag_present(tag), f'Font tag not found {tag} (step={step_name})'

    def convert_to_tags(self, spans):
        """
        To save space in json, replace font pointers with their corresponding tags.
        Inputs spans
        Modifies spans in-place for pickling
        """
        def funcWalker():
            for sp in spans:
                yield from sp.elemWalker()

        for sp in funcWalker():
            if sp.hasFont():
                tag = sp.font.tag
                assert self.is_tag_present(tag), 'Unrecognized font tag '+tag
                tag = self.replace_tag(tag)
                sp.font = tag

    def cleanup_dupes(self):
        """
        Cleans up after dupes have been deleted
        """
        # Reparent fonts to identical
        for font in self.fonts.values():
            if font.parent is not None:
                font.parent = self.replace_tag(font.parent)
        # Remove self-parenting
        for font in self.fonts.values():
            if font.parent == font.tag:
                font.parent = None
        self.repl_dict = None

    def find_files(self):
        """
        Find font .ttf files
        """
        for font in self.fonts.values():
            if isinstance(font, CodeMarker):
                print("Skipping CodeMarker")
            else:
                font.file = None
                file = font_lookup.find_font_file(font)
                if file == '-':
                    pkg = (font.family, font.italic)
                    print("MISSED A FILE!!!", 'Family:', font.family, 'Pkg:', pkg)
                font.file = file
                print(file)

    def write(self, file_name):
        """
        Pickle & write to json
        """
        # fonts = self.fonts | self.sub_fonts
        with open('temp/'+file_name, 'w') as f:
            strr = jsonpickle.encode(self.fonts)
            f.write(strr)

    def log(self):
        # print UNHANDLED to logfile
        pass
