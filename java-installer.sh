#!/bin/bash

JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/8u141-b15/336fa29ff2bb4ef291e347e091f7f4a7/jdk-8u141-linux-x64.tar.gz"
# Checksum via https://www.oracle.com/webfolder/s/digest/8u141checksum.html
CHECKSUM="041d5218fbea6cd7e81c8c15e51d0d32911573af2ed69e066787a8dc8a39ba4f"

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

