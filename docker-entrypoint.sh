#!/bin/sh

mkdir -p ${DATA_DIR}

cd $DATA_DIR

mkdir "radium_client"

wget $CLIENT_URL

tar xzvf $CLIENT_NAME.tar.gz -C radium_client

cd radium_client
cd radium*
cd src

qmake && make