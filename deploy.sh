#!/bin/sh

# Deploys Hugo Website to GitHub Page

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting Old Worktrees"
rm -rf public && mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages into public"
git worktree add -B gh-pages public origin/gh-pages
cd public && git submodule update
mkdir -p content/AWS && mv *.md content/AWS/.
rm README.md

echo "Generating Site"
hugo -b "http://www.aayushtuladhar.com/aws-solutions-architect-associate-notes/" -d .


echo "Updating gh-pages branch"
git add --all && git commit -m "Publishing to gh-pages - `date`"

git push --set-upstream origin gh-pages
cd ..
rm -rf public && git worktree prune