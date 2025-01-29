# ls
if [ "$(uname)" = "Darwin" ]; then
    alias ls="ls -G"
    alias run='open'
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    alias ls="ls --color=auto"
    alias run='xdg-open'
fi
alias ll="ls -lh"
alias la="ls -a"
alias l="ls"
alias lla="ls -lha"
alias lal="ls -lha"

# cd
function cd {
    builtin cd "$@" && ls
}
alias ..="cd .."
alias ...="cd ../../"
alias -- -="cd -"

# extract from archive
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
      esac
    else
        echo "'$1' is not a valid file"
    fi
}


# fix previous comands
alias sudop='sudo $(history -p !!)'
alias aptp='sudo apt install $(history -p !:0)'

# other
alias c="clear"
alias pingg="ping google.com -c 2"
alias ports='sudo netstat -tulpn | grep LISTEN'
alias json_cat='python -m json.tool'
alias hist='history | grep'

# spotify
alias nextsong='/usr/local/bin/spotifycli --status && /usr/local/bin/spotifycli --next || spotify'

# git
alias      g="'git'"
alias     ga='g add'
alias    gaa='g add --all'
alias    gau='g add -u'
alias     gc='g commit'
alias    gcm='g commit -m'
alias    gca='g commit --amend'
alias     go='g checkout'
alias    gob='g checkout -b'
alias     gb='g branch'
alias     gm='g merge'
alias    gmf='g merge --no-ff'
alias     gp='g push'
alias    gpo='g push -u origin $(g rev-parse --abbrev-ref HEAD)'
alias    gpf='g push -f'
alias    gpl='g pull'
alias     gl='g log'
alias    glg='g log --oneline --all --graph'
alias     gs='g status'
alias     gr='g reset'
alias    grh='g reset --hard'
alias   grhf='g checkout HEAD --'
alias    gr1='g reset HEAD^'
alias    gr2='g reset HEAD^'
alias    gr3='g reset HEAD^'
alias   grh1='g reset --hard HEAD^'
alias   grh2='g reset --hard HEAD^^'
alias   grh3='g reset --hard HEAD^^^'
alias  gundo='g reset --hard HEAD@{1}'
alias gundo2='g reset --hard HEAD@{2}'
alias   grfl='g reflog'
alias   gcln='g clone'
alias    gra='g remote add origin'
alias     gi='g init'


alias python='python3'
alias p='python3'
# virtualenv (uses uv)
alias nvnv='uv venv'
alias vnv='. .venv/bin/activate'
# jupyter
alias jn='jupyter notebook'
alias jl='jupyter lab'
# pip (uses uv)
alias pip='uv pip'
alias pipi='pip install'
alias pipu='pip uninstall'
alias pipiu='pipi --upgrade'
alias pipiup='pipiu pip'
alias pipf='pip freeze'
alias pipfr='pipf > requirements.txt'
alias pipir='pipi -r requirements.txt'
# UV
alias uvi='uv init'
alias uvr='uv run'
alias uva='uv add'
alias uvrm='uv remove'

# anaconda
alias cnd='. activate ${PWD##*/}'
alias ncndb='conda create -n ${PWD##*/}'
alias ncnd='ncndb numpy pandas'
alias rcnd='conda remove --name ${PWD##*/} --all'


# find
FIND() {
    TYPES_LIST=($1)
    TYPES="\( -type ${TYPES_LIST[0]}"
    for t in "${TYPES_LIST[@]:1}"; do
        TYPES+=" -o -type $t"
    done
    TYPES+=" \)"

    find . "$TYPES" -name "$2"  2>/dev/null;
}
# find anything
f   () { FIND 'd f' "$@"   ;}  # Find
fq  () { FIND 'd f' "*$@*" ;}  # Find by query
fs  () { FIND 'd f' "$@*"  ;}  # Find starts with
fe  () { FIND 'd f' "*$@"  ;}  # Find ends with
# find file
ff  () { FIND 'f' "$@"     ;}  # Find file
ffq () { FIND 'f' "*$@*"   ;}  # Find file by query
ffs () { FIND 'f' "$@*"    ;}  # Find file starts with
ffe () { FIND 'f' "*$@"    ;}  # Find file ends with
# find directory
fd  () { FIND 'd' "$@"     ;}  # Find directory
fdq () { FIND 'd' "*$@*"   ;}  # Find directory by query
fds () { FIND 'd' "$@*"    ;}  # Find directory starts with
fde () { FIND 'd' "*$@"    ;}  # Find directory ends with

