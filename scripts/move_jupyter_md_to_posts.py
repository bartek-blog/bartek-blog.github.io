import sys, os, re
from distutils.dir_util import copy_tree

JUPYTER_DIR = "jupyter"
POST_DIR = "_posts"
ASSETS_DIR = "assets"

def main():
    file_name = sys.argv[1]
    old_md = os.path.join(JUPYTER_DIR, file_name) + ".md"
    md_header = os.path.join(JUPYTER_DIR, file_name) + ".header"
    new_md = os.path.join(POST_DIR, file_name) + ".markdown"
    if os.path.isfile(md_header):
        with open(md_header, 'r') as f:
            header = f.read()
    else:
        header = ""
    with open(old_md, 'r') as f:
        text = f.read()
    new_text = re.sub(r"(\!\[[A-Za-z0-9]+\])\((.+)\)", r'\1(/assets/\2)', text)
    with open(new_md, 'w') as f:
        f.write(header)
        f.write(new_text)
    
    old_dir = os.path.join(JUPYTER_DIR, file_name) + "_files"
    if os.path.isdir(old_dir):
        print("coping dir")
        new_dir = os.path.join(ASSETS_DIR, file_name) + "_files"
        copy_tree(old_dir, new_dir)
        
if __name__ == "__main__":
    main()
