#!/bin/bash

# Tell bash to abort the script if any error happens
set -e

echo $PWD

APPNAME=__PROJECT_NAME__
PROJROOT=$PWD
DSTROOT="$PWD"/build

cd $PROJROOT

#build lua file and resources
#lua lua-compiler.lua -l -s "$PROJROOT"/workspace "$PROJROOT"/scripts

#build project
xcodebuild -sdk iphonesimulator6.1 \
           -arch i386 \
           -configuration Debug	\
           install DSTROOT="$DSTROOT"

waxsim "$DSTROOT"/Applications/"$APPNAME".app

