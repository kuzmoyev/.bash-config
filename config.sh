if [ $# -eq 1 ]; then
    echo -n $1 > ~/.bash-config/machine_name
fi

if [ "$(uname)" = "Darwin" ]; then
    cp .zprofile ~/

    # install brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install bash-completion

    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    echo '. ~/.bash-config/aliases.sh' >> ~/.zshrc

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    curl -o ~/.git-prompt.sh 'https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh'
    cp .bashrc ~/
fi

# Install UV
curl -LsSf https://astral.sh/uv/install.sh | sh
# Create global python environment
uv venv