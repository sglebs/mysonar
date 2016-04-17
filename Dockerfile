#We could not use: FROM sonarqube:latest 
# because of VOLUME, we could not install plugin extensions -- see http://stackoverflow.com/questions/36376968/manually-installing-sonarqube-plugins-on-docker-image
#We could not use FROM webdizz/sonarqube:5.1.2
#because it runs Java with just 768Mb
#Inspired by https://github.com/webdizz/docker-sonarqube-plugins/blob/master/Dockerfile
# and https://hub.docker.com/r/fernandinand/sonarqube/~/dockerfile/
#
# BEGIN COPY OF FROM sonarqube:5.4
FROM java:openjdk-8u45-jdk

MAINTAINER David Gageot <david.gageot@sonarsource.com>

ENV SONARQUBE_HOME /opt/sonarqube

# Http port
EXPOSE 9000

# Database configuration
# Defaults to using H2
ENV SONARQUBE_JDBC_USERNAME sonar
ENV SONARQUBE_JDBC_PASSWORD sonar
ENV SONARQUBE_JDBC_URL jdbc:h2:tcp://localhost:9092/sonar

ENV SONAR_VERSION 5.4

# pub   2048R/D26468DE 2015-05-25
#       Key fingerprint = F118 2E81 C792 9289 21DB  CAB4 CFCA 4A29 D264 68DE
# uid                  sonarsource_deployer (Sonarsource Deployer) <infra@sonarsource.com>
# sub   2048R/06855C1D 2015-05-25
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE

RUN set -x \
	&& cd /opt \
	&& curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
	&& curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
	&& gpg --batch --verify sonarqube.zip.asc sonarqube.zip \
	&& unzip sonarqube.zip \
	&& mv sonarqube-$SONAR_VERSION sonarqube \
	&& rm sonarqube.zip* \
	&& rm -rf $SONARQUBE_HOME/bin/*

# END COPY OF FROM sonarqube:5.4

ENV PLUGINS_DIR extensions/plugins
ENV JAVA_OPTS "-Xmx1024m -XX:MaxPermSize=512m -XX:ReservedCodeCacheSize=128m"

# list bundled plugins
RUN ls -la $SONARQUBE_HOME/lib/bundled-plugins
# remove bundled java, c#, js plugin
#RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-java-plugin-*.jar
#RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-csharp-plugin-*.jar
#RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-javascript-plugin-*.jar

#ENV JAVA_PLUGIN_VERSION 3.10
#RUN curl -sLo $SONARQUBE_HOME/$PLUGINS_DIR/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar \
#	https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar

#ENV CSHARP_PLUGIN_VERSION 4.4
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-csharp-plugin/${CSHARP_PLUGIN_VERSION}/sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar

#ENV JS_PLUGIN_VERSION 2.10
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar \
#    https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar

#ENV FINDBUGS_PLUGIN_VERSION 3.5
#RUN curl -sLo $SONARQUBE_HOME/$PLUGINS_DIR/sonar-findbugs-plugin-${FINDBUGS_PLUGIN_VERSION}.jar \
#	https://sonarsource.bintray.com/Distribution/sonar-findbugs-plugin/sonar-findbugs-plugin.jar

#ENV PMD_PLUGIN_VERSION 2.4.1
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-pmd-plugin-${PMD_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/java/sonar-pmd-plugin/${PMD_PLUGIN_VERSION}/sonar-pmd-plugin-${PMD_PLUGIN_VERSION}.jar


ENV DELPHI_PLUGIN_VERSION 0.3.3
RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
	curl -sLo sonar-delphi-plugin-${DELPHI_PLUGIN_VERSION}.jar \
    https://github.com/fabriciocolombo/sonar-delphi/releases/download/${DELPHI_PLUGIN_VERSION}/sonar-delphi-plugin-${DELPHI_PLUGIN_VERSION}.jar


ENV PYTHON_PLUGIN_VERSION 1.5
RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
	curl -sLo sonar-python-plugin-${PYTHON_PLUGIN_VERSION}.jar \
    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/python/sonar-python-plugin/${PYTHON_PLUGIN_VERSION}/sonar-python-plugin-${PYTHON_PLUGIN_VERSION}.jar
    
#ENV BUILD_BREAKER_PLUGIN_VERSION 1.1
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-build-breaker-plugin-${BUILD_BREAKER_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-build-breaker-plugin/${BUILD_BREAKER_PLUGIN_VERSION}/sonar-build-breaker-plugin-${BUILD_BREAKER_PLUGIN_VERSION}.jar

#ENV GENERIC_COVERAGE_PLUGIN_VERSION 1.1
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-generic-coverage-plugin-${GENERIC_COVERAGE_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-generic-coverage-plugin/${GENERIC_COVERAGE_PLUGIN_VERSION}/sonar-generic-coverage-plugin-${GENERIC_COVERAGE_PLUGIN_VERSION}.jar
    
#ENV MOTION_CHART_PLUGIN_VERSION 1.7
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-motion-chart-plugin-${MOTION_CHART_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-motion-chart-plugin/${MOTION_CHART_PLUGIN_VERSION}/sonar-motion-chart-plugin-${MOTION_CHART_PLUGIN_VERSION}.jar

#ENV WEB_PLUGIN_VERSION 2.4
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-web-plugin-${WEB_PLUGIN_VERSION}.jar \
#    https://sonarsource.bintray.com/Distribution/sonar-web-plugin/sonar-web-plugin-${WEB_PLUGIN_VERSION}.jar

#ENV TIMELINE_PLUGIN_VERSION 1.5
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-timeline-plugin-${TIMELINE_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-timeline-plugin/${TIMELINE_PLUGIN_VERSION}/sonar-timeline-plugin-${TIMELINE_PLUGIN_VERSION}.jar
	
	
# BEGIN COPY OF FROM sonarqube:5.4

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]

# END COPY OF FROM sonarqube:5.4



