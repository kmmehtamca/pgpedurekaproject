# Use Ubuntu as the base image
FROM ubuntu:20.04

# Install software-properties-common package required for add-apt-repository
 RUN apt-get update && \
 apt-get install -y software-properties-common && \
 apt-get clean
 
# Add the OpenJDK PPA repository
RUN add-apt-repository ppa:openjdk-r/ppa
# Install fontconfig, OpenJDK 17 JRE, and OpenJDK 17 JDK
RUN apt-get update && \
 apt-get install -y fontconfig openjdk-17-jre openjdk-17-jdk
RUN apt-get clean

# Clean up package cache
#RUN apt-get clean
#RUN apt-get install -f
#RUN apt-cache search openjdk17
#RUN apt-get install wget -y


# Optionally, set environment variables if needed
# ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk-amd64
  

# Set environment variables
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Download and extract Apache Tomcat
WORKDIR /tmp
ADD https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.19/bin/apache-tomcat-10.1.19.tar.gz /tmp

RUN tar -xf apache-tomcat-10.1.19.tar.gz && \
    mv apache-tomcat-10.1.19 $CATALINA_HOME && \
    rm apache-tomcat-10.1.19.tar.gz

# Copy the WAR file to the webapps directory
#COPY target/ABCtechnologies-1.0.war  $CATALINA_HOME/webapps/
#COPY "/var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war" \
    # "$CATALINA_HOME/webapps/"
#COPY /var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war $CATALINA_HOME/webapps/
 #COPY "/var/lib/jenkins/workspace/CI_CD_PipelineGiT/target/ABCtechnologies-1.0.war" "$CATALINA_HOME/webapps/"
# ADD "/var/lib/jenkins/workspace/CI_CD pipleline/target/ABCtechnologies-1.0.war" "$CATALINA_HOME/webapps/ABCtechnologies-1.0.war"

COPY target/ABCtechnologies-1.0.war $CATALINA_HOME/webapps/
                   
# Expose port 8080
EXPOSE 8080

# Start Tomcat
ENTRYPOINT ["catalina.sh", "run"]
