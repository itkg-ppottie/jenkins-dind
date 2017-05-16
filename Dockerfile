FROM jenkins
# if we want to install via apt
USER root

RUN apt-get -yqq update && \
    apt-get -yqq install \
         apt-transport-https \
         ca-certificates \
         curl \
         gnupg2 \
         usermode \
         software-properties-common &&  \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get -yqq update && \
     apt-get -yqq install docker-ce && usermod -g docker jenkins

VOLUME /var/lib/docker

RUN rm -rf /var/lib/apt/lists/*
ENTRYPOINT  usermod -u $(stat -c "%u" /var/jenkins_home) jenkins && /usr/local/bin/jenkins.sh

# drop back to the regular jenkins user - good practice
USER jenkins