function ggrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.gradle" \
        -exec grep $1 --color -n "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.gradle" \
        -exec grep --color -n "$@" {} +
    fi
}

function jgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.java" \
        -exec grep $1 --color -n "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.java" \
        -exec grep --color -n "$@" {} +
    fi
}

function cgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) \
        -exec grep $1 --color -n "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' \) \
        -exec grep --color -n "$@" {} +
    fi
}

function halgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.hal" -print0 | xargs -0 grep $i --color -n "$@"
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.hal" -print0 | xargs -0 grep --color -n "$@"
    fi
}

function resgrep()
{
    local dir
    if [ "$1" == "-i" ]; then
      for dir in `find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -name res -type d`; do
        find $dir -type f -name '*\.xml' -exec grep $1 --color -n "$@" {} +
      done
    else
      for dir in `find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -name res -type d`; do
        find $dir -type f -name '*\.xml' -exec grep --color -n "$@" {} +
      done
    fi
}

function mangrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -type f -name 'AndroidManifest.xml' \
        -exec grep $1 --color -n "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -type f -name 'AndroidManifest.xml' \
        -exec grep --color -n "$@" {} +
    fi
}

function sepgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -name sepolicy -type d \
        -exec grep $1 --color -n -r --exclude-dir=\.git "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -name sepolicy -type d \
        -exec grep --color -n -r --exclude-dir=\.git "$@" {} +
    fi
}

function rcgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.rc*" \
        -exec grep $1 --color -n "$@" {} +
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.rc*" \
        -exec grep --color -n "$@" {} +
    fi
}

function xmlgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml" -print0 | xargs -0 grep $1 --color -n "$@"
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.xml" -print0 | xargs -0 grep --color -n "$@"
    fi
}


function tegrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.te*" -print0 | xargs -0 grep $1 --color -n "$@"
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.te*" -print0 | xargs -0 grep --color -n "$@"
    fi
}

function aidlgrep()
{
    if [ "$1" == "-i" ]; then
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.aidl*" -print0 | xargs -0 grep $1 --color -n "$@"
    else
        find . -name .repo -prune -o -name .git -prune -o -name out -prune -o -type f -name "*\.aidl*" -print0 | xargs -0 grep --color -n "$@"
    fi
}

function mgrep()
{
    if [ "$1" == "-i" ]; then
      find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o \( -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk|.*\.bp)' -o -regextype posix-extended -regex '(.*/)?soong/[^/]*.go' \) -type f \
        -exec grep $1 --color -n "$@" {} +
    else
      find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o \( -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk|.*\.bp)' -o -regextype posix-extended -regex '(.*/)?soong/[^/]*.go' \) -type f \
        -exec grep --color -n "$@" {} +
    fi
}

function treegrep()
{
    if [ "$1" == "-i" ]; then
      find . -name .repo -prune -o -name .git -prune -o -regextype posix-egrep -iregex '.*\.(c|h|cpp|hpp|S|java|xml)' -type f \
        -exec grep $1 --color -n -i "$@" {} +
    else
      find . -name .repo -prune -o -name .git -prune -o -regextype posix-egrep -iregex '.*\.(c|h|cpp|hpp|S|java|xml)' -type f \
        -exec grep --color -n -i "$@" {} +
    fi
}

function sgrep()
{
    if [ "$1" == "-i" ]; then
      find . -name .repo -prune -o -name .git -prune -o  -type f -iregex '.*\.\(c\|h\|cc\|cpp\|hpp\|S\|java\|xml\|sh\|mk\|aidl\|vts\|bash\)' \
        -exec grep $1 --color -n "$@" {} +
    else
      find . -name .repo -prune -o -name .git -prune -o  -type f -iregex '.*\.\(c\|h\|cc\|cpp\|hpp\|S\|java\|xml\|sh\|mk\|aidl\|vts\|bash\)' \
        -exec grep --color -n "$@" {} +
    fi
}

