ARG app_name=sss

FROM maven:3.6.0-jdk-8 as maven
ARG app_name
WORKDIR /src
RUN apt update -y && apt install -y dh-make debhelper devscripts fakeroot

# Generating new simple web app
# RUN mvn archetype:generate \
#         -DgroupId=com.imaki.docker.example \
#         -DartifactId=ccc \
#         -DarchetypeArtifactId=maven-archetype-webapp \
#         -DinteractiveMode=false
COPY . .
RUN cd ${app_name} && mvn clean && mvn package && cd ..

# Creating deb package
RUN mkdir ${app_name}-1.0 && \
    cp Makefile ${app_name}-1.0 && \
    cp ${app_name}/target/${app_name}.war ${app_name}-1.0
#COPY Makefile/ ./ccc-0.1
RUN cd ${app_name}-1.0 && \
    export EMAIL="imaki@ss.com" && \
    export DEBFULLNAME="Igor Makienko" && \
    make package


FROM tomcat:8
ARG app_name
LABEL maintainer = "imaki" \
      description = "my tomcat-8 image with app.deb"

WORKDIR /home/project
COPY --from=maven /src/${app_name}-1.0/TMP/${app_name}_1.0_all.deb/ ./
RUN dpkg -i ${app_name}_1.0_all.deb && cp ${app_name}.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
