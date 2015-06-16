#TODO FIXME: check for filename with space
DIR=$1

DIRTY_FILES=`git diff-files --ignore-submodules 2>/dev/null | cut -f 2`

UNTRACKED_FILES=`git ls-files --exclude-standard --others 2>/dev/null`
UNTRACKED_FILES="$UNTRACKED_FILES `git ls-files $1 --ignored --exclude-standard --others 2>/dev/null`"

COMMITTED_FILES=`git ls-files 2>/dev/null`


function dirty_file() {
    [[ $(echo "$DIRTYFILES" | grep "$1" 2>/dev/null) != "" ]]
}

function untracked_file() {
    false
}

function staged_file() {
    [[ $(git diff --cached --shortstat $1 2>/dev/null) != "" ]]
}

function commited_file() {
    false
}

OUT=`ls -lah $DIR`

for f in $DIRTY_FILES; do
    OUT=`printf "$OUT" | sed "s/$f$/$f dirty/"`
done

for f in $UNTRACKED_FILES; do
    OUT=`printf "$OUT" | sed "s/$f$/$f untracked/"`
done

for f in $COMMITTED_FILES; do
    OUT=`printf "$OUT" | sed "s/$f$/$f committed/"`
done

printf "$OUT\n"
