FROM debian:jessie
MAINTAINER Jérôme Fafchamps (sMug [replicatorbe]) <smug@smug.fr>

RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -O - http://download.oracle.com/otn-pub/java/jdk/8u40-b26/server-jre-8u40-linux-x64.tar.gz | tar -zxf - -C /opt && \
  apt-get autoremove -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /opt/jdk1.8.0_40
ENV CLASSPATH $JAVA_HOME/lib:.
ENV PATH $PATH:$JAVA_HOME/bin

RUN cd /var/ && wget https://github.com/caelum/mamute/releases/download/v1.3.0/mamute-1.3.0.war && mkdir mamute && cp -r mamute-1.3.0.war /var/mamute && cd /var/mamute && jar xvf mamute-1.3.0.war
RUN chmod +x /var/mamute/run.sh

EXPOSE 80

CMD ["/var/mamute/run.sh"]