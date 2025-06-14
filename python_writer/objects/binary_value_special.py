import numpy as np
import struct

from objects.binary import *


def pack_null_wousi():
    return struct.pack('!i', 0)

def unpack_wousi(value):
    if value==0:
        return (500, False, False, False, False)


def pack_wousi(weight, overline, underline, strikethrough, italic):
    """
    WOUSI = Weight Overline Underline Strikethrough Italics

    """
    # print(weight)

    if weight == 0:
        out = 0
        print('\t\t\t\t\t', out, '(w=0)')
    else:
        weight = int(weight)
        weight = weight // 100
        weight = weight & 15

        bits = [weight & 0b1000, weight & 0b100, weight & 0b10, weight & 0b1, overline, underline, strikethrough, italic]

        bits = [bool(b) for b in bits]

        out = 0
        for bit in bits:
            out = (out << 1) | bit

        print('\t\t\t\t\t=', out, '\t', [int(b) for b in bits])

    bin = struct.pack('!i', out)
    return out
    # print(bin)

if __name__=="__main__":
    # pack_wousi(900, False, True, False, True)

    values = set()
    n_times = 0
    values.add(pack_wousi(0, 0,0,0,0))
    for w in range(1, 10):
        weight = w * 100
        print('Weight', weight)
        for ov in [True, False]:
            print('\t', 'Overline' if ov else 'No Overline')
            for un in [True, False]:
                print('\t\t', 'Underline' if un else 'No Underline')
                for st in [True, False]:
                    print('\t\t\t', 'Strikethru' if ov else 'No Strikthru')
                    for it in [True, False]:
                        print('\t\t\t\t', 'Italic' if ov else 'Straight')
                        bit = pack_wousi(weight, ov, un, st, it)
                        # print(bit // 16)
                        assert bit not in values
                        values.add(bit)
                        n_times += 1
    print('Wousis:')
    print(values)
    print(n_times, 'inputs')
    print(len(values), 'valid values')
    print()
