FROM debian:jessie-slim

MAINTAINER janhajk <janhajk@gmail.com>



ENV PASSPHRASE <SECRET KEY>
ENV CLIENT_URL "https://github.com/RadiumCore/radium-0.11/archive/1.5.1.0.tar.gz"
ENV CLIENT_NAME "1.5.1.0"



RUN apt-get update

RUN apt-get install -y --no-install-recommends \
            wget \
            nano \
            htop \
            sudo \
            qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential \
            libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
            libboost-thread-dev libdb++-dev libminiupnpc-dev

RUN echo "deb http://deb.debian.org/debian jessie main" > /etc/apt/sources.list \
   && echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list \
   && echo "deb http://deb.debian.org/debian jessie-updates main" >>  /etc/apt/sources.list
   
RUN apt-get update
RUN apt-get install -y --no-install-recommends libssl-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

RUN groupadd -r radium && useradd -r -m -g 100 -u 1024 radium

# user directory with blockchain and wallet
RUN mkdir -p /home/radium/.radium
RUN chown radium:radium /home/radium/.radium
WORKDIR /home/radium
VOLUME /home/radium/.radium
USER radium
COPY radium.conf /home/radium/


# /home/radium/radium for program
RUN mkdir -p /home/radium/radium
RUN wget --no-check-certificate --directory-prefix=/home/radium/radium/ $CLIENT_URL

RUN tar xzvf /home/radium/radium/$CLIENT_NAME.tar.gz -C $HOME/radium
RUN rm -rf /home/radium/radium/$CLIENT_NAME.tar.gz
RUN make -C /home/radium/radium/radium-0.11-$CLIENT_NAME/src -f makefile.unix USE_UPNP=



ENTRYPOINT ["/entrypoint.sh"]







