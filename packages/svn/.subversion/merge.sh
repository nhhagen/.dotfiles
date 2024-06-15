#!/bin/sh
#
BASE=${1}
THEIRS=${2}
MINE=${3}
MERGED=${4}
WCPATH=${5}

vimdiff $MINE $THEIRS -c ":bo sp $MERGED" -c ":diffthis" -c "setl stl=MERGED | wincmd W | setl stl=THEIRS | wincmd W | setl stl=MINE"
