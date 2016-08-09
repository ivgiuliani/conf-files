function git-cpr
	git co master;
	git branch -D $argv;
	git co -B $argv;
	git pull origin $argv;
end
