xcode-select --install

####################
# Install Homebrew #
####################
if ! command -v $HOME/homebrew/bin/brew > /dev/null 2>&1 ;  then
    git clone https://github.com/Homebrew/brew.git $HOME/homebrew
fi

export PATH=$HOME/homebrew/bin:$PATH
export LD_LIBRARY_PATH=$HOME/homebrew/lib:$LD_LIBRARY_PATH
