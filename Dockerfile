#FROM sonarqube:latest -- see http://stackoverflow.com/questions/36376968/manually-installing-sonarqube-plugins-on-docker-image
FROM webdizz/sonarqube:5.1.2

#Inspired by https://github.com/webdizz/docker-sonarqube-plugins/blob/master/Dockerfile
# and https://hub.docker.com/r/fernandinand/sonarqube/~/dockerfile/

ENV SONARQUBE_HOME /opt/sonar
ENV PLUGINS_DIR extensions/plugins

# list bundled plugins
RUN ls -la $SONARQUBE_HOME/lib/bundled-plugins
# remove bundled java, c#, js plugin
RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-java-plugin-*.jar
RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-csharp-plugin-*.jar
RUN rm -rf $SONARQUBE_HOME/lib/bundled-plugins/sonar-javascript-plugin-*.jar


#ENV JAVA_PLUGIN_VERSION 3.5
#RUN curl -sLo $SONARQUBE_HOME/$PLUGINS_DIR/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar \
#	https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-${JAVA_PLUGIN_VERSION}.jar

#ENV FINDBUGS_PLUGIN_VERSION 3.5
#RUN curl -sLo $SONARQUBE_HOME/$PLUGINS_DIR/sonar-findbugs-plugin-${FINDBUGS_PLUGIN_VERSION}.jar \
#	https://sonarsource.bintray.com/Distribution/sonar-findbugs-plugin/sonar-findbugs-plugin.jar

ENV PMD_PLUGIN_VERSION 2.4.1
RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
	curl -sLo sonar-pmd-plugin-${PMD_PLUGIN_VERSION}.jar \
    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/java/sonar-pmd-plugin/${PMD_PLUGIN_VERSION}/sonar-pmd-plugin-${PMD_PLUGIN_VERSION}.jar

#ENV JS_PLUGIN_VERSION 2.8
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar \
#    https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-${JS_PLUGIN_VERSION}.jar

ENV DELPHI_PLUGIN_VERSION 0.3.3
RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
	curl -sLo sonar-delphi-plugin-${DELPHI_PLUGIN_VERSION}.jar \
    https://github.com/fabriciocolombo/sonar-delphi/releases/download/${DELPHI_PLUGIN_VERSION}/sonar-delphi-plugin-${DELPHI_PLUGIN_VERSION}.jar

ENV CSHARP_PLUGIN_VERSION 5.1
RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
	curl -sLo sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar \
    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-csharp-plugin/${CSHARP_PLUGIN_VERSION}/sonar-csharp-plugin-${CSHARP_PLUGIN_VERSION}.jar

#ENV PYTHON_PLUGIN_VERSION 1.5
#RUN cd $SONARQUBE_HOME/$PLUGINS_DIR && \
#	curl -sLo sonar-python-plugin-${PYTHON_PLUGIN_VERSION}.jar \
#    http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/python/sonar-python-plugin/${PYTHON_PLUGIN_VERSION}/sonar-python-plugin-${PYTHON_PLUGIN_VERSION}.jar
    
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
	

