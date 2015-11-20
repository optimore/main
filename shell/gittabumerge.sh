git pull origin master

cd ../tabu
git checkout master
git pull origin master

# tabu
git remote add tabur ../tabu
git fetch tabur
git branch -f tabu-master tabur/master
git merge tabu-master

