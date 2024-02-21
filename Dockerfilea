# Use Ubuntu 20.04.1 as the base image
FROM ubuntu:20.04

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables for Tomcat
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Download and extract Apache Tomcat
RUN wget -qO- https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.18/bin/apache-tomcat-10.1.18.tar.gz | tar xvz -C /opt

# Set up a directory for deployment
RUN mkdir -p /usr/local/tomcat/webapps/

# Copy the .war file into the Tomcat webapps directory
COPY target/ABCtechnologies-1.0.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container starts
CMD ["catalina.sh", "run"]
