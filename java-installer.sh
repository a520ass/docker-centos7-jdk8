#!/bin/bash

JAVA_URL="https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz"
# Checksum via https://www.oracle.com/webfolder/s/digest/8u172checksum.html
CHECKSUM="9a5c32411a6a06e22b69c495b7975034409fa1652d03aeb8eb5b6f59fd4594e0"

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
ln -s ${JDK_HOME} /usr/java/jdk1.8
echo "PATH=$PATH:/usr/java/jdk1.8/jre/bin:/usr/java/jdk1.8/bin" > /etc/profile.d/java
rm /tmp/jdk.tar.gz

