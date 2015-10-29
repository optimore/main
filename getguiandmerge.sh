cd ../guitest
git pull origin master
cd ../tabu
git fetch guitest
git branch guimaster guitest/master
git merge guimaster
git branch -d guimaster
