FROM  debian:buster-slim
MAINTAINER amsaravi <mahdi.saravi@gmail.com>

# install important dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3 python3-pip git && \
    pip3 install waitress

# install recollcmd from recolls programmers website
RUN apt-get install -y --no-install-recommends gnupg
COPY recoll.gpg  /root/recoll.gpg
RUN gpg --import  /root/recoll.gpg
RUN gpg --export '7808CE96D38B9201' | apt-key add -
RUN apt-get install --reinstall -y ca-certificates
RUN apt-get update
RUN apt-get -y --with-new-pkgs --no-install-recommends upgrade
RUN echo deb http://www.lesbonscomptes.com/recoll/debian/ buster main > \
        /etc/apt/sources.list.d/recoll.list
RUN echo deb-src http://www.lesbonscomptes.com/recoll/debian/ buster main >> \
        /etc/apt/sources.list.d/recoll.list
RUN apt-get install  -y --no-install-recommends recollcmd python3-recoll
RUN apt autoremove

# install additional dependencies and software here
RUN apt-get install -y --no-install-recommends poppler-utils
RUN apt-get install -y --no-install-recommends unrtf antiword
RUN apt-get install -y --no-install-recommends unzip
RUN apt-get install -y --no-install-recommends tesseract-ocr
RUN apt-get clean

RUN mkdir /root/.recoll
COPY recoll.conf /root/.recoll/recoll.conf
RUN echo topdirs = /docs0 /docs1 /docs2 /docs3 /docs4 /docs5 /docs6 /docs7 /docs8 /docs9 >> /root/.recoll/recoll.conf
RUN echo ocrprogs = tesseract >> /root/.recoll/recoll.conf
RUN echo tesseractlang = eng+fra+spa+ger >> /root/.recoll/recoll.conf

RUN cd / && git clone https://framagit.org/medoc92/recollwebui.git

RUN mkdir /docs0 /docs1 /docs2 /docs3 /docs4 /docs5 /docs6 /docs7 /docs8 /docs9
VOLUME /docs0 /docs1 /docs2 /docs3 /docs4 /docs5 /docs6 /docs7 /docs8 /docs9 /root/.recoll
EXPOSE 8080

CMD ["/usr/bin/python3", "/recollwebui/webui-standalone.py", "-a", "0.0.0.0"]
