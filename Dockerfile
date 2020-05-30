FROM jupyter/scipy-notebook
#
# install deps/tools
#
RUN apt-get -q update 
RUN apt-get install -y python-requests python-boto

ENV volumeid vol-0bd97fe1fde24b17c
ENV device /dev/xvdf
ENV region us-east-1f

ADD ebs-attach.py ebs-attach.py

ENTRYPOINT ["/usr/bin/python", "ebs-attach.py"]
