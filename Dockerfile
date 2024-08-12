FROM centos:7
MAINTAINER TerriHamLz
LABEL version="1.0" location="India" type="centos-with-ssh"

# Remove the existing CentOS-Base.repo and create a new one using printf
RUN rm -f /etc/yum.repos.d/CentOS-Base.repo && \
    printf '[base]\n\
name=CentOS-$releasever - Base\n\
baseurl=http://vault.centos.org/7.9.2009/os/$basearch/\n\
gpgcheck=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n\n\
[updates]\n\
name=CentOS-$releasever - Updates\n\
baseurl=http://vault.centos.org/7.9.2009/updates/$basearch/\n\
gpgcheck=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n\n\
[extras]\n\
name=CentOS-$releasever - Extras\n\
baseurl=http://vault.centos.org/7.9.2009/extras/$basearch/\n\
gpgcheck=1\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n\n\
[centosplus]\n\
name=CentOS-$releasever - Plus\n\
baseurl=http://vault.centos.org/7.9.2009/centosplus/$basearch/\n\
gpgcheck=1\n\
enabled=0\n\
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7\n' > /etc/yum.repos.d/CentOS-Base.repo

# Update and install necessary packages
RUN yum update -y && \
    yum install -y gcc openssl-devel bzip2-devel libffi-devel zlib-devel wget make

RUN yum install openssh* -y;yum install vim -y;yum install initscripts -y;
# Download and install Python 3.9.16
RUN wget https://www.python.org/ftp/python/3.9.16/Python-3.9.16.tgz && \
    tar xzf Python-3.9.16.tgz && \
    cd Python-3.9.16 && \
    ./configure --enable-optimizations && \
    make altinstall

# Restart SSH service
RUN service sshd restart

# Expose SSH port
EXPOSE 22

# Create and set permissions for /data directory
VOLUME ["/data"]
COPY . /data
RUN chmod +x /data/red.sh
WORKDIR /root
USER root
ENTRYPOINT //data/red.sh && /bin/bash 
