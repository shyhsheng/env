PS1='\[\033[01;32m\]\u \[\033[01;33m\]$(git_branch)\[\033[00m\]#\# [\[\033[01;34m\]\w\[\033[00m\]]\[\033[00;39m\] \$ '

alias asd='/usr/local/android-studio/bin/studio.sh&'
alias e='nautilus'
alias subn='subl -n'


export DISPLAY=:0
export CCACHE_DIR=~/.ccache
export USE_CCACHE=1

export PATH=~/.ccache:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:~/bin/android_tool/adb

#show the current branch in Git
function git_branch {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo "("${ref#refs/heads/}") ";
}

function git_since_last_commit {
    now=`date +%s`;
    last_commit=$(git log --pretty=format:%at -1 2> /dev/null) || return;
    seconds_since_last_commit=$((now-last_commit));
    minutes_since_last_commit=$((seconds_since_last_commit/60));
    hours_since_last_commit=$((minutes_since_last_commit/60));
    minutes_since_last_commit=$((minutes_since_last_commit%60));
    echo "${hours_since_last_commit}h${minutes_since_last_commit}m ";
}

. ~/.config/env/bash/completion/mybash_completion
. ~/.config/env/bash/completion/tig-completion.bash
. ~/.config/env/bash/completion/iw-completion
. ~/.config/env/bash/completion/ifconfig-completion

