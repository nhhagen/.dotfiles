fontpatcher="./powerline-fontpatcher/scripts/powerline-fontpatcher"
source="./Meslo-Font/dist/v1.2.1/Meslo LG DZ v1.2.1"
target="./Meslo-Font/dist/v1.2.1/"

brew update
brew install fontforge

unzip -o "$source.zip" -d "$target"
for file in "$source/"*.ttf; do
    echo "$file"
    fontforge -script "$fontpatcher" "$file"
done
