
# remove all files in `build` directory
rm -rf build

# make ./build if not exist
mkdir -p build
mkdir -p build/markdown
mkdir -p build/pdf

# emurate through all `.ipynb` files in current directory and subdirectories
# follow .gitignore (use git ls-files)
# for file in $(find . -name "*.ipynb"); do
for file in $(git ls-files | grep .ipynb); do
    # use absolute path
    file=$(realpath $file)
    # convert to markdown, store in `build/markdown/${file%.ipynb}.md`
    jupyter nbconvert $file \
        --to markdown \
        --output-dir build/markdown \
        --sanitize_html=True
    # get filename without extension and path
    filename=$(basename $file .ipynb)
    # use pandoc to convert markdown to pdf, store in `build/pdf/${file%.ipynb}.pdf`
    pandoc build/markdown/$filename.md \
        -o build/pdf/$filename.pdf \
        --pdf-engine=xelatex \
        --resource-path build/markdown \
        --template eisvogel \
        -V mainfont="Source Han Serif CN" \
        # --listings
done