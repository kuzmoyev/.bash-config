if [ "$(uname)" == "Darwin" ]; then
    echo 'source ~/.bash-config/bashrc' > ~/.bash_profile
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo 'source ~/.bash-config/bashrc' > ~/.bashrc
fi
