FROM jenkins
# if we want to install via apt
USER root

RUN apt-get -yqq update && apt-get -yqq install docker.io && usermod -g docker jenkins
VOLUME /var/run/docker.sock
ENTRYPOINT groupmod -g $(stat -c "%g" /var/run/docker.sock) docker && usermod -u $(stat -c "%u" /var/jenkins_home) jenkins && gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh


# drop back to the regular jenkins user - good practice
USER jenkins