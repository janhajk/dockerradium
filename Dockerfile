FROM debian:stretch-slim

MAINTAINER janhajk <janhajk@gmail.com>



ENV PASSPHRASE <SECRET KEY>
ENV CLIENT_URL "https://github.com/RadiumCore/radium-0.11/archive/1.5.1.0.tar.gz"
ENV CLIENT_NAME "1.5.1.0"



RUN apt-get update

RUN apt-get install -y --no-install-recommends \
            wget \
            qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential \
            libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
            libboost-thread-dev libssl-dev libdb++-dev libminiupnpc-dev
            
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]
RUN groupadd -r radium && useradd -r -m -g radium radium
USER radium

VOLUME "/home/radium/.radium"

ENTRYPOINT ["/entrypoint.sh"]







