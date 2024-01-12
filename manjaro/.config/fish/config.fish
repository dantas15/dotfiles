if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias reload="source ~/.config/fish/config.fish"
alias ssh_hostinger_compjr='sshpass -f ~/.ssh/hostinger_compjr_pass ssh hostinger_compjr'

# You must call it on initialization or listening to directory switching won't work
load_nvm > /dev/stderr

# disable fish_greeting
set fish_greeting

