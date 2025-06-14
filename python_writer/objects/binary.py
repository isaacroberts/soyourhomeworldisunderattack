import numpy as np
import struct



class BinList:
    def __init__(self, src):
        # self.list = []
        self.bstr = b''
        # For debugging purposes
        self.src = src

    def __repr__(self):
        return str(self)

    def __str__(self):
        if len(self.bstr)>=20:
            return f"Bin('{self.src}')[{self.bstr[:15]}...(l={len(self.bstr)})]"
        else:
            return f"Bin('{self.src}')[{self.bstr}]"

    def get_binary(self):
        return self.bstr

    def add(self, *items):
        print('Recursively adding *', items)
        for item in items:
            print(' >', item)
            self.append(item)
        return self

    def add_list(self, items):
        print('Recursively adding', items)
        for item in items:
            print(' >', item)
            self.append(item)
        return self

    def pack_span_list(self, b2):
        # [ length_to_close_sqr . spans ]
        self.add_list(['[', pack_untyped_uint(len(b2) ), '.', b2, ']'])

    def pack_sub_binary(self, b2):
        # { length_to_close_brace . binary }
        self.add_list(['{', pack_untyped_uint(len(b2)), '.', b2, '}'])

    def append(self, x):
        if x is None:
            pass
        elif isinstance(x, BinList):
            self.bstr += x.bstr
        elif isinstance(x, (bytes, bytearray)):
            self.bstr += x
        elif isinstance(x, (list, tuple)):
            # print('X is list:', x, type(x))
            self.add_list(x)
        elif isinstance(x, str):
            # print('Add str to binary:', x)
            self.bstr += pack_literal(x)
        else:
            print('Non bytes X', x, type(x))
            assert False

    def __iadd__(self, x):
        self.append(x)
        return self

    def __len__(self):
        return len(self.bstr)



def pack_none():
    return 'x'.encode('ascii')


"""
-- struct values --
? = bool
B = short unsigned int
i = int
I = unsigned int
q = long int
Q = unsigned long long
f = float
c = char
x = none

-- custom --
{ = string
K = key (4s)
H = hex = BBBB

"""

def pack_value(num):
    if num is None:
        return pack_none()

    if isinstance(num, bool):
        typechar = '?'
        packed = struct.pack('!?', num)
    if isinstance(num, int):
        #'!' ensures that it's in network byte order (big-endian)
        # the 'f' says that it should be packed as a float.
        # Alternatively, for double-precision, you could use 'd'.

        if num >=0 and num < 128:
            # Can remove leading zeros here
            typechar = 'B'
            packed = struct.pack('!B', num)
            # print(len(packed))
            # print(type(packed))
            assert(len(packed)==1)
            # packed = (packed[-1])
            # while packed[0]==0:
            #     packed = packed[1:]
        elif -2147483648 <= num and num <= 2147483647:
            typechar = 'i'
            packed = struct.pack('!i', num)
            assert len(packed)==4
        else:
            # If this fails, your number is bigger than 2**63-1 and you are going to jail
            typechar = 'q'
            packed = struct.pack('!q', num)
            assert len(packed)==8

    elif isinstance(num, float):
        typechar = 'f'
        packed = struct.pack('!f', num)
    elif isinstance(num, str):
        # in theory wtf_token_checker is needed for arbitrary books
        # however, I am certain that i have not used these tokens in my book
        # If your book uses a lot of {} for some reason, you should manually change the token
        # num = wtf_token_checker(num, '@OQ!')
        # num = wtf_token_checker(num, '@CQ!')
        num = num.replace('{', "@OQ!")
        num = num.replace('}', "@CQ!")
        num = '{' + num + '}'
        num = num.encode('utf-8')
        if len(num)==3:
            # TODO: Check if char is utf-8 or ascii; if utf-8, consider replacing with str
            num = chr(num[1]).encode('utf-8')
            packed = struct.pack('!c', num)
            assert(len(packed)==1)
            typechar = 'c'
        else:
            l = len(num)
            packed = struct.pack(f'!{l}s', num)
            typechar = ''
    else:
        assert False, f'Unrecognized type in pack_value {type(num)}'
    packed = typechar.encode('ascii') + packed
    return packed

