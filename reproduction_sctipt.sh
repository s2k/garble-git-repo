mkdir tmp
cd tmp
git init
echo "Some content" > non-empty-file.txt
git add .
GIT_COMMITTER_DATE="31 Dec 1969 23:59:60 +0100" git commit -m "Demo commit" --date "12 Dec 1969 23:59:60 +0100"
GIT_COMMITTER_DATE="01 Jan 1970 00:00:00 +0100" git commit -m "Demo commit" --date "01 Jan 1970 00:00:00 +0100"
