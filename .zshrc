### CONFIGURATION ###
config_help=true

### CONSTANTS ###

## Color Codes

# gen_color <red> <green> <blue> <fg=1 | bg=0> <style>
gen_color() {
    if [[ "${4:=1}" -eq 1 ]]; then
        # Foreground
        printf "\e[38;%s;%s;%s;%sm" "${5:=2}" "${1:=255}" "${2:=255}" "${3:=255}"
    else
        # Background
        printf "\e[48;%s;%s;%s;%sm" "${5:=2}" "${1:=255}" "${2:=255}" "${3:=255}"
    fi
}

color_main_ui_fg="$(gen_color 255 255 255 1)"
color_main_ui_bg="$(gen_color 255 255 255 0)"
color_main_text_fg="$(gen_color 48 48 48 1)"
color_main_text_bg="$(gen_color 48 48 48 0)"

## Characters
pl_solid_left_triangle='\uE0B0'
pl_hollow_left_triangle='\uE0B1'
pl_solid_right_triangle='uE0B2'
pl_hollow_right_triangle='uE0B3'

pl_solid_left_round='\uE0B4'
pl_hollow_left_round='\uE0B5'
pl_solid_right_round='uE0B6'
pl_hollow_right_round='uE0B7'

pl_solid_left_bot_ledge='\uE0B8'
pl_hollow_left_bot_ledge='\uE0B9'
pl_solid_right_bot_ledge='uE0Ba'
pl_hollow_right_bot_ledge='uE0Bb'

pl_solid_left_top_ledge='\uE0Bc'
pl_hollow_left_top_ledge='\uE0Bd'
pl_solid_right_top_ledge='uE0Be'
pl_hollow_right_top_ledge='uE0Bf'

### ZSH INSTALLER ###
# The following lines were added by compinstall

zstyle ':completion:*' auto-description '\ %d'
zstyle ':completion:*' completer _list _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' format '> Completing %d ...'
zstyle ':completion:*' insert-unambiguous true
zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/max/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install

### ZSH SETTINGS ###
autoload -Uz promptinit
promptinit

if [[ config_help ]]; then
    autoload -Uz run-help
    alias help=run-help

    autoload -Uz run-help-git
    autoload -Uz run-help-ip
    autoload -Uz run-help-openssl
    autoload -Uz run-help-p4
    autoload -Uz run-help-sudo
    autoload -Uz run-help-svk
    autoload -Uz run-help-svn
fi

zstyle ':completion:*' rehash true

### ZPLUG PACKAGES ###
source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build: "zplug --self-manage"


zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "mfaerevaag/wd"
zplug "arzzen/calc.plugin.zsh"
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

# Candidates list
# fzf,

# Must load last.
zplug "zsh-users/zsh-syntax-highlighting"

if ! zplug check; then
    zplug install
fi

zplug load

### LIBRARY ###
wifi_signal() {
    local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
    local color="yellow"
    [[ $signal -gt 75 ]] && color="green"
    [[ $signal -lt 50 ]] && color="red"
    echo -n "%F{$color}\uf1eb" # \uf1eb is 
}

### PROMPT ###
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

# Intriguing elements
# detect_virt ssh vi_mode background_jobs load ram icons_test
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time detect_virt ssh context ip vcs load ram newline os_icon vi_mode dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status)

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""

POWERLEVEL9K_COLOR_SCHEME="dark"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0

### BANNER ###

### BASH IMPORT ###
#export EDITOR=/usr/bin/nano # For lightweight purposes.

## For heavyweight purposes.
#if [[ -x "$(command -v nvim)" ]]; then
    #export VISUAL="/usr/bin/nvim"
#elif [[ -x "$(command -v vim)" ]]; then
    #export VISUAL="/usr/bin/vim"
    #alias nvim="vim"
#else
    #export VISUAL="/usr/bin/nano"
#fi

#export PAGER='less'
#export MANPAGER='less'

#if [[ -x "$(command -v firefox)" ]]; then
    #export BROWSER="firefox '%' &"
#elif [[ -x "$(command -v chromium)" ]]; then
    #export BROWSER="chromium '%' &"
#elif [[ -x "$(command -v google-chrome-stable)" ]]; then
    #export BROWSER="google-chrome-stable '%' &"
#fi

#add-path() {
    #if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        #PATH="${PATH:+"$PATH:"}$1"
    #fi
#}

#add-path "$HOME/bin/"
#add-path "/sbin/"
#add-path "/usr/sbin/"

#export PROMPT_DIRTRIM=3 # Show the last 3 directories in the prompt.

## Dynamically set term to the right prefix.
#case $TERM in
    #konsole|xterm|screen|tmux|rxvt-unicode)
        #TERM="$TERM-256color";;
#esac

## Colors
#RED='\e[0;31m'
#LIGHTRED='\e[1;31m'
#YELLOW='\e[1;33m'
#GREEN='\e[0;32m'
#LIGHTGREEN='\e[1;32m'
#CYAN='\e[0;36m'
#LIGHTCYAN='\e[1;36m'
#BLUE='\e[0;34m'
#LIGHTBLUE='\e[1;34m'
#PURPLE='\e[0;35m'
#LIGHTPURPLE='\e[1;35m'
#BROWN='\e[0;33m'
#BLACK='\e[0;30m'
#DARKGREY='\e[1;30m'
#LIGHTGREY='\e[0;37m'
#WHITE='\e[1;37m'
#NC='\e[0m' # "No color"
#RESET=$NC
#BLINK='\e[5m'
#BOLD='\e[1m'

