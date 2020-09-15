FROM python:3.8-slim-buster

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

RUN sed -i 's/main/main contrib non-free/' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -yu dist-upgrade && \
    apt-get -qq install sudo apt-utils locales && \
    apt-get -qq install curl wget libcurl4-openssl-dev bsdmainutils && \
    apt-get -qq install git nmap masscan && \
    apt-get -qq install curl wget python-pip python3-pip npm make && \
    apt-get -qq install csvkit ripgrep unzip chromium xsltproc 

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

WORKDIR /home/Osmedeus

COPY install.sh /home/Osmedeus
RUN cd /home/Osmedeus && ./install.sh

COPY requirements.txt /home/Osmedeus
RUN cd /home/Osmedeus && pip3 install -r requirements.txt

COPY . /home/Osmedeus/
RUN cd /home/Osmedeus && ./init_py_config.sh && \
    apt-get -y autoremove && \
    apt-get clean 


EXPOSE 8000