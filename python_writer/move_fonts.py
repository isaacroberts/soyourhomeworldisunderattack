import os
import sys
import shutil
import pandas as pd

target_folder = '../hosted_fonts/'

font_file_df = pd.read_csv('temp/font_files.csv', index_col=0)
print(font_file_df)
"""

if not os.path.exists(target_folder):
os.mkdir(target_folder)
for ix, row in font_file_df.iterrows():
    # print(row)
    path = row['path']
    fname = row['file']

    target = os.path.join(target_folder, fname)
    if not os.path.exists(target):
        shutil.copy(path, target)
"""
# Don't need the path anymore
font_file_df = font_file_df.drop(columns=['path'])

font_file_df.to_csv('../server/font_files.csv', index=True)
