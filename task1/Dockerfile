FROM maven:3.6.0-jdk-8 as maven
WORKDIR /src
RUN apt update -y && apt install -y dh-make debhelper devscripts fakeroot

# Generating new simple web app
# RUN mvn archetype:generate \
#         -DgroupId=com.imaki.docker.example \
#         -DartifactId=ccc \
#         -DarchetypeArtifactId=maven-archetype-webapp \
#         -DinteractiveMode=false
COPY . .
RUN cd ccc && mvn clean && mvn package && cd ..

# Creating deb package
RUN mkdir ccc-1.0 && \
    cp Makefile ccc-1.0 && \
    cp ccc/target/ccc.war ccc-1.0
#COPY Makefile/ ./ccc-0.1
RUN cd ccc-1.0 && \
    export EMAIL="imaki@ss.com" && \
    export DEBFULLNAME="Igor Makienko" && \
    make package


FROM tomcat:8

LABEL maintainer = "imaki" \
      description = "my tomcat-8 image with app.deb"

WORKDIR /home/project
COPY --from=maven /src/ccc-1.0/TMP/ccc_1.0_all.deb/ ./
RUN dpkg -i ccc_1.0_all.deb && cp ccc.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
