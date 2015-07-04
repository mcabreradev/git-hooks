#!/bin/bash
# Prevents force-pushing to master

# BRANCH=`git rev-parse --abbrev-ref HEAD`
# PUSH_COMMAND=`ps -ocommand= -p $PPID`
# PROTECTED_BRANCHES="^(master|dev|release-*|patch-*)"
#
# if [[ "$BRANCH" == "$PROTECTED_BRANCHES" ]]; then
#   echo "Prevented force-push to $BRANCH. This is a very dangerous command."
#   echo "If you really want to do this, use --no-verify to bypass this pre-push hook."
#   exit 1
# fi
#
# exit 0

# BRANCH=`git rev-parse --abbrev-ref HEAD`
# PUSH_COMMAND=`ps -ocommand= -p $PPID`
# PROTECTED_BRANCHES="^(master|dev|release-*|patch-*)"
# FORCE_PUSH="force|delete|-f"
#
# if [[ "$BRANCH" =~ $PROTECTED_BRANCHES && "$PUSH_COMMAND" =~ $FORCE_PUSH ]]; then
#   echo "Prevented force-push to protected branch \"$BRANCH\" by pre-push hook"
#   exit 1
# fi
#
# exit 0


#!/bin/bash

# BRANCH=`git rev-parse --abbrev-ref HEAD`
# PUSH_COMMAND=`ps -ocommand= -p $PPID`
# PROTECTED_BRANCHES="^(master|dev|release-*|patch-*)$"
# FORCE_PUSH="force|delete|-f"

FORBIDDEN_BRANCHES="^(master)$"
PROTECTED_BRANCHES="^(dev|release-*|patch-*)$"
BRANCH=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [[ "$BRANCH" == "$FORBIDDEN_BRANCHES" ]]; then
  echo "Prevented force-push to $BRANCH. This is a very dangerous command."
  echo "If you really want to do this, use --no-verify to bypass this pre-push hook."
  exit 1
fi

if [[ $BRANCH =~ $PROTECTED_BRANCHES ]]
then
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
