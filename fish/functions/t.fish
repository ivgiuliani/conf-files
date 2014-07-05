function t
  if [ "$argv" ]
    tmux $argv
  else if tmux ls > /dev/null ^&1
    echo "There are already other tmux sessions active:"
    tmux ls
  else
    tmux new
  end
end
