FROM alpine:latest

# Install Java and Maven
RUN apk add openjdk11 && apk add maven && export PATH=${PATH}:${JAVA_HOME}/bin

# Install Bash and GitHub
RUN apk add bash && apk add git

# Install Node.js and NPM
run apk add --update nodejs npm

COPY setCredentials.sh /data/setCredentials.sh
