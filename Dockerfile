FROM centos:centos7
MAINTAINER Przemyslaw Ozgo linux@ozgo.info

ENV SONARQUBE_HOME=/opt/sonarqube \
    SONARQUBE_JDBC_USERNAME=sonar \
    SONARQUBE_JDBC_PASSWORD=sonar \
    SONARQUBE_JDBC_URL=jdbc:h2:tcp://localhost:9092/sonar \
    SONAR_VERSION=5.1.2 \
    SONAR_DOWNLOAD_URL=https://sonarsource.bintray.com/Distribution

RUN \
  gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE && \
  rpm --rebuilddb && yum clean all && \
  yum install -y \
  java-1.8.0-openjdk-devel \
  unzip && \
  yum clean all && \
  set -x && \
	cd /opt && \
	curl -o sonarqube.zip -fSL http://downloads.sonarsource.com/sonarqube/sonarqube-${SONAR_VERSION}.zip && \
	curl -o sonarqube.zip.asc -fSL http://downloads.sonarsource.com/sonarqube/sonarqube-${SONAR_VERSION}.zip.asc && \
	gpg --verify sonarqube.zip.asc && \
	unzip sonarqube.zip && \
	mv sonarqube-${SONAR_VERSION} sonarqube && \
  rm sonarqube.zip* && \
	rm -rf ${SONARQUBE_HOME}/bin/* && \
  mkdir -p /opt/sonarqube/extensions/plugins/ && \
  cd /opt/sonarqube/extensions/plugins/ && \
  curl -o sonar-java-plugin-3.5.jar -fSL ${SONAR_DOWNLOAD_URL}/sonar-java-plugin/sonar-java-plugin-3.5.jar && \
  curl -o sonar-web-plugin-2.4.jar -fSL ${SONAR_DOWNLOAD_URL}/sonar-web-plugin/sonar-web-plugin-2.4.jar && \
  curl -o sonar-scm-git-plugin-1.1.jar -fSL http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-scm-git-plugin/1.1/sonar-scm-git-plugin-1.1.jar

COPY run.sh ${SONARQUBE_HOME}/bin/

VOLUME ["${SONARQUBE_HOME}/data", "${SONARQUBE_HOME}/extensions"]

ENTRYPOINT ["./opt/sonarqube/bin/run.sh"]

EXPOSE 9000 9002
