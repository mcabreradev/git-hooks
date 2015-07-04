#!/bin/bash
# Prevents force-pushing to master

PUSH_COMMAND=`ps -ocommand= -p $PPID`
FORCE_PUSH="force|delete|-f"
FORBIDDEN_BRANCHES="^(master)$"
PROTECTED_BRANCHES="^(dev|release-*|patch-*)$"
BRANCH=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [[ $BRANCH =~ $FORBIDDEN_BRANCHES ]]; then
  echo "Prevented force-push to $BRANCH. This is a very dangerous command."
  echo "If you really want to do this, use --no-verify to bypass this pre-push hook."
  exit 1
fi
exit 1
if [[ $BRANCH =~ $PROTECTED_BRANCHES ]]; then
    read -p "You're about to push $BRANCH, is that what you intended? [y|n] " -n 1 -r < /dev/tty
    echo
    if echo $REPLY | grep -E '^[Yy]$' > /dev/null
    then
        exit 0 # push will execute
    fi
    exit 1 # push will not execute
else
    exit 0 # push will execute
fi
