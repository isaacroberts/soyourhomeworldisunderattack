import pandas as pd
from flask_json import FlaskJSON, JsonError, json_response, as_json


class FontLibrary:
    def __init__(self):
        self.df = pd.read_csv('fonts/font_files.csv', index_col=0)
        # Might've been removed by earlier script
        if 'path' in self.df.columns:
            # Don't need the path, since it's already been moved
            self.df = self.df.drop(columns=['path'])
        print(self.df)

    def get_id(self, id):
        if id not in self.df.index:
            print('Missing font:', id)
            return json_response(error='Font not found', status_code=404)
        else:
            data = self.df.loc[id]
            file = data['file']
            # print('file:', file, type(file))
            if isinstance(file, str):
                file = [file]
            elif isinstance(file, pd.Series):
                file = file.to_list()
            else:
                print('Unknown font.file type', type(file),":",'"', file,'"')
                file = [str(file)]

            family = data['family']
            if isinstance(family, pd.Series):
                family = family.to_list()
            if isinstance(family, list):
                if len(family)>0:
                    family = family[0]
                else:
                    family = '_err_'
            if not isinstance(family, str):
                family = str(family)

            dic = {'id': id, 'family': family, 'file':file}
            # print('Returning FontInfo:"',dic, "'")
            return dic
