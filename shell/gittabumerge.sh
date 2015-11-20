git pull origin master

cd ../tabu
git checkout master
git pull origin master

# tabu
git remote add tabu ../tabu
git fetch tabu
git branch -f tabu-master tabu/master
git merge tabu-master

