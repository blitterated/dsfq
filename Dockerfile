FROM dirty

MAINTAINER blitterated blitterated@protonmail.com

RUN apt update
RUN apt --yes upgrade

RUN apt --yes install python3 flac

ARG SFQ_DIR=/opt/sfq
RUN mkdir "$SFQ_DIR"
WORKDIR "$SFQ_DIR"
RUN curl "https://raw.githubusercontent.com/pahandav/sfq/master/sfq.py" -o sfq && chmod +x sfq

RUN echo "PATH=$PATH:$SFQ_DIR" >> /root/.bashrc

WORKDIR /root
ENTRYPOINT ["/opt/sfq/sfq"]
