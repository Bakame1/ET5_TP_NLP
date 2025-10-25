#FROM nvcr.io/nvidia/tensorflow:22.01-tf2-py3
FROM ubuntu:20.04
LABEL maintainer "TensorflowDock"

USER root

ENV TZ=Europe/Paris
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install some dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get update && apt-get install -y apt-utils  \
            bc  \
            build-essential  \
            cmake  \
            curl  \
            g++  \
            screen  \
            python3-dev  \
            python3-tk  \
            python3-numpy  \
            python3-virtualenv  \
            python3-pip \
            ant  \
            vim  \
            bash  \
            locate  \
            locales \
            sudo  \
            doxygen  \
            libfftw3-dev  \
            libsox-dev \
            htop \
            git \
            rsync             
            
RUN apt-get clean && apt-get autoremove 

RUN locale-gen fr_FR.UTF-8
RUN update-locale LANG=fr_FR.UTF-8


RUN mkdir -m 777 -pv /DEV/Tools

RUN git clone --recursive https://github.com/facebookresearch/fastText.git /DEV/Tools/fastText
RUN cd /DEV/Tools/fastText && mkdir build && cd build && cmake .. && make -j && make install 

RUN python3 -m pip install --upgrade subword-nmt transformers pip

RUN useradd -ms /bin/bash nlp
RUN echo nlp:azerty | chpasswd
RUN usermod -u 1000 nlp && usermod -G sudo nlp && usermod -g 1000 nlp


#USER nlp
#RUN echo "defshell -bash" >> /home/nlp/.screenrc

WORKDIR /home/nlp


USER nlp
VOLUME /home/nlp/ /home/nlp/

