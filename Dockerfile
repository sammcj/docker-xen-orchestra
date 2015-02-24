FROM nodesource/jessie

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /static /storage /app/conf

WORKDIR /app

# Install requirements as per https://github.com/vatesfr/xo/blob/master/doc/installation/manual_installation.md
RUN apt-get -qq update && \
    apt-get -qq install build-essential redis-server libpng-dev git python-minimal supervisor && \
    apt-get clean

# Clone code
RUN git clone http://github.com/vatesfr/xo-server && \
    git clone http://github.com/vatesfr/xo-web && \
    rm -rf xo-server/.git xo-web/.git

# Add configuration
ADD sample.config.yaml /app/xo-server/.xo-server.yaml

# Build dependancies
RUN cd /app/xo-server && npm install -g && \
    cd /app/xo-web && npm install -g && \
    ./gulp --production && \
    rm -rf ~/.npm && npm cache clean

# Setup Supervisor to manage the application process
COPY supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 8000

CMD ["/usr/bin/supervisord"]
