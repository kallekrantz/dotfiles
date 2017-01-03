set -gx EDITOR "emacsclient -n -create-frame"
set -gx ALTERNATE_EDITOR emacs
set -gx VISUAL emacsclient

set -U LC_ALL en_US.UTF-8
set -U LANG en_US.UTF-8

set fish_function_path $fish_function_path "/usr/local/lib/python2.7/site-packages/powerline/bindings/fish"

# Aliases that are good to have.
alias e edit
alias gs "git status --short"
alias gl "git lg"
alias gd "git diff"
alias gb "git branch"
alias x "aunpack -q -e"
alias emc 'emacsclient -n'
alias g "git"
alias ipy "ipython"
# Kill the last command, I like to ctrl-c in projects that have messed too much with the signals.
alias kp "kill %1" 

set -x GOPATH "$HOME/Code/go"

# Settings for Homebrew Cask
set -x PATH "/usr/local/bin" $PATH
set -x PATH "$GOPATH/bin" $PATH

if [ $TERM ]
   powerline-setup
   status --is-interactive; and source (pyenv init - | psub)
   status --is-interactive; and . (nodenv init -|psub)
end

