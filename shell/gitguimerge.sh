git pull origin master

cd ../guitest
git checkout master
git pull origin master

# tabu
git remote add gui ../guitest
git fetch gui
git branch -f gui-master gui/master
git merge gui-master