FROM alpine:3.9

MAINTAINER Matthew Green <thematthewgreen@gmail.com>

RUN echo "===> Install Python3 ..."  && \
    apk add --no-cache python3 python3-dev && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache && \
    \
    \
    echo "===> Base install ..." && \
    apk --update add sudo bash git openssl ca-certificates py3-cffi && \
    apk --update add --virtual build-dependencies libffi-dev openssl-dev build-base&& \
    \
    \
    echo "===> Install Ansible ..." && \
    pip install ansible==2.7.8 && \
    pip install ansible-lint==4.1.0 && \
    \
    \
    echo "===> Install other handy tools ..." && \
    pip install --upgrade pycrypto pywinrm && \
    apk --update add sshpass openssh-client rsync && \
    \
    \
    echo "===> Removing package list ..." && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    \
    \
    echo "===> Adding hosts for convenience ..." && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# default command: display Ansible version
CMD [ "ansible-playbook", "--version" ]
