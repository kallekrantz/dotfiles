set -gx  LC_ALL en_US.UTF-8

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set fish_function_path $fish_function_path "$HOME/.local/lib/python3.7/site-packages/powerline/bindings/fish"
set fish_function_path $fish_function_path "$HOME/.local/lib/python2.7/site-packages/powerline/bindings/fish"

bind \ett peco_todoist_item
bind \etp peco_todoist_project
bind \etl peco_todoist_labels
bind \etc peco_todoist_close
bind \etd peco_todoist_delete

# Please don't talk to me computer
set fish_greeting ""

#Fixes a nasty bug, where pyenv started reporting errors *everywhere*
function setenv
    set -gx $argv
end

# Aliases that are good to have.
alias e edit
alias c "edit --editor charm"
alias we "edit --editor webstorm"
alias gs "git status --short"
alias gll "git log"
alias gd "git diff"
alias gb "git branch"
alias gl "git log --pretty=oneline --abbrev-commit --graph"
alias x "aunpack -q -e"
alias emc 'emacsclient -n'
alias g "git"
alias ipy "ipython"
# Kill the last command, I like to ctrl-c in projects that have messed too much with the signals.
alias kp "kill %1"

# Shame that not everyone uses a good terminal-emulator :)
alias ssh "env TERM=xterm-color ssh"

set -x GOPATH "$HOME/Code/go"
set -x PATH "$GOPATH/bin" $PATH
set -x PATH "$HOME/.cargo/bin" $PATH
set -x PATH "$HOME/.local/bin" $PATH
set -x FONT_HOME "$HOME/.local/share/fonts"
set -x TERM linux
set -x TERMINFO /etc/terminfo
set -x DYLD_LIBRARY_PATH $HOME/.rustup/toolchains/stable-x86_64-apple-darwin/lib
set -x RLS_ROOT $HOME/src/rls

if [ $TERM ]
   powerline-setup
end

source ~/.asdf/asdf.fish