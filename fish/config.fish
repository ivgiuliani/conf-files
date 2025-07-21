# Remove welcome message
set fish_greeting

# add custom scripts to $PATH
set PATH $HOME/bin $PATH

# rustup
set PATH $HOME/.cargo/bin $PATH

# As instructed by brew
set BYOBU_PREFIX /usr/local

set PYTHONPATH $PYTHONPATH /usr/local/lib/python2.7/site-packages

export NVM_DIR="$HOME/.nvm"
# /usr/local/opt/nvm/nvm.sh"

fish_add_path "/usr/local/bin"

. ~/.config/fish/autoenv.fish
if test -e $AUTOENVFISH_FILE
  . $AUTOENVFISH_FILE
end

# rb-env
fish_add_path $HOME/.rbenv/bin
fish_add_path $HOME/.rbenv/shims
rbenv rehash 2> /dev/null

# py-env
fish_add_path $HOME/.pyenv/bin
fish_add_path $HOME/.pyenv/shims
pyenv rehash 2> /dev/null
pyenv init - | source

# golang
set PATH /usr/local/go/bin $PATH
set GOPATH /Users/ivan/.go
export GOPATH=/Users/ivan/.go
set PATH $GOPATH/bin $PATH

# Fixes python issues with OSX
# https://stackoverflow.com/a/52230415
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"

# Termcap colors
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

set -g theme_title_use_abbreviated_path no

# Tide prompt
set --global tide_left_prompt_items pwd git character
set --global tide_right_prompt_items #go java python ruby zig rustc

if status is-interactive
  # Set all the right vars for zellij, but don't auto-start it as this tends to
  # make things difficult in vscode or raycast
  set -x ZELLIJ_AUTO_ATTACH true
  set -x ZELLIJ_AUTO_EXIT true

  # Forces the autoload of zellij utils
  zellij_utils
  zellij_update_tabname
end
