#!/usr/bin/env sh
set -e

VERSION=`cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[",]//g' | tr -d '[[:space:]]'`
TAG_VERSION = v$VERSION
echo "Releasing $VERSION ..."

# git add -A
# git commit -m "[build] $VERSION"
# npm version $VERSION --message "[release] $VERSION"
git tag $TAG_VERSION

# publish
# git push origin main
git push origin $TAG_VERSION
git checkout dev
git rebase main
git push origin dev
