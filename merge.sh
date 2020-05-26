#! /bin/bash
# Merge pushes to development branch to stable branch
if [ ! -n $2 ] ; then
    echo "Usage: merge.sh <username> <password>"
    exit 1;
fi

GIT_USER="$1"
GIT_PASS="$2"

# Specify the development branch and stable branch names
FROM_BRANCH="test"
CURRENT_BRANCH="test"
TO_BRANCH="new"


# Create the URL to push merge to 
URL="https://github.com/$GIT_USER/nextlinker_cmdb.git"
echo "Repo url is $URL"
PUSH_URL="https://$GIT_USER:$GIT_PASS@github.com/$GIT_USER/nextlinker_cmdb.git"
echo "Push to $PUSH_URL"

if [ "$CURRENT_BRANCH" = "$FROM_BRANCH" ] ; then
    echo "In if statement"
    # Checkout the dev branch
    #git checkout $FROM_BRANCH && \
    #echo "Checking out $TO_BRANCH..." && \
    git init
    git config remote.origin.fetch refs/heads/*:refs/remotes/origin/*
    # Checkout the latest stable
    git fetch origin $TO_BRANCH:$TO_BRANCH && \
    git checkout $TO_BRANCH && \
    # git rebase --abort
    ls -a
    # Merge the dev into latest stable
    # echo "Merging changes..." && \
    # git merge $FROM_BRANCH && \
    git pull --rebase origin $TO_BRANCH
    git pull --rebase origin $FROM_BRANCH
    ls -a

    git add .
    git commit --allow-empty -m "please"
    # Push changes back to remote vcs
    echo "Pushing changes..." && \
    git push $PUSH_URL HEAD:$TO_BRANCH && \
    echo "Merge complete!" || \
    echo "Error Occurred. Merge failed"
else
    echo "Not on $FROM_BRANCH. Skipping merge"
fi