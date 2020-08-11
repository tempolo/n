FROM centos:latest

RUN rm -rf /bin/sh && ln -sf /bin/bash /bin/sh
RUN dnf install -y epel-release
RUN dnf install -y curl wget unzip p7zip vim autoconf automake bzip2 bzip2-devel cmake clang gcc gcc-c++ git libtool make mercurial pkgconfig glibc-devel openssh openssh-server libbluray 
RUN rpm -ivh https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/l/libbluray-utils-1.1.2-3.fc32.x86_64.rpm
ADD init.sh /init.sh

USER whatever_heroku_will_rename_it
WORKDIR /home
CMD mkdir -p ~/.bin && bash /init.sh
