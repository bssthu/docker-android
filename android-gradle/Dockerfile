FROM ubuntu:14.04

MAINTAINER bssthu

# Install java7

RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install Deps
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl

# Install Android SDK

RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.3.3-linux.tgz 
RUN tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# Install sdk elements
COPY tools /opt/tools
RUN chmod +x /opt/tools/android-*.sh
ENV PATH ${PATH}:/opt/tools
RUN ["/opt/tools/android-accept-licenses.sh", "android update sdk --all --no-ui --filter \
                platform-tools,build-tools-21,build-tools-21.0.1,build-tools-21.0.2, \
                build-tools-21.1,build-tools-21.1.1,build-tools-21.1.2, \
                android-21,extra-android-support,extra-android-m2repository, \
                extra-google-m2repository,extra-google-google_play_services"]

RUN which adb
RUN which android

# Install Gradle
RUN apt-get install -y unzip
WORKDIR /usr/lib
ENV GRADLE_VERSION 2.2.1
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip && \
    unzip -q gradle-${GRADLE_VERSION}-all.zip && \
    ln -s "/usr/lib/gradle-${GRADLE_VERSION}" /usr/bin/gradle && \
    rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Caches
VOLUME /root/.gradle/caches

# Cleaning
RUN apt-get clean

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