def pack_int(num):
    if num is None:
        return pack_none()

    if isinstance(num, bool):
        num = 1 if num else 0
    if isinstance(num, int):
        # already in format
        pass
    elif isinstance(num, float):
        num = int(np.round(num))
    elif isinstance(num, str):
        if '.' in num:
            num = float(num)
            num = int(np.round(num))
        else:
            num = int(num)
    else:
        try:
            num = int(num)
        except:
            assert False, f'Passed non-number {type(num)} to pack_int'

    if num >=0 and num < 128:
        # Can remove leading zeros here
        packed = struct.pack('!B', num)
        assert(len(packed)==1)
        typechar = 'B'
    elif -2147483648 <= num and num <= 2147483647:
        packed = struct.pack('!i', num)
        assert len(packed)==4
        typechar = 'i'
    else:
        # If this fails, your number is bigger than 2**63-1 and you are going to jail
        packed = struct.pack('!q', num)
        assert len(packed)==8
        typechar = 'q'

    packed = typechar.encode('ascii') + packed
    return packed


def pack_short_int(num):
    if num is None:
        return pack_none()
    if isinstance(num, bool):
        num = 1 if num else 0
    if isinstance(num, int):
        pass
    elif isinstance(num, float):
        num = int(np.round(num))
    elif isinstance(num, str):
        if '.' in num:
            num = float(num)
            num = int(np.round(num))
    else:
        try:
            num = int(num)
        except:
            assert False, f'Passed non-number {type(num)} to pack_short_int'

    if num >=0 and num < 128:
        # Can remove leading zeros here
        packed = struct.pack('!B', num)
        assert(len(packed)==1)
    else:
        assert False, 'Number too large for pack_short_int'

    typechar = 'B'
    packed = typechar.encode('ascii') + packed
    return packed


def pack_typed_uint(num):
    if num is None:
        return pack_none()
    if isinstance(num, int):
        pass
    else:
        try:
            num = int(num)
        except:
            assert False, f'Passed non-number {type(num)} to pack_unsigned_int'

    assert num >= 0, f'Pack_uint needs positive number (got {num})'

    packed = struct.pack('!I', num)
    assert(len(packed)==4)

    typechar = 'I'
    packed = typechar.encode('ascii') + packed
    # print(packed)
    return packed


def pack_hex(hexin):
    if hexin is None or hexin=='transparent':
        return pack_none()
    if isinstance(hexin, int):
        pass
    elif isinstance(hexin, str):
        if hexin.startswith('0x'):
            hexin = hexin[2:]
        elif hexin.startswith('#'):
            hexin = hexin[1:]
        assert len(hexin)==6 or len(hexin)==8, 'Color hex string must be length 6 or 8'
        hexin = int(hexin, 16)
    else:
        try:
            hexin = int(hexin, 16)
        except:
            assert False, f'Passed non-number {type(hexin)} to pack_int'

    assert hexin >= 0, "Hex must be positive"
    assert hexin <= 0xffffffff, 'Hex must be less than 0xff,ffffff'

    # 'H' ARGB:BBBB
    alpha = (hexin & 0xff000000) >> (6 * 4)
    r = (hexin & 0xff0000) >> (4 * 4)
    g = (hexin & 0x00ff00) >> (2 * 4)
    b = hexin & 0x0000ff

    # alpha=0 comes from not using the variable
    # Desired full transparency should use InvisiText
    if alpha == 0:
        alpha = 255

    packed = struct.pack('!BBBB', alpha, r, g, b)

    typechar = 'H'
    packed = typechar.encode('ascii') + packed
    return packed

def pack_float(num):
    if num is None:
        packed = struct.pack('!x')
        typechar = 'x'
    else:
        if isinstance(num, bool):
            print("!! Warning: Passed bool to pack_float")
            num = 1.0 if num else 0.0
        if isinstance(num, int):
            num = float(num)
        elif isinstance(num, float):
            pass
        elif isinstance(num, str):
            try:
                num = float(num)
            except:
                assert False, f'Passed string {num} to pack_float'
        else:
            assert False, f'Passed non-number {type(num)} to pack_float'

        packed = struct.pack('!f', num)
        typechar = 'f'

    packed = typechar.encode('ascii') + packed
    return packed

# Strings - UTF8
def pack_text(text):
    if text is None:
        text = ''
    if isinstance(text, str):
        pass
    elif isinstance(text, bool):
        print("!! Warning: bool passed to pack_text")
        text = 'TRUE' if text else 'FALSE'
    else:
        try:
            text = str(text)
        except:
            assert False, f'Passed non-text {type(text)} to pack_text'

    text = text.replace('{', "@OQ!")
    text = text.replace('}', "@CQ!")
    text = '{' + text + '}'
    text = text.encode('utf-8')
    return text

