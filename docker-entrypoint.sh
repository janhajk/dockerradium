#!/bin/sh

mkdir -p $HOME/radium
wget $CLIENT_URL


tar xzvf $CLIENT_NAME.tar.gz -C ${HOME}/radium
cd $HOME/radium/radium-0.11-1.5.1.0/src

qmake && make