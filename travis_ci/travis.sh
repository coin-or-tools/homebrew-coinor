#!/bin/bash
set -e

if [ "$TRAVIS_PULL_REQUEST" ==  "false" ]
then
    export changed_files=`git diff-tree --no-commit-id --name-only -r $TRAVIS_COMMIT | grep .rb `
else
    git fetch origin pull/${TRAVIS_PULL_REQUEST}/head:travis-pr-${TRAVIS_PULL_REQUEST}
    git checkout travis-pr-${TRAVIS_PULL_REQUEST}
    tput setaf 2
    echo -e "Travis commit: $TRAVIS_COMMIT"
    echo -e "$(git log -1)"
    tput sgr0
    export changed_files=`git diff-tree --no-commit-id --name-only HEAD^ HEAD | grep .rb`
fi

tput setaf 2; echo -e "Formulae to build: $changed_files"; tput sgr0;
for file in $changed_files
do
    brew test-bot $file --skip-setup --keep-logs
done
