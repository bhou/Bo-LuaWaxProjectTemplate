#!/bin/bash

# Tell bash to abort the script if any error happens
set -e


PROJ_PATH=$1

if [ -z "$PROJ_PATH" ]; then
	echo "Please specify the project path!"
	exit 1
fi

PROJ_NAME=$(basename $PROJ_PATH)

echo $PROJ_PATH

TEMPLATE_NAME="__PROJECT_NAME__"

# create the destination project
echo "Create project structure"
if [ ! -d "$PROJ_PATH" ]; then
	echo make dir $PROJ_PATH
	mkdir "$PROJ_PATH"
fi
cp -r $TEMPLATE_NAME/* $PROJ_PATH/
echo Finished creating project structure

echo Create project $PROJ_NAME to $PROJ_PATH

#silent mode
pwd
./bin/lua ./bin/replace.lua $PROJ_PATH/ $TEMPLATE_NAME $PROJ_NAME

#show log
#lua ./bin/replace.lua -l $PROJ_PATH/ $TEMPLATE_NAME $PROJ_NAME

echo DONE