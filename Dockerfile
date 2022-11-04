FROM alpine:latest

MAINTAINER hotpot_sculler0p@icloud.com

ENV PATH=$PATH:/usr/bin

RUN apk update && apk add bash python3 py3-pip curl unzip font-noto ffmpeg && \
    cd /tmp && curl "https://fonts.google.com/download?family=Roboto" -o Roboto.zip && \
    mkdir /usr/share/fonts/Roboto && cd /usr/share/fonts/Roboto && \
    unzip /tmp/Roboto.zip && fc-cache -fv && mkdir /videos && cd /

RUN pip install gopro-overlay

WORKDIR /videos

COPY entrypoint.sh /

CMD [ "/entrypoint.sh", "$@" ]
