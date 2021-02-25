curl -o ~/.git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'

if [ $# -eq 1 ]; then
    echo -n $1 > ~/.bash-config/machine_name
fi

if [ "$(uname)" == "Darwin" ]; then
    
    # install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    brew install bash-completion
    
    cp .bash_profile ~/
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    cp .bashrc ~/
fi
