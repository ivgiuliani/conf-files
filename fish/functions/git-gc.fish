function git-gc
  # delete branches that don't exist on remote anymore
  git remote update origin --prune

  # delete all tags locally, then recreate them from remote
  # (implicitely, will also run gc)
  git tag -l | xargs git tag -d
  git fetch
end
