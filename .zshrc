### Enable PowerLevel10K Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ZSH-NEWUSER-INSTALL -----
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

### COMPINSTALL -----
zstyle :compinstall filename '/home/stuart/.zshrc'
autoload -Uz compinit
compinit

### PLUGINS -----
plugins=(
zsh-autosuggestions
zsh-sntax-highlighting
zsh-autocomplete
)

### POWERLEVEL10K -----
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

### To Customize Prompt, Run `p10k configure` Or Edit '~/.p10k.zsh'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### DRACULA COLOUR THEME -----
export MANPAGER="/usr/bin/less -s -M +Gg"
export LESS_TERMCAP_mb=$'\e[1;31m'      # Begin Bold
export LESS_TERMCAP_md=$'\e[1;34m'      # Begin Blink
export LESS_TERMCAP_so=$'\e[01;45;37m'  # Begin Reverse Video
export LESS_TERMCAP_us=$'\e[01;36m'     # Begin Underline
export LESS_TERMCAP_me=$'\e[0m'         # Reset Bold/Blink
export LESS_TERMCAP_se=$'\e[0m'         # Reset Reverse Video
export LESS_TERMCAP_ue=$'\e[0m'         # Reset Underline
export GROFF_NO_SGR=1                   # For Konsole

### ALIASES -----
alias picocom='picocom --omap crcrlf'
alias feh='feh --geometry 1440x900 --force-aliasing --scale-down'

