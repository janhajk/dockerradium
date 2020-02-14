#!/bin/bash

radiumpath=$HOME/radium

mkdir -p $radiumpath
wget --no-check-certificate --directory-prefix=$HOME/ $CLIENT_URL

tar xzvf $HOME/$CLIENT_NAME.tar.gz -C $radiumpath
pushd $radiumpath/radium-0.11-$CLIENT_NAME/src

make -f makefile.unix USE_UPNP=

~/radium/radium-0.11-1.5.1.0/src/radiumd > /dev/null &

