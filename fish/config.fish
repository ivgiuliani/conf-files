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

# PlatformIO
set PATH $HOME/.platformio/penv/bin $PATH

export AWS_ENDPOINT_URL=https://s.bitset.io
export AWS_ACCESS_KEY_ID=hEkH2DEq9PUX3H23mroX
export AWS_SECRET_ACCESS_KEY=vmh3OUcibdyPPhrKGch0xvCSnooXTQrEw7zuOp7S
export AWS_DEFAULT_REGION=us-west-2

# Termcap colors
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

set -g theme_title_use_abbreviated_path no

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/ivan/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Tide prompt
set --global tide_left_prompt_items pwd git character
set --global tide_right_prompt_items #go java python ruby zig rustc

# Start zellij on startup
set -x ZELLIJ_AUTO_ATTACH true
set -x ZELLIJ_AUTO_EXIT true
if status is-interactive
  eval (zellij setup --generate-auto-start fish | string collect)
end

# Forces the autoload of zellij utils
zellij_utils
zellij_update_tabname
