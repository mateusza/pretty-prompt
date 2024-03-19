#!/bin/bash

cp ./.bash_prompt ~/

if patch --quiet --dry-run --forward --reverse --batch -r /dev/null ~/.bashrc .bashrc.patch
then
    echo "Already installed."
    exit 0
fi

if patch --quiet --forward --batch -r /dev/null ~/.bashrc .bashrc.patch
then
    echo "Installed."
    exit 0
fi

echo "Unable to install."
echo "You can try to add this to your .bashrc manually:"

cat .bashrc.patch
