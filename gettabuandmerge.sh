cd ../tabu
git checkout master
git pull origin master
cd ../guitest
git remote add taburem ../guitest
git fetch taburem
git branch tabumas taburem/master
git merge tabumas
git mergetool
# git branch -d tabumas
