#!/usr/bin/env sh
set -e

git checkout main

VERSION=`cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]'`

TAG_VERSION=v$VERSION

echo "Releasing $VERSION ..."

# 如果有输出，则说明需要commit
if test -n "$(git status --porcelain)"; 
then
  git add -A
  git commit -m "[build] $VERSION"
fi

# npm version $VERSION --message "[release] $VERSION"
git tag "$TAG_VERSION"

# publish
git push origin main
git push origin $TAG_VERSION
git checkout dev
git rebase main
git push origin dev
