#!/bin/bash

JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"
# Checksum from https://www.oracle.com/webfolder/s/digest/8u121checksum.html
CHECKSUM="97e30203f1aef324a07c94d9d078f5d19bb6c50e638e4492722debca588210bc"

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

