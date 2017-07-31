FROM slemmen/ubuntu-base
MAINTAINER slemmen@gmail.com

# Install dependencies
RUN apt-get update \
    && apt-get install -qy git libssl-dev gcc make g++ 

# Build simc
RUN git clone https://github.com/simulationcraft/simc \
    && cd simc \
    && make BITS=64 OPENSSL=1 -C engine \
    && mv /simc/engine/simc /usr/local/bin/simc \
    && touch apikey.txt \
    && echo "p86sstj6dagb63hyru2pvpdv3nzrfxtn" > apikey.txt \
    && cd / \
    && rm -fr /simc \
    && mkdir -p /profiles \
    && mkdir -p /outputs \
    && apt-get remove -qy gcc g++ make \
    && apt-get clean -qy \
    && apt-get autoclean -qy \
    && apt-get autoremove -qy \
    && apt-get purge -qy \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log} 
    
VOLUME /profiles
VOLUME /outputs

ENTRYPOINT [ "/usr/local/bin/simc" ]
