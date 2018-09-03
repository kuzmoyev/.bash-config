curl -o ~/.git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'



if [ "$(uname)" == "Darwin" ]; then
    cp .bash_profile ~/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    cp .bashrc ~/
fi
