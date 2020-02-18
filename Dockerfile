FROM debian:jessie-slim

MAINTAINER janhajk <janhajk@gmail.com>



ENV PASSPHRASE <SECRET KEY>
ENV CLIENT_URL "https://github.com/RadiumCore/radium-0.11/archive/1.5.1.0.tar.gz"
ENV CLIENT_NAME "1.5.1.0"



RUN apt-get update

RUN apt-get install -y --no-install-recommends \
            wget \
            nano \
            sudo \
            qt5-default qt5-qmake qtbase5-dev-tools qttools5-dev-tools build-essential \
            libboost-dev libboost-system-dev libboost-filesystem-dev libboost-program-options-dev \
            libboost-thread-dev libdb++-dev libminiupnpc-dev

#RUN echo -e "# deb http://snapshot.debian.org/archive/debian/20200130T000000Z jessie main\ndeb http://deb.debian.org/debian jessie main\n# deb http://snapshot.debian.org/archive/debian-security/20200130T000000Z jessie/updates main\n\ndeb http://security.debian.org/debian-security jessie/updates main\n# deb http://snapshot.debian.org/archive/debian/20200130T000000Z jessie-updates main\ndeb http://deb.debian.org/debian jessie-updates main" > /etc/apt/sources.list
RUN echo "deb http://deb.debian.org/debian jessie main" > /etc/apt/sources.list \
   && echo "deb http://security.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list \
   && echo "deb http://deb.debian.org/debian jessie-updates main" >>  /etc/apt/sources.list
   
RUN apt-get update
RUN apt-get install -y --no-install-recommends libssl-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

RUN groupadd -r radium && useradd -r -m -g 1024 radium

# user directory with blockchain and wallet
RUN mkdir -p /home/radium/data
WORKDIR /home/radium
VOLUME /home/radium/data
USER radium
RUN mkdir -p /home/radium/data/.radium


# /home/radium/radium for program
RUN mkdir -p /home/radium/radium
RUN wget --no-check-certificate --directory-prefix=/home/radium/radium/ $CLIENT_URL

RUN tar xzvf /home/radium/radium/$CLIENT_NAME.tar.gz -C $HOME/radium
RUN rm -rf /home/radium/radium/$CLIENT_NAME.tar.gz
RUN make -C /home/radium/radium/radium-0.11-$CLIENT_NAME/src -f makefile.unix USE_UPNP=


RUN echo "rpcuser=radiumrpc" > /home/radium/.radium/radium.conf
RUN echo "rpcpassword=59ZqfkHebhtHbVJS2CSxk6LEjxZS1E5GTumGxqbjfbWn" >> /home/radium/.radium/radium.conf
RUN echo "addnode=100.4.218.251" >> /home/radium/.radium/radium.conf
RUN echo "addnode=104.156.251.173" >> /home/radium/.radium/radium.conf
RUN echo "addnode=104.207.154.234" >> /home/radium/.radium/radium.conf
RUN echo "addnode=107.15.220.153" >> /home/radium/.radium/radium.conf
RUN echo "addnode=109.206.213.143" >> /home/radium/.radium/radium.conf
RUN echo "addnode=109.89.234.67" >> /home/radium/.radium/radium.conf
RUN echo "addnode=110.168.53.98" >> /home/radium/.radium/radium.conf
RUN echo "addnode=115.87.138.10" >> /home/radium/.radium/radium.conf
RUN echo "addnode=12.25.150.130" >> /home/radium/.radium/radium.conf
RUN echo "addnode=13.209.243.246" >> /home/radium/.radium/radium.conf
RUN echo "addnode=134.19.189.68" >> /home/radium/.radium/radium.conf
RUN echo "addnode=135.23.228.90" >> /home/radium/.radium/radium.conf
# RUN echo "" >> /home/radium/.radium/radium.conf

ENTRYPOINT ["/entrypoint.sh"]







