#!/bin/sh
echo "Setting credentials"

if [ -z "${GITHUB_ACTOR}" ]
then
  echo "GITHUB_ACTOR environment variable is not set. This should specify the GitHub user that will interact with the Maven repository." >&2
  exit 1
fi

if [ -z "${GITHUB_TOKEN}" ]
then
  echo "GITHUB_TOKEN environment variable is not set. This should specify the token for the GitHub user." >&2
  exit 1
fi

# Ensure the Maven directory exists. This is normally not created until a Maven command is run, so
# this can lead to issues: https://stackoverflow.com/a/46983462/5278606
mkdir -p /root/.m2

echo "
<settings xmlns=\"http://maven.apache.org/SETTINGS/1.0.0\"
  xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
  xsi:schemaLocation=\"http://maven.apache.org/SETTINGS/1.0.0
                      http://maven.apache.org/xsd/settings-1.0.0.xsd\">
  <activeProfiles>
    <activeProfile>github</activeProfile>
  </activeProfiles>
  <profiles>
    <profile>
      <id>github</id>
      <repositories>
        <repository>
          <id>central</id>
          <url>https://repo1.maven.org/maven2</url>
        </repository>
        <repository>
          <id>github</id>
          <url>https://maven.pkg.github.com/cookinn/packages</url>
          <snapshots>
            <enabled>true</enabled>
          </snapshots>
        </repository>
      </repositories>
    </profile>
  </profiles>
  <servers>
    <server>
      <id>github</id>
      <username>${GITHUB_ACTOR}</username>
      <password>${GITHUB_TOKEN}</password>
    </server>
  </servers>
</settings>" > /root/.m2/settings.xml

echo "Credentials set"
