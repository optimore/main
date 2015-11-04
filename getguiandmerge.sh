cd ../guitest
git pull origin master
cd ../tabu
git remote add guiremote ../guitest
git fetch guiremote
git branch guimaster guiremote/master
git merge guimaster
git branch -d guimaster
