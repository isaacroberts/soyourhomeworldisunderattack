# Help, my Home World!

Help! My Homeworld is a magazine aimed at addressing Climate Anxiety. In it, we interview key figures, and learn what regular citizens can do to address carbon emissions, plastic waste, and e-waste.

## Website:

Help! My Homeworld is online at the url: homeworld.help

https://homeworld.help/

## Code

The code is provided to e-magazine publishers under the GPL license. 

This magazine format supports fonts, images, colors, highlights, links, and custom code elements. 

This code is provided free of comments. This code is provided free of compatibility. This code is provided free of documentation. 

### python_writer/ (Python)

python_writer takes a LibreOffice document and converts it into ebook format.

Ebooks are stored in a custom binary format called PossibleFly. If you were going to code on top of this, you should remove PossibleFly and replace it with minified json. 

run.sh: Runs entire pipeline and moves files 

1. Reader.py: Converts LibreOffice ODT files into JSON lines of text 
2. Font_counter.py: Prepares font table
4. Cleaner.py: Cleans text, fixes author errors, enforces formatting guidelines, and corrects some bugs.
6. Code_parser.py: Processes text in the style named "code marker". Allows the author to add custom code elements and images. Code elements must be written in Flutter.
7. book_inspector.py: Collects book details, in the "code marker" style. (Vestigial but mandatory)
8. chapter_breaker.py: Splits document into chapters, processes chapter keywords. Allows when/where chips on chapters.
9. image_prepper.py: Checks for images, calculates image color palette and aspect ratio.
10. chaptered_writer.py: Converts cleaned json into PossibleFly chapters. The split chapters are designed to be loaded separately.  
11. prepare_font_csv.py: Finishes font table.

### lib/ (Flutter)

The frontend. The flutter code is responsible for all slick UI design, custom code elements, etcetera. 

Flutter code unpacks PossibleFly into text elements, and displays them on an infinite scroll. 

### server/ (Python, Flask / Django)

Currently, the server is unused except for in development. The flask server is needed to serve files. However, on the server itself, the flutter code is grabbing files directly from the public/ folder. 

To run this project on your computer, run:

> python3 file_server.py

In future versions, the server will also manage lightweight social media functionality. 
