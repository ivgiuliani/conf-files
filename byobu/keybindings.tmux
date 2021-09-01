# rebind ctrl+a as prefix
unbind-key -n C-a
set -g prefix ^A
set -g prefix2 ^A
bind a send-prefix

unbind-key -n F1
unbind-key -n F9

#bind-key -n C-Left previous-window
#bind-key -n C-Right next-window
#bind-key -n C-S-Up resize-pane -U
#bind-key -n C-S-Down resize-pane -D

#bind-key -n C-S-Left resize-pane -L
#bind-key -n C-S-Right resize-pane -R
