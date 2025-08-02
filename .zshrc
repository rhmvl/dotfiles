#Aliases
alias vi="nvim"
alias ls="ls --color=auto"
alias wifi="nmcli"
alias la="ls -a"
alias ll="ls -lha"
alias pacman="sudo pacman"
alias update="sudo pacman -Syy"
alias neofetch="neofetch --ascii_colors 4 7"
alias rld=". ~/.zshrc"
alias cpufreq="auto-cpufreq"
alias cmatrix="unimatrix -n -s 96 -l 'o'"

# Check if the shell is interactive
[[ $- != *i* ]] && return

export LS_COLORS='di=34:fi=0:ln=36:pi=33:so=35:bd=32:cd=32:or=31:mi=31:ex=32:*.tar=31:*.gz=31:*.zip=31:*.jpg=35:*.png=35:*.pdf=35'

# Load Zsh completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':autocomplete:*' completer _complete _ignored
zstyle ':completion:*' menu select=long
zstyle ':completion:*' list-prompt '%SAt %p: %m choices%s'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection %p/%l%s'
zstyle ':completion:*' list-colors 'di=34:fi=0:ln=36:pi=33:so=35:bd=32:cd=32:or=31:mi=31:ex=32:*.tar=31:*.gz=31:*.zip=31:*.jpg=35:*.png=35:*.pdf=35'
zstyle ':completion:*' tag-order 'files' 'directories' 'commands' 'options' 'arguments'

# Customize zsh-autocomplete
zstyle ':autocomplete:*' show-completion-descriptions yes
zstyle ':autocomplete:*' sort directories yes
zstyle ':autocomplete:*' sort files yes
zstyle ':autocomplete:*' fuzzy-matching yes
zstyle ':autocomplete:*' completer _complete _ignored _approximate
zstyle ':autocomplete:*' max-candidates 500
zstyle ':autocomplete:*' completion-highlight first
zstyle ':autocomplete:*' delay 0.1
zstyle ':autocomplete:*' backspace cancel
zstyle ':autocomplete:*' select-prompt "%S[%I/%L] Completion (%I)%s"
zstyle ':autocomplete:*:completion:*' list-colors 'di=34:fi=0:ln=35:pi=33:so=32'
zstyle ':autocomplete:*' suggestions visible

PLUGINS=~/.zsh
source $PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $PLUGINS/zsh-autocomplete/zsh-autocomplete.plugin.zsh

bindkey -e
bindkey "^I" menu-select

# Initialize Starship prompt
eval "$(starship init zsh)"

