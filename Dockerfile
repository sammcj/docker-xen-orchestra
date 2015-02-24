FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /static /storage /app/conf

WORKDIR /app

# Install requirements as per https://github.com/vatesfr/xo/blob/master/doc/installation/manual_installation.md
RUN apt-get -qq update && \
    apt-get -qq install apt-transport-https curl lsb-release python-all rlwrap build-essential redis-server libpng-dev git python-minimal supervisor && \
    apt-get clean

RUN curl https://deb.nodesource.com/node/pool/main/n/nodejs/nodejs_0.10.31-1chl1~jessie1_amd64.deb > node.deb && \
    dpkg -i node.deb && rm node.deb

# Clone code
RUN git clone http://github.com/vatesfr/xo-server && \
    git clone http://github.com/vatesfr/xo-web && \
    rm -rf xo-server/.git xo-web/.git

# Build dependancies
RUN cd /app/xo-server && npm install --unsafe-perm && \
    cd /app/xo-web && npm install --unsafe-perm && \
    /app/xo-web/gulp --production && \
    rm -rf ~/.npm && npm cache clean

# Add configuration
ADD sample.config.yaml /app/xo-server/.xo-server.yaml

# Setup Supervisor to manage the application process
COPY supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 8000

CMD ["/usr/bin/supervisord"]
