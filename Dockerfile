FROM thomasweise/docker-texlive-thin:1.0

#RUN apt-get install -y apt-utils

# fix locales to utf-8
RUN apt-get update && apt-get install -y locales
RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# install gnupg for validity checking of external repos
RUN apt-get update && apt-get install -y gnupg

# add node v12 repo:
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# install node, unzip, ssh tools and ruby
RUN apt-get update && apt-get install -y \
    nodejs openssh-client git p7zip zip unzip \
    rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists
    

RUN useradd -ms /bin/bash dockeruser

RUN npm config set prefix '/home/dockeruser/.npm-global'
# set npm to 6 to avoid npx problems
RUN npm install -g npm@6
