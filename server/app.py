from flask import Flask
from flask import request
from flask import render_template
from flask import send_file, send_from_directory

from flask_json import FlaskJSON, JsonError, json_response, as_json
from flask_cors import CORS

from werkzeug.exceptions import HTTPException
import logging

import json

ON_SERVER = True

app = Flask(__name__, template_folder='web')
FlaskJSON(app)

def _build_cors_preflight_response():
    print('+ Cors preflight')
    response = make_response()
    response.headers.add("Access-Control-Allow-Origin", "*")
    response.headers.add("Access-Control-Allow-Headers", "*")
    response.headers.add("Access-Control-Allow-Methods", "*")
    return response


CORS(app, resources={r"*":
    {"origins": "*",
# "Access-Control-Allow-Origin": "*",
# "Access-Control-Allow-Methods": "GET,PUT,PATCH,POST,DELETE",
#   "Access-Control-Allow-Headers": "Content-Type, Authorization",
}})

log = logging.getLogger('werkzeug')
log.setLevel(logging.ERROR)

from server import font_library

print('-')
fonts = font_library.FontLibrary()

from server import feedback

feedback_db = feedback.FeedbackDatabase()
import os
print('CWD: ', os.getcwd())
# print('LS:')
# for root, directories, files in os.walk(os.getcwd()):
#     print(root)


print('--')
FLUTTER_WEB_APP = 'web'

@app.route('/', methods=['GET', 'POST'])
def mainRoute():
    # print('send home')
    return send_from_directory('web', 'index.html')
    # return render_template('index.html')

@app.route('/web/')
def render_page_web():
    # print('send (web)')
    return send_from_directory('web', 'index.html')
    # return render_template('index.html', template_folder='web')

@app.route('/web/<path:name>', methods=['GET', 'POST'])
def return_flutter_doc(name):

    datalist = str(name).split('/')
    dir_name = FLUTTER_WEB_APP

    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            dir_name += '/' + datalist[i]
    print('sending', dir_name,'/', datalist[-1])
    return send_from_directory(dir_name, datalist[-1])

# @CORS.cross_origin()
@app.route('/book_binary/<path:name>', methods=['GET', 'POST', 'OPTIONS'])
def return_book_binary(name):
    # if request.method == 'OPTIONS':
    #     return _build_cors_preflight_response()

    # print("Grabbing book")
    datalist = str(name).split('/')
    dir_name = 'book_binary'
    # print('list:', datalist)
    if len(datalist) > 1:
        for i in range(0, len(datalist) - 1):
            dir_name += '/' + datalist[i]
    print('sending', dir_name,'/', datalist[-1])
    s = send_from_directory(dir_name, datalist[-1])
    # print('Sending ', s)
    return s

@app.errorhandler(HTTPException)
def handle_exception(e):
    """Return JSON instead of HTML for HTTP errors."""
    # start with the correct headers and status code from the error
    response = e.get_response()
    # replace the body with JSON
    response.data = json.dumps({
        "code": e.code,
        "name": e.name,
        "description": e.description,
    })
    print('e=', e)
    print('respnose=', response)
    print("Client recieved Exception:", response.data)
    response.content_type = "application/json"
    return response

# app name
@app.errorhandler(404)
# inbuilt function which takes error as parameter
def not_found(e):
    response = e.get_response()
    # replace the body with JSON
    response.data = json.dumps({
        "code": e.code,
        "name": e.name,
        "description": e.description,
        "path": request.url,
    })
    print('404: e=', e)
    # print('respnose=', response)
    print("Client recieved Exception:", response.data)
    response.content_type = "application/json"
    return response

@app.route('/font_info/<int:id>', methods=['GET'])
def get_font_info(id):
    # print('Font info:',id, '(GET)')
    return fonts.get_id(id)

@app.route('/font_post_info/', methods=['POST'])
def get_font_info_post():
    data = request.get_json(force=True)
    id = data['id']
    # print('Font info:', id)
    return fonts.get_id(id)

#TODO: Now it needs to serve the font files
@app.route('/font/<string:url>', methods=['GET'])
def get_font(url):
    # print('Font serve:', url)
    fname = url.split('/')[-1]
    # print('Font:', fname)
    try:
        # print('sending', fname)
        return send_from_directory('fonts', fname)
        # return send_file(f'/fonts/{url}',
        #     mimetype='font/ttf',
        #     attachment_name = fname)
    except FileNotFoundError as e:
        return json_response(error=str(e), status_code=404)

@app.route('/submit_feedback/', methods=['POST'])
def submit_feedback():
    data = request.get_json(force=True)
    chapter=data['chapter']
    line = data['line']
    feedback=data['feedback']
    feedback_db.add_obj(feedback)
    return json_response()

@app.route('/show_feedback/', methods=['POST'])
def show_feedback():
    data = request.get_json(force=True)
    start=data['start']
    amt = data['amt']
    rows = feedback_db.get_range(start, amt)
    rows = rows.to_json()
    return json_response(feedback=rows)


if __name__=="__main__":

    ON_SERVER = False 
    app.debug = True
    print("go to http://localhost:5000/ to view the page.")
    app.run()    # app.run() #go to http://localhost:5000/ to view the page.
