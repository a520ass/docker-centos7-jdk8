#!/bin/bash

JAVA_URL="http://www.jxgztv.com/u/videos/upload/vod2/jdk-8u212-linux-x64.rpm"
# Checksum via https://www.oracle.com/webfolder/s/digest/8u212checksum.html
CHECKSUM="9ce8693d39fa5fefee9a8a231b4ea3106de4c694c31b193ae06d8a6a0abda836"

curl \
	-L \
	-H "Connection: keep-alive" \
	-o /tmp/jdk.rpm \
	"${JAVA_URL}"

DOWNLOADED_CHECKSUM=`sha256sum /tmp/jdk.rpm | grep -o -E -e "[a-f0-9]*\s" | tr -d '[[:space:]]'`

echo "Checksum from Oracle is: ${CHECKSUM}"
echo "Downloaded checksum is: ${DOWNLOADED_CHECKSUM}"

if [ "${CHECKSUM}" != "${DOWNLOADED_CHECKSUM}" ]; then
	echo "Checksum verification failed; install aborted."
	rm /tmp/jdk.rpm
	exit 1
fi

yum install -y /tmp/jdk.rpm
rm /tmp/jdk.rpm

