```
git filter-branch -f --env-filter "GIT_AUTHOR_NAME='Bartek Skorulski'; GIT_AUTHOR_EMAIL='bartekskorulski@gmail.com'; GIT_COMMITTER_NAME='Bartek Skorulski'; GIT_COMMITTER_EMAIL='bartekskorulski@gmail.com';" HEAD

git pull origin master --allow-unrelated-histories
```
