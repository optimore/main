git pull origin master
cd ../guitest
git pull origin master
cd ../tabu
git pull origin master
cd ../ampl
git pull origin master
cd ../main

### major merge script
# guitest
# git remote add guitest ../guitest
git fetch guitest
git branch -f guitest-master guitest/master
git merge guitest-master

# tabu
# git remote add tabu ../tabu
git fetch tabu
git branch -f tabu-master tabu/master
git merge tabu-master

# ampl
# git remote add ampl ../ampl
git fetch ampl
git branch -f ampl-master ampl/master
git merge ampl-master

git push origin master