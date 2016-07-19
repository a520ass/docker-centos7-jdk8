#!/bin/bash

# Checksum from https://www.oracle.com/webfolder/s/digest/8u102checksum.html
CHECKSUM="7cfbe0bc0391a4abe60b3e9eb2a541d2315b99b9cb3a24980e618a89229e04b7"

curl \
	-L \
	-H "Cookie: oraclelicense=accept-securebackup-cookie" \
	-o /tmp/jdk.tar.gz \
	"${JAVA_URL}"

DOWNLOADED_CHECKSUM=`sha256sum /tmp/jdk.tar.gz | grep -o -E -e "[a-f0-9]*\s" | tr -d '[[:space:]]'`

echo "Checksum from Oracle is: ${CHECKSUM}"
echo "Downloaded checksum is: ${DOWNLOADED_CHECKSUM}"

if [ "${CHECKSUM}" != "${DOWNLOADED_CHECKSUM}" ]; then
	echo "Checksum verification failed; install aborted."
	rm /tmp/jdk.tar.gz
	exit 1
fi

mkdir -p /usr/java
tar -xzf /tmp/jdk.tar.gz -C /usr/java
chown -R root:root ${JDK_HOME}
rm /tmp/jdk.tar.gz

