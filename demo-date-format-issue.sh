git init tmp
cd tmp
echo "Some content" > non-empty-file.txt
git add .
GIT_COMMITTER_DATE="31 Dec 1969 23:59:60 +0000" git commit -m "Commit 1" --date "12 Dec 1969 23:59:60 +0000"
GIT_COMMITTER_DATE="01 Jan 1970 00:00:00 +0000" git commit -m "Commit 1" --date "01 Jan 1970 00:00:00 +0000"

echo "More content" > non-empty-file.txt
git add .
GIT_COMMITTER_DATE="01 Jan 2100 00:00:00 +0000" git commit -m "Commit 2" --date "01 Jan 2100 00:00:00 +0000"
GIT_COMMITTER_DATE="31 Dec 2099 23:59:60 +0000" git commit -m "Commit 2" --date "31 Dec 2099 23:59:60 +0000"
