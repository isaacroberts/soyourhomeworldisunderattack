from __future__ import print_function
# This must be the first statement before other statements.
# You may only put a quoted or triple quoted string,
# Python comments, other future statements, or blank lines before the __future__ line.

try:
    import __builtin__
except ImportError:
    # Python 3
    import builtins as __builtin__

import os

logf_name = 'log'
logf_path = ''
log_file = None
logf_n = 0

script_name = ''

def logger_start(scr_name):
    global script_name
    # After script_name is
    script_name = scr_name

    if os.path.exists('log/'):
        import subprocess
        subprocess.run(["rm", f"log/{script_name}*"])
    else:
        print('Create log directory?')
        print('Cwd:', os.getcwd())
        resp = input('y/n')
        if resp[0].lower()=='y':
            os.makedirs('log/')
        else:
            print('Exitting; no log dir')
            exit(1)

def logger_end():
    if log_file is not None:
        end_log_file()

def change_log_file(name):
    global logf_name
    global logf_path
    global log_file
    global logf_n

    if log_file is not None:
        end_log_file()

    assert len(script_name) > 0, 'logger.logf_source must be set!'

    logf_name = f'{script_name} {logf_n} {name}'
    logf_path = f'log/{logf_name}.txt'
    log_file = open(logf_path, 'w')

def end_log_file():
    global log_file
    global logf_n
    log_file.write('\n\n\n')
    log_file.write('-End-of-log-file-\n')
    log_file.write(f'--{script_name} - {logf_name}--\n')
    log_file.write('\n')
    log_file.close()
    logf_n+=1
    log_file = None

def print(*args, **kwargs):
    """My custom print() function."""
    # Adding new arguments to the print function signature
    # is probably a bad idea.
    # Instead consider testing if custom argument keywords
    # are present in kwargs
    # __builtin__.print('My overridden print() function!')

    if log_file is not None:
        for a in args:
            log_file.write(str(a)+' ')
        endl = kwargs['end'] if 'end' in kwargs else '\n'
        log_file.write(endl)
    if 'silent' in kwargs and kwargs['silent']:
        return
    return __builtin__.print(*args, **kwargs)
