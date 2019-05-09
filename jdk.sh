#!/bin/bash


set -e 

INSTALL_DIR=$HOME/java
DOWNLOAD_LINK="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz"
TAR=openjdk-12.0.1.tar
GZ=${TAR}.gz
LOCAL_NAME=jdk12

darwin=false
case "`uname`" in
  Darwin* )
    darwin=true
	DOWNLOAD_LINK="https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_osx-x64_bin.tar.gz"
    ;;
esac


downloadTarball() {
	[ -e $INSTALL_DIR/$LOCAL_NAME ] && echo "$INSTALL_DIR/$LOCAL_NAME already exists - skipping download" && return 0;
	mkdir -p $INSTALL_DIR
	pushd $INSTALL_DIR
	wget -O $GZ $DOWNLOAD_LINK
	gunzip $GZ

	mkdir $LOCAL_NAME && tar xf $TAR -C $LOCAL_NAME --strip-components 2

	rm $TAR
	echo "jdk extracted at $INSTALL_DIR/$LOCAL_NAME"
	echo "you will want to export JAVA_HOME=$INSTALL_DIR/$LOCAL_NAME/Contents/Home (on mac)"
	ls $PWD
	popd $INSTALL_DIR
}

main() {
	downloadTarball
}

main
