#!/usr/bin/env sh
set -e

VERSION=`cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]'`

echo "Releasing $VERSION ..."

git add -A
git commit -m "[build] $VERSION"
git tag v$VERSION
# npm version $VERSION --message "[release] $VERSION"

# publish
git push origin main
git push origin v$VERSION
git checkout dev
git rebase main
git push origin dev
