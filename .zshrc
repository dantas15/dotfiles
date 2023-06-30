# backup for pop-os-2023-06-30

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  fast-syntax-highlighting
  zsh-autosuggestions
  asdf
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# clipboard with xclip - got it from: https://askubuntu.com/questions/11925/a-command-line-clipboard-copy-and-paste-utility
## Usage guide: cat example.txt | clipboard
alias clip="xclip -sel clip"
alias currdir="pwd | clip"


# Java and Android Stuff
export JAVA_HOME=". ~/.asdf/plugins/java/set-java-home.zsh"

# Compile and run C++ file
function dcpp() {
  # Use $2 to pass more parameters to g++
  ## useful website: https://bytes.usc.edu/cs104/wiki/gcc/#options
  if [ "$1" != "" ]
  then
    # Remove the .cpp extension from the file name
    FILENAME=$(echo $1 | tr -d ".cpp")

    g++ -std=c++17 $2 -Wall -g $1 -o $FILENAME.out
    ./$FILENAME.out
  else
    echo "Please provide a file name"
  fi
}

#kill port
function killport() {
  lsof -t -i:$1
}

# Launch program command with nvidia gpu
# __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia
# alias rwithnvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
# alias chrome="__NV_PRIME_RENDER_OFFLOAD=1 google-chrome-stable"
# function rng() {
#   if [ "$1" != "" ]
#   then
#     rwithnvidia $@
#   else
#     echo "Provide file/folder name"
#   fi
# }

# Proton VPN
function pvpn() {
	protonvpn-cli $@
}

alias www="cd ~/Projects"
alias wwwp="cd ~/Projects/personal"
alias work="cd ~/Projects/work"
alias ufla="cd ~/Projects/ufla"
alias estd="cd ~/Projects/ufla/ed"
alias compjr="cd ~/Projects/ufla/compjr"
alias plp="cd ~/Projects/ufla/plp"

# git aliases
## show most recent 5 commites on one line, with formatting
alias gl5="git log -5 --graph --pretty=format:'%C(red)%h%Creset -%C(yellow)%d%Creset %s %C(green)(%cr) %C(yellow)<%an>%Creset'"

alias gaa="git add ."
alias gcam="git commit --amend --no-edit"

[ -f "/home/ista/.ghcup/env" ] && source "/home/ista/.ghcup/env" # ghcup-env

export PATH=$HOME/.emacs.d/bin:$PATH
