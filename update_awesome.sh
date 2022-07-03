# Reclone the repo
rm -r ~/.config/awesome -f
gh repo clone Sakyce/liminal-awesome ~/.config/awesome

echo 'synced repo'
echo ''

echo 'awesome.restart()' | awesome-client