#!/bin/sh


cd /radium

wget $CLIENT_URL

tar xzf 1.5.1.0.tar.gz -C /radium

cd /radium

qmake && make