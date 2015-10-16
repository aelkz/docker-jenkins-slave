FROM java:8-jdk
USER root

RUN apt-get update && apt-get install -yq xvfb # for all GUIs
RUN apt-get update && apt-get install -yq git
RUN apt-get update && apt-get install -yq octave octave-io libjexcelapi-java # for Octave and JXL support, on this new version "octave-java" is integrated in core-octave already
RUN apt-get update && apt-get install -yq build-essential
RUN apt-get update && apt-get install -yq m4
RUN apt-get update && apt-get install -yq mysql-client

RUN mkdir /jenkins && groupadd -r jenkins -g 999 && useradd -u 999 -r -g jenkins -d /jenkins -s /sbin/nologin -c "Docker image user" jenkins

COPY startup.sh /usr/local/bin/
COPY settings.xml /jenkins/.m2/
RUN chown -R jenkins:jenkins /jenkins

ENV DISPLAY :1

USER jenkins
WORKDIR /jenkins

ENTRYPOINT ["/usr/local/bin/startup.sh"]

