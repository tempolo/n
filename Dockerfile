FROM centos:latest

RUN rm -rf /bin/sh && ln -sf /bin/bash /bin/sh
RUN dnf -y install epel-release
RUN dnf install -y http://repo.okay.com.mx/centos/8/x86_64/release/okay-release-1-1.noarch.rpm
RUN yum install -y curl wget unzip p7zip vim autoconf automake bzip2 bzip2-devel cmake clang gcc gcc-c++ git libtool make mercurial pkgconfig glibc-devel openssh openssh-server libbluray-utils 
ADD init.sh /init.sh

USER whatever_heroku_will_rename_it
WORKDIR /home
CMD mkdir -p ~/.bin && bash /init.sh
