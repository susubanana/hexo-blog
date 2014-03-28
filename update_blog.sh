git pull origin master
hexo g
git add -A
git commit -m 'update'
git push origin master
cd public
git pull origin master
git add -A
git commit -m 'update github blog'
git push origin master
