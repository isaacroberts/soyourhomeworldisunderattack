
import sys
sys.path.append("/home/titzak/scripts/")
import python_script_tools as pst
pst.DEBUG=True

import subprocess
import shutil
import os
import argparse


curdir = os.getcwd()
if curdir != "/home/titzak/Documents/McKinsey Plan/soyourhomeworldisunderattack/python_writer":
    print("You must be in python_writer directory!")
    print('You are in', os.getcwd())
    exit(1)
subprocess.run(f'cd "{curdir}"', shell=True)
parser = argparse.ArgumentParser(description='Convert multiple LibreOffice books into one continuous scroll (flutter binary).')


parser.add_argument('--i', metavar='inputs', type=argparse.FileType('r', encoding='latin-1'), nargs='+',
                    help='Names for the greeting')
args = parser.parse_args()

print(args)

files = args.i

def unzip_odt(odt):

    print('Unzipping ', filename)
    file = odt.split('/')[-1]
    print(f'Copying "{odt}" to "temp/{file}"')
    shutil.copy(odt, 'temp/'+file)
    odt = 'temp/'+file

    output = os.path.splitext(odt)[0]

    # Delete old output
    if os.path.exists(output):
        shutil.rmtree(output)
    # Make sure new path exists
    os.makedirs(output, exist_ok=True)

    # Unzip BookTitle.odt
    subprocess.run(f'unzip "{odt}" -d "{output}"', shell=True, check=True)
    print("Unzipped", output)

for f in files:
    filename = f.name
    unzip_odt(filename)

    # unzip_odt.sh filename
    fobj = open(f.name, 'r')
    data = fobj.read()
    exists = os.odt.exists(f.name)
    print('File: ', f.name, 'exists:', exists)
    print('Data:', data, f'({len(data)})')
