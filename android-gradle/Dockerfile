FROM ubuntu:14.04

MAINTAINER bssthu

# Install java7 and Deps

RUN apt-get install -y --no-install-recommends software-properties-common && \
    add-apt-repository -y ppa:webupd8team/java && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true \
        | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java7-installer && \
    apt-get install -y --force-yes --no-install-recommends expect git wget \
        libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 \
        lib32z1 python curl unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rv /var/cache/oracle-jdk7-installer

# Install Android SDK
RUN cd /opt && \
    wget --output-document=android-sdk.tgz --quiet \
        http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz  && \
    tar xzf android-sdk.tgz && \
    rm -f android-sdk.tgz && \
    chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools
RUN chmod +x /opt/tools/android-*.sh
ENV PATH ${PATH}:/opt/tools
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter \
platform-tools,build-tools-21,build-tools-21.0.1,build-tools-21.0.2,\
build-tools-21.1,build-tools-21.1.1,build-tools-21.1.2,\
android-21,extra-android-support,extra-android-m2repository,\
extra-google-m2repository,extra-google-google_play_services"]

RUN which adb && \
    which android

# Install Gradle
WORKDIR /usr/lib
ENV GRADLE_VERSION 2.10
RUN cd /usr/lib && \
    wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
    unzip -q gradle-${GRADLE_VERSION}-all.zip && \
    ln -s "/usr/lib/gradle-${GRADLE_VERSION}" /usr/bin/gradle && \
    rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace

