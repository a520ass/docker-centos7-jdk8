#!/bin/bash

JAVA_URL="http://hffile.oss-cn-hangzhou.aliyuncs.com/jdk-8u211-linux-x64.rpm"
# Checksum via https://www.oracle.com/webfolder/s/digest/8u211checksum.html
CHECKSUM="6e0274e95edb94e1cabf091c7c6035e22256080f746ba605958c961a5fd032fb"

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

