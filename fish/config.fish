set -g fish_greeting
set -g theme_title_use_abbreviated_path no
set -g fish_key_bindings fish_default_key_bindings

# Global settings
# --------------------------------

# Termcap colors
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")

set -x EDITOR /opt/homebrew/bin/nvim

# Paths
# --------------------------------
fish_add_path "/usr/local/bin"
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path /opt/homebrew/opt/openjdk/bin # java
fish_add_path /opt/homebrew/share/google-cloud-sdk/bin # gcloud sdk
fish_add_path $HOME/.rd/bin # rancher
fish_add_path $HOME/.rbenv/bin # rbenv
fish_add_path $HOME/.rbenv/shims # rbenv
fish_add_path $HOME/.pyenv/bin
fish_add_path $HOME/.pyenv/shims
fish_add_path $HOME/.codeium/windsurf/bin # windsurf


# As instructed by brew
set BYOBU_PREFIX /usr/local
eval "$(/opt/homebrew/bin/brew shellenv)"


export NVM_DIR="$HOME/.nvm"

rbenv rehash 2> /dev/null
pyenv rehash 2> /dev/null
pyenv init - | source

# golang
set PATH /usr/local/go/bin $PATH
set GOPATH /Users/ivan/.go
export GOPATH=/Users/ivan/.go
set PATH $GOPATH/bin $PATH

. ~/.config/fish/autoenv.fish
if test -e $AUTOENVFISH_FILE
  . $AUTOENVFISH_FILE
end

# Fixes python issues with OSX
# https://stackoverflow.com/a/52230415
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"

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
# Disable command buffer edit via alt-e (still available via alt-v)

bind --preset -e alt-e

