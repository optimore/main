cd ../guitest
git checkout devhen
git pull origin devhen
cd ../tabu
git remote add guiremote ../guitest
git fetch guiremote
git branch -D guimaster
git checkout -b guimaster guiremote/devhen
git pull origin guiremote/devhen
git merge guimaster
git mergetool
git branch -d guimaster