## Settings
#time_indicator=yes
#resource_indicator=yes
#enable_banner=yes

#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
    #xterm-color) color_prompt=yes;;
#esac

##_shrunkPrompt='\[\033[00m\]\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$\[$(tput sgr0)\]\[\033[00m\] '
##PS1='\[\033[00m\]'
##if [ "$time_indicator" = yes ]; then
    ##PS1=${PS1}'\[\033[00;37m\][\[\033[01;30m\]\t\[\033[00;37m\]]'
##fi
##PS1=${PS1}' \[\033[01;32m\]\u\[\033[01;30m\]@\[\033[00;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$\[$(tput sgr0)\]\[\033[00m\] '
##_normalPrompt=${PS1}

#unset time_indicator resource_indicator color_prompt force_color_prompt

#if [ -x /usr/bin/dircolors ]; then
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    ##alias dir='dir --color=auto'
    ##alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
#fi

## some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

## Fix tmux 256 colors:
#alias tmux='tmux -2'

## Clear color codes before clearing:
#alias clear='echo -e "\e[0m" && clear'

## Typical rsync command
#alias relocate='rsync -avzh --info=progress2'

## Aliases, functions, commands, etc.
#extract () {
    #if [ -f $1 ] ; then
        #case $1 in
            #*.tar.bz2)   tar xvjf $1    ;;
            #*.tar.gz)    tar xvzf $1    ;;
            #*.bz2)       bunzip2 $1     ;;
            #*.rar)       unrar x $1       ;;
            #*.gz)        gunzip $1      ;;
            #*.tar)       tar xvf $1     ;;
            #*.tbz2)      tar xvjf $1    ;;
            #*.tgz)       tar xvzf $1    ;;
            #*.zip)       unzip $1       ;;
            #*.Z)         uncompress $1  ;;
            #*.7z)        7z x $1        ;;
            #*)           echo "Unknown filetype for '$1'" ;;
        #esac
    #else
        #echo "'$1' is not a valid file!"
    #fi
#}

#colors () {
    #echo    'Usage: ${LIGHTPURPLE}Your text ${BLINK}here${RESET}'
    #echo -e "     > ${LIGHTPURPLE}Your text ${BLINK}here${RESET}"
    #echo -e "Special colors: ${BLINK}BLINK ${NC}NC ${BOLD}BOLD ${RESET}RESET"
    #echo -e "Normal colors: ${RED}RED ${LIGHTRED}LIGHTRED ${YELLOW}YELLOW ${GREEN}GREEN ${LIGHTGREEN}LIGHTGREEN ${CYAN}CYAN ${LIGHTCYAN} ${BLUE}BLUE ${LIGHTBLUE}LIGHTBLUE ${PURPLE}PURPLE ${LIGHTPURPLE}LIGHTPURPLE ${BROWN}BROWN ${BLACK}BLACK ${DARKGREY}DARKGREY ${LIGHTGREY}LIGHTGREY ${WHITE}WHITE"
#}

## Join a telnet based movie theater.
#starwars() {
    #telnet towel.blinkenlights.nl
#}

## Download and run a curl based Party Parrot animation.
#parrot() {
    #curl parrot.live
#}

## Duplicate of parrot()
#party() {
    #parrot
#}

## Ascend the directories X times.
#up() {
    #DEEP=$1
    #[ -z "${DEEP}" ] && {
        #DEEP=1
    #}
    #for i in $(seq 1 ${DEEP})
        #do cd ../
    #done;
#}

#_shrunk=no
#shrink() {
    #if [ "$_shrunk" = no ]; then
        #_shrunk=yes
        #PS1=${_shrunkPrompt}
    #else
        #_shrunk=no
        #PS1=${_normalPrompt}
    #fi
#}
#alias grow='shrink'

#fix-keys() {
    #sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$(sudo apt update 2>&1 | grep -o '[0-9A-Z]\{16\}$' | xargs)"
#}

#if [ -d "$HOME/anaconda3/bin/" ]; then
    #export PATH="$HOME/anaconda3/bin:$PATH"
#fi

#if [[ -d "$HOME/.anaconda3/bin" ]]; then
    #export PATH="$HOME/.anaconda3/bin:$PATH"
#fi

#if [ -d "$HOME/.neovim-studio/" ] && [ -z "${NEOVIM_STUDIO_PROFILE_SOURCED}" ]; then
    #source "$HOME/.profile"

    #if [ -z "${NEOVIM_STUDIO_PROFILE_SOURCED}" ]; then
        ## Doesn't exist within the profile.
        #export NEOVIM_STUDIO_PROFILE_SOURCED=1
    #fi
#fi

#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#if [[ -d "$HOME/bin" ]]; then
	#export PATH="$PATH:$HOME/bin"
#fi

## NVIDIA CUDA
#if [[ -d "/usr/local/cuda/bin" ]]; then
    #export PATH="/usr/local/cuda/bin:$PATH"
    #export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
    ## TODO: Set this to dynamically select 32bit path if on a 32bit system.
#fi

#if [[ -d "$HOME/.rbenv/" ]]; then
    #export PATH="$HOME/.rbenv/bin:$PATH"
    #eval "$(rbenv init -)"
    #export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
#fi