def pack_url(text):
    if text is None:
        return
    if isinstance(text, str):
        pass


    #TODO:
    # import urllib.parse
    # >>> query = 'Hellö Wörld@Python'
    # >>> urllib.parse.quote_plus(query)
    # 'Hell%C3%B6+W%C3%B6rld%40Python'

    text = '[' + text + ']'
    text = text.encode('ascii')

    l = len(text)
    packed = struct.pack(f'!{l}s', text)
    return packed

# String literals - ASCII only
def pack_literal(text):
    if text is None:
        return
    if isinstance(text, str):
        pass
    elif isinstance(text, int):
        text = str(text)
    elif isinstance(text, bool):
        text = '1' if text else '0'
    else:
        try:
            text = str(text)
        except:
            assert False, f'Passed non-text {type(text)} to pack_literals'

    text = text.encode('ascii')
    l = len(text)
    packed = struct.pack(f'!{l}s', text)
    return packed

# Ascii only, variable only
def pack_key(text):
    if text is None:
        assert False, 'Passed None key to pack_key'

    if isinstance(text, str):
        pass
    else:
        assert False, f'Passed non-text {type(text)} to pack_key'

    for c in '[({})];:,.<>"\'\n\0':
        assert c not in text, f"Character '{c}' cannot be in key!"

    # TODO: Don't use apostrophes.
    text = f"'{text}'"
    text = text.encode('ascii')
    return text

# One single character - typed
def pack_char(text):
    typechar = 'c'
    if text is None:
        packed = struct.pack('!x')
        typechar = 'x'
    else:
        if isinstance(text, str):
            assert len(text)==1, f'String must be length 1, not {len(text)} ("{text}")'

        elif isinstance(text, int):
            try:
                text = str(text)
                assert len(text)==1, f'Int converted to string must be length 1,  ("{text}")'
            except:
                assert False, f'Passed int {text} to pack_char'
        elif isinstance(text, bool):
            print("!! Warning: bool passed to pack_char")
            text = 't' if text else 'f'
        else:
            assert False, f'Passed non-string {type(text)} to pack_char'

        text = text.encode('ascii')
        packed = struct.pack(f'!c', text)
        typechar = 'c'

    packed = typechar.encode('ascii') + packed
    return packed

"""
===================== Untyped ====================================
Not stored as [type, value], but instead as [value]. Unpacker must know type
"""
def pack_untyped_uint(num):
    if num is None:
        assert False
    if isinstance(num, int):
        pass
    else:
        try:
            num = int(num)
        except:
            assert False, f'Passed non-number {type(num)} to pack_untyped_uint'

    assert num >= 0, f'Pack_untyped_uint needs positive number (got {num})'

    packed = struct.pack('!I', num)
    assert(len(packed)==4)

    return packed


def pack_untyped_short(num):
    if num is None:
        assert False

    if isinstance(num, bool):
        assert False
    if isinstance(num, int):
        pass
    elif isinstance(num, float):
        num = int(np.round(num))
    elif isinstance(num, str):
        if '.' in num:
            num = float(num)
            num = int(np.round(num))
    else:
        try:
            num = int(num)
        except:
            assert False, f'Passed non-number {type(num)} to pack_short_int'

    if num >=0 and num < 128:
        # Can remove leading zeros here
        packed = struct.pack('!B', num)
        assert(len(packed)==1)
    else:
        assert False, 'Number too large for pack_short_int'

    return packed

def pack_untyped_float(num):
    if num is None:
        assert False
    else:
        if isinstance(num, bool):
            assert False
            print("!! Warning: Passed bool to pack_float")
            num = 1.0 if num else 0.0
        if isinstance(num, int):
            num = float(num)
        elif isinstance(num, float):
            pass
        elif isinstance(num, str):
            try:
                num = float(num)
            except:
                assert False, f'Passed string {num} to pack_float'
        else:
            assert False, f'Passed non-number {type(num)} to pack_float'

    packed = struct.pack('!f', num)
    assert len(packed)==4
    return packed

def pack_untyped_char(text):
    if text is None:
        assert False
    else:
        if isinstance(text, str):
            assert len(text)==1, f'String must be length 1, not {len(text)} ("{text}")'
        else:
            assert False, f'Passed non-string {type(text)} to pack_char'

    text = text.encode('ascii')
    packed = struct.pack(f'!c', text)
    return packed

"""
======================= Unpacker ===================================
"""


