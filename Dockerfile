FROM jenkins/jenkins:alpine
# if we want to install via apt
USER root

RUN apk add --no-cache docker bash shadow jq

VOLUME /var/lib/docker

ENTRYPOINT  usermod -u $(stat -c "%u" /var/jenkins_home) jenkins && /usr/local/bin/jenkins.sh

# drop back to the regular jenkins user - good practice
USER jenkins
