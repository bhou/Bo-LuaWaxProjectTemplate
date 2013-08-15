#!/bin/bash

# Tell bash to abort the script if any error happens
set -e

ROOT=$(dirname $0)
echo "Project ROOT = $ROOT"

APPNAME=__PROJECT_NAME__


PROJROOT=$PWD/$ROOT
DSTROOT=$PWD/$ROOT/build

cd $PROJROOT

#clean the scripts
if [ "$(ls -A $PROJROOT/scripts/*)" ]; then
	rm -r "$PROJROOT"/scripts/*
else
	echo $PROJROOT/scripts is empty
fi

#build lua file and resources
./lua lua-compiler.lua -l -s "$PROJROOT"/workspace "$PROJROOT"/scripts

#build project
xcodebuild -sdk iphonesimulator6.1 \
           -arch i386 \
           -configuration Debug	\
           install DSTROOT="$DSTROOT"

waxsim "$DSTROOT"/Applications/"$APPNAME".app