def unpack_value(bin):
    typechar = bin[0]
    typechar = chr(typechar)

    if typechar in 'Biq':
        if typechar == 'B':
            num_digits = 1
        elif typechar=='i':
            num_digits = 4
        elif typechar == 'I':
            num_digits = 4
        elif typechar == 'q':
            num_digits = 8
        value = bin[1:1+num_digits]
        value = struct.unpack('!'+dec_char, value)
        return value[0]
    elif typechar == 'f':
        num_digits=4
        value = bin[1:1+num_digits]
        value = struct.unpack('!f', value)
        return value[0]
    elif typechar == '{':
        lq = 0
        rq = None
        for i in range(lq+1, len(bin)):
            if bin[i] == ord('}'):
                rq = i
                break
        if rq is None:
            assert False, 'No end brace } in string '+str(bin)+ '(2)'
        value = bin[lq+1:rq]
        l = rq - lq-1
        value = struct.unpack(f'!{l}s', value)
        value = value[0].decode()
        value = value.replace('@OQ!', '{')
        value = value.replace('@CQ!', '}')
        return value
    elif typechar == 'c':
        value = chr(bin[1])
        return value
    elif typechar=='K':
        value = bin[1:5]
        value = value.decode('ascii')
        return value
    elif typechar == 'H':
        # a,r,g,b = struct.unpack('!BBBB', bin[1:5])
        # hexx = a * 2**24 + r * 2**16 + g * 2**8 + b * 2**0
        hexx = struct.unpack('!I', bin[1:5])[0]
        return hexx


