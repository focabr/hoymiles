ARG BUILD_FROM=homeassistant/amd64-base-python:3.11-alpine3.18
FROM $BUILD_FROM

ENV LANG C.UTF-8

#https://github.com/home-assistant/docker-base
# erro em amd64-base-python:3.9-alpine3.12

# Install requirements for add-on
#RUN apk add --no-cache python3 py3-pip 

RUN python -m pip install --upgrade pip
RUN pip3 install paho-mqtt==1.6.1
RUN pip3 install requests
RUN pip3 install python-dateutil

# Python 3 HTTP Server serves the current working dir
# So let's set it to our add-on persistent data directory.
WORKDIR /data

# other copy
COPY *.json /data/
COPY *.py /data/
COPY *.py /
#COPY *.html /

COPY templates /
COPY jsons /
COPY templates/* /data/templates/
COPY jsons/* /data/jsons/

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]