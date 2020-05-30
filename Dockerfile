FROM ubuntu:latest

USER root

WORKDIR /dgr

ADD . /dgr

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/London

RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y python-setuptools
RUN apt install -y python3-pip
RUN apt-get install -y libsnappy-dev
RUN apt-get install -y python-requests python-boto
RUN apt install -y jupyter-core
RUN apt install -y jupyter-notebook
RUN pip3 install -r requirements.txt

ENV volumeid vol-0bd97fe1fde24b17c
ENV device /dev/xvdf
ENV region us-east-1f

ADD ebs-attach.py ebs-attach.py

ENTRYPOINT ["/usr/bin/python", "ebs-attach.py"]

EXPOSE 8888

CMD [ "jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=8888",  "--allow-root" ]