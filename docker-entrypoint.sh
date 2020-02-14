#!/bin/bash

radiumpath=$HOME/radium

mkdir -p $radiumpath
wget --no-check-certificate --directory-prefix=$radiumpath/ $CLIENT_URL


tar xzvf $CLIENT_NAME.tar.gz -C $radiumpath
pushd $radiumpath/radium-0.11-$CLIENT_NAME/src

qmake && make