if __name__=="__main__":
    # Testing functions

    # Prints input, funcname, output
    def print_both(func, input):
        print('('+type(input).__name__+')', input,':')
        try:
            ret = func(input)
            print('\t', ret)
            try:
                ret_plus_garbage = ret + b'({cj93w}jm();d'
                value = unpack_value(ret_plus_garbage)

                if unpack_value(ret) != value:
                    print('\t HARD FAILED. Unpack with extra must match')

                if type(input) != type(value):
                    print('\t Type MM:', '('+type(value).__name__+')',value)
                else:
                    matches = input == value
                    if isinstance(value, float):
                        matches = (input-value)/(input+value) < 1e-5
                    if matches:
                        print('\t Match')
                    else:
                        print('\t NOMATCH:', '('+type(value).__name__+')',value)
            except Exception as e:
                print('\t', 'Unpack failed.', e)
        except Exception as e:
            print('\t', 'FAILED.', e)
        print()

    # Text separator
    def herald(name):
        print()
        print()
        print('------------------------',name,'----------------------------')
        print()
        # print()

    # pack_value
    herald('General')

    print_both(pack_value,None)

    print_both(pack_value,45)
    print_both(pack_value,-45)
    print_both(pack_value,0)
    print_both(pack_value,-3)

    print_both(pack_value,438373945)
    print_both(pack_value,-438373945)

    print_both(pack_value,438358373739473945)
    print_both(pack_value,-438358373739473945)

    print_both(pack_value,4383583733837473739473945)
    print_both(pack_value,-43835837373271873739473945)

    print_both(pack_value, np.pi)

    print_both(pack_value,.45)
    print_both(pack_value,4.5)
    print_both(pack_value,('45'))
    print_both(pack_value,('4.5'))

    print_both(pack_value,('4{5}'))
    print_both(pack_value,('4.5'))

    print_both(pack_value,('4'))
    print_both(pack_value,('ת'))
    print_both(pack_value,('aתbc'))

    print_both(pack_value,(45, '4{5}'))
    print_both(pack_value,('4.5'))

    herald('Int')

    print_both(pack_int, None)

    print_both(pack_int,45)
    print_both(pack_int,-45)
    print_both(pack_int,0)
    print_both(pack_int,-3)
    print_both(pack_int,438373945)
    print_both(pack_int,-438373945)
    print_both(pack_int,438358373739473945)
    print_both(pack_int, -438358373739473945)
    print_both(pack_int, .45)
    print_both(pack_int, 4.5)
    print_both(pack_int, 4.7)

    print_both(pack_int, ('45'))

    print_both(pack_int, ('4.5'))
    print_both(pack_int, ('4.6'))
    print_both(pack_int, ('4'))

    print_both(pack_int, ('-4.65'))
    print_both(pack_int, ('-4.45'))


    print_both(pack_int, np.pi)


    herald('Short Int')

    print_both(pack_short_int, None)

    print_both(pack_short_int,45)
    print_both(pack_short_int,-45)
    print_both(pack_short_int,0)
    print_both(pack_short_int,-3)
    print_both(pack_short_int,438373945)
    print_both(pack_short_int,-438373945)
    print_both(pack_short_int,438358373739473945)
    print_both(pack_short_int, -438358373739473945)
    print_both(pack_short_int, .45)
    print_both(pack_short_int, 4.5)
    print_both(pack_short_int, 4.6)

    print_both(pack_short_int, ('45'))
    print_both(pack_short_int, ('4.5'))
    print_both(pack_short_int, ('4.7'))
    print_both(pack_short_int, ('4'))

    print_both(pack_short_int, np.pi)


    herald('Hex')

    print_both(pack_hex, None)

    print_both(pack_hex,0xffaabb)
    print_both(pack_hex,0xffffaabb)
    print_both(pack_hex,0xffaabbc)
    print_both(pack_hex,0xffffaabbc)

    print_both(pack_hex,'ffaabb')
    print_both(pack_hex,'ffffaabb')

    print_both(pack_hex,'0xffaabb')
    print_both(pack_hex,'0xffffaabb')

    print_both(pack_hex,'#ffaabb')
    print_both(pack_hex,'#ffffaabb')

    print_both(pack_hex,'0xffaabbc')

    print_both(pack_hex,45)
    print_both(pack_hex, ('45'))
    print_both(pack_hex,-45)
    print_both(pack_hex,0)
    print_both(pack_hex,-3)
    print_both(pack_hex,438373945)
    print_both(pack_hex,-438373945)
    print_both(pack_hex,438358373739473945)
    print_both(pack_hex, -438358373739473945)

    print_both(pack_hex, np.pi)

    herald('Float')

    print_both(pack_float, None)

    print_both(pack_float, 45)
    print_both(pack_float, -45)
    print_both(pack_float, 0)
    print_both(pack_float, -3)
    print_both(pack_float, 438373945)
    print_both(pack_float, -438373945)
    print_both(pack_float, 438358373739473945)
    print_both(pack_float, '438358373739473945')
    print_both(pack_float, -438358373739473945)
    print_both(pack_float, '-438358373739473945')

    print_both(pack_float, 438358373.739473945)
    print_both(pack_float, '438358373.739473945')

    print_both(pack_float, .45)
    print_both(pack_float, 4.5)
    print_both(pack_float, ('45'))
    print_both(pack_float, ('4.5'))
    print_both(pack_float, ('4.5'))
    print_both(pack_float, ('4'))

    print_both(pack_float,np.pi)

    herald('Text')

    print_both(pack_text, None)
    print_both(pack_text, '')


    print_both(pack_text, 45)
    print_both(pack_text, -45)
    print_both(pack_text, 0)
    print_both(pack_text, -3)

    print_both(pack_text, 438373945)
    print_both(pack_text, -438373945)

    print_both(pack_text, 438358373739473945)
    print_both(pack_text, -438358373739473945)

    print_both(pack_text, 4383583733837473739473945)
    print_both(pack_text, -43835837373271873739473945)

    print_both(pack_text, .45)
    print_both(pack_text, 4.5)
    print_both(pack_text, ('45'))
    print_both(pack_text, ('4.5'))

    print_both(pack_text, ('4{5}'))
    print_both(pack_text, ('4.5'))

    print_both(pack_text, ('4'))
    print_both(pack_text, ('ת'))
    print_both(pack_text, ('aתbc'))

    print_both(pack_text, ((45, '4{5}')))
    print_both(pack_text, ('4.5'))

    print_both(pack_text,np.pi)

    herald("Char")

    print_both(pack_char, None)

    print_both(pack_char, 0)
    print_both(pack_char, -3)

    print_both(pack_char, .45)
    print_both(pack_char, 4.5)
    print_both(pack_char, ('b'))
    print_both(pack_char, ('4'))
    print_both(pack_char, ('5'))
    print_both(pack_char, ('l'))


    print_both(pack_char, ('4'))
    print_both(pack_char, ('ת'))
    print_both(pack_char, ('aתbc'))

    print_both(pack_char, ((45, '4{5}')))
    print_both(pack_char, ('4.5'))

    print_both(pack_char,np.pi)

    herald('Key')

    print_both(pack_key, 1)

    print_both(pack_key, '45')
    print_both(pack_key, '4.5')

    print_both(pack_key, '4{5}')
    print_both(pack_key, '4.5')

    print_both(pack_key, 'abcdef')
    print_both(pack_key, 'abcd')

    print_both(pack_key, 'abc')
    print_both(pack_key, 'ת')
    print_both(pack_key, 'aתbc')

    print_both(pack_key, 'depp')
    print_both(pack_key, '4.5')
