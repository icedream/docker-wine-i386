FROM icedream/debian-i386:jessie

RUN apt-get update &&\
	apt-get install -y wget wine32 &&\
	wget https://github.com/Yelp/dumb-init/releases/download/v1.0.0/dumb-init_1.0.0_amd64.deb -O/tmp/dumb-init.deb &&\
	dpkg -i /tmp/dumb-init.deb &&\
	apt-get clean &&\
	adduser --disabled-password --uid 9999 --home /app --gecos "" app &&\
	rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

USER app
WORKDIR /app
ENV WINEPREFIX /app/wine32
ENV WINEARCH win32
RUN dumb-init wine wineboot

ENTRYPOINT [ "wine" ]

