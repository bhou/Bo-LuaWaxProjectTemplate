#!/bin/bash
TEMPLATE_NAME="__PROJECT_NAME__"

cd ./lua-5.1.5/src

# build lua for iOS
make clean
make iphone
cp lua ../../$TEMPLATE_NAME/wax/bin
cp luac ../../$TEMPLATE_NAME/wax/bin
#cp liblua.a ../../$TEMPLATE_NAME/wax/bin

# build lua for running the the tool
make clean
make macosx
cp lua ../../bin
cp luac ../../bin
#cp lua ../../$TEMPLATE_NAME
#cp luac ../../$TEMPLATE_NAME

#cp liblua.a ../../bin
#cp liblua.a ../../$TEMPLATE_NAME



