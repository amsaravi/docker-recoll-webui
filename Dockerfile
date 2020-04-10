FROM debian:buster-slim
MAINTAINER amsaravi

Run gpg --keyserver pool.sks-keyservers.net --recv-key F8E3347256922A8AE767605B7808CE96D38B9201
Run gpg --export '7808CE96D38B9201' | sudo apt-key add -

RUN echo deb http://www.lesbonscomptes.com/recoll/debian/ buster main > \
	/etc/apt/sources.list.d/recoll.list

RUN echo deb-src http://www.lesbonscomptes.com/recoll/debian/ buster main >> \
	/etc/apt/sources.list.d/recoll.list

RUN apt-get update && \
    apt-get install -y --no-install-recommends recollcmd python3-recoll python3 python3-pip git wv poppler-utils && \
    pip3 install waitress && \
    apt-get install -y unzip  unrtf antiword && \
    apt-get clean

RUN mkdir /homes && mkdir /root/.recoll

RUN cd / && git clone https://framagit.org/medoc92/recollwebui.git

VOLUME /homes
EXPOSE 8080

CMD ["/usr/bin/python3", "/recollwebui/webui-standalone.py", "-a", "0.0.0.0"]
