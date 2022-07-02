# Clone repo
sudo rm -r .config/awesome
gh repo clone Sakyce/liminal-awesome .config/awesome

# sync repo
cd .config/awesome && gh repo sync

cd .. && cp -r liminal-awesome ~/.config/awesome 
