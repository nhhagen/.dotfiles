fontpatcher="./powerline-fontpatcher/scripts/powerline-fontpatcher"
source="./Input-Font/Input_Fonts/InputMono/InputMonoCondensed"
target="./Input-Font/Input_Fonts/InputMono"

brew update
brew install fontforge

# unzip -o "$source.zip" -d "$target"
for file in "$source/"*.ttf; do
    echo "$file"
    fontforge -script "$fontpatcher" "$file"
done
