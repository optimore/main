cd ../guitest
git checkout devhen
git pull origin devhen
cd ../tabu
git remote add guiremote ../guitest
git fetch guiremote
git branch -d guimaster
git branch guimaster guiremote/devhen
git merge guimaster
git mergetool
git branch -d guimaster
