# Aliases
alias ls="ls --color=auto"
alias la="ls -a"
alias install="sudo pacman -S"
alias updateall="sudo pacman -Syu"
alias update="sudo pacman -Syy"
alias installaur="yay -S"

# Plugins
plugins=( 
    git
    zsh-autosuggestions
    fast-syntax-highlighting
    zsh-autocomplete
)

export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

neofetch
eval "$(starship init zsh)"
