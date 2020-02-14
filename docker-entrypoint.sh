#!/bin/bash

mkdir -p $HOME/radium
wget --no-check-certificate $CLIENT_URL


tar xzvf $CLIENT_NAME.tar.gz -C ${HOME}/radium
pushd $HOME/radium/radium-0.11-1.5.1.0/src

qmake && make