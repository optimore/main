cd ../tabu
git checkout master
git pull origin master
cd ../main
git remote add tabur ../tabu
git fetch tabur
git branch -D tabumas
git branch tabumas tabur/master
git merge tabumas
git mergetool
# git branch -d tabumas
