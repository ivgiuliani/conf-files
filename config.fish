# Remove welcome message
set fish_greeting

# add custom scripts to $PATH
set PATH $HOME/bin $HOME/.local/bin $PATH

# I hate gnome keyring and I don't want to use it ever again, however
# gnome thinks I have to use it and prints stupid warnings all over my
# output. Just get rid of it.
set -e GNOME_KEYRING_CONTROL

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
  printf '%s:' (hostname|cut -d . -f 1)
  if test "$PWD" != "$HOME"
    printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
  else
    echo '~'
  end
  set_color normal
end

function fish_prompt
  if set -q VIRTUAL_ENV
    echo -n -s (set_color purple) "@" (basename "$VIRTUAL_ENV") " "
    set_color normal
  end

  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set color normal

  echo -n (__fish_git_prompt)
  set_color normal
  echo '$ '
end

# VirtualFish
set -g VIRTUALFISH_COMPAT_ALIASES # uncomment for virtualenvwrapper-style commands
. $HOME/.config/fish/virtualfish/virtual.fish
# optional plugins
. $HOME/.config/fish/virtualfish/auto_activation.fish
. $HOME/.config/fish/virtualfish/global_requirements.fish
. $HOME/.config/fish/virtualfish/projects.fish

# Termcap colors
set -x LESS_TERMCAP_mb (printf "\e[01;31m")
set -x LESS_TERMCAP_md (printf "\e[01;31m")
set -x LESS_TERMCAP_me (printf "\e[0m")
set -x LESS_TERMCAP_se (printf "\e[0m")
set -x LESS_TERMCAP_so (printf "\e[01;44;33m")
set -x LESS_TERMCAP_ue (printf "\e[0m")
set -x LESS_TERMCAP_us (printf "\e[01;32m")
