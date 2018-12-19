#!/bin/bash

if [ -z $1 ];then
    echo "Missing Argument"
    exit 1
else
    UTILISATEUR=$1
    cp -rf /Users/$UTILISATEUR/French.lproj/ /System/Library/User\ Template/French.lproj/
    exit 0
fi