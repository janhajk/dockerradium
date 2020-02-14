#!/bin/bash

RADIUMPATH = $HOME/radium

mkdir -p $RADIUMPATH
wget --no-check-certificate --directory-prefix=$RADIUMPATH/ $CLIENT_URL


tar xzvf $CLIENT_NAME.tar.gz -C $RADIUMPATH
pushd $RADIUMPATH/radium-0.11-1.5.1.0/src

qmake && make