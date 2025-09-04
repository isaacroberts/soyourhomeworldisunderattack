
print("Enter/Paste colors. Ctrl-D or Ctrl-Z ( windows ) to save it.")
contents = []
while True:
    try:
        line = input()
    except EOFError:
        break
    contents.append(line)

s = '\n'.join(contents)

lines = s.split('\n')
def clean_line(line):
    line = line.strip()
    if len(line)==0:
        return None, None
    if line[0]=='s':
        id = line[1]
        iconst = line.find('const')
        line = line[iconst+5:]
        line = line.replace(',','')
        return id, line
    return None, None

for line in lines:
    id, color = clean_line(line)
    if id is not None:
        print(f"static const Color shade{id} = {color};")
        # print(clean_line(lines[1]))
