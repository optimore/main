cd ../ampl
git pull origin master
cd ../tabu
git pull origin master
cd ../guitest
git checkout devhen

git remote add locampl ../ampl
git fetch locampl
git branch ampl locampl/master
git merge ampl
git branch -d ampl

git remote add loctabu ../tabu
git fetch loctabu
git branch tabu loctabu/master
git merge tabu
git branch -d tabu

