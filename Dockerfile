FROM phusion/baseimage:0.9.13
ENV HOME /root
RUN apt-get update
RUN apt-get install -y build-essential python-dev libmysqlclient-dev python-pip
RUN pip install twisted pyasn1 pycrypto MySQL-python
ADD kippo kippo
WORKDIR kippo
RUN rm /kippo/dl/.gitignore
ADD allow_root.patch kippo/allow_root.patch
RUN patch kippo.tac < allow_root.patch
ADD kippo.cfg kippo/kippo.cfg
EXPOSE 2222
CMD twistd -n -y kippo.tac
