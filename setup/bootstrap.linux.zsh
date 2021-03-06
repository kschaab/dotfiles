
###########################
# Install linux utilities #
###########################
sudo apt update
sudo apt install autojump bat ranger fzf thefuck stow

##############
# Nerd fonts #
##############
() {
    local utilities_dir="$HOME/source/utilities"
    local font_enlistment_dir="$utilities_dir/nerd-fonts"
    if [[ ! -d "$utilities_dir" ]]; then
        mkdir -p "$utilities_dir"
    fi

    if [[ ! -d "$font_enlistment_dir" ]]; then
        git clone https://github.com/ryanoasis/nerd-fonts.git $font_enlistment_dir
        eval "$font_enlistment_dir/install.sh"
    fi
}