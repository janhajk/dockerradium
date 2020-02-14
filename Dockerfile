FROM ubuntu:xenial

MAINTAINER janhajk <janhajk@gmail.com>


ARG USER_ID
ARG GROUP_ID

ENV HOME /radium

ENV SECRET <SECRET KEY>
ENV CLIENT_URL https://github.com/RadiumCore/radium-0.11/archive/1.5.1.0.tar.gz


# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} radium
RUN useradd -u ${USER_ID} -g radium -s /bin/bash -m -d /radium radium

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
            qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential \
            libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
            libboost-thread-dev libssl-dev libdb++-dev libminiupnpc-dev
            
RUN cd /

RUN wget $CLIENT_URL

RUN tar xzf 1.5.1.0.tar.gz -C /radium

RUN cd /radium

RUN qmake && make

WORKDIR /radium