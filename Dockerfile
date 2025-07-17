#
# Copyright (c) 2021 Pterodactyl
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

FROM		--platform=$TARGETOS/$TARGETARCH debian:bookworm-slim

LABEL		org.opencontainers.image.source="https://github.com/xXTurnerLP/docker-rust-carbon"

ENV			DEBIAN_FRONTEND=noninteractive

# Install Dependancies
RUN			dpkg --add-architecture i386 && \
			apt update && \
			apt upgrade -y && \
			apt install -y lib32gcc-s1 lib32stdc++6 unzip curl iproute2 tzdata libgdiplus libsdl2-2.0-0:i386 jq

# Define user environment
RUN			useradd -d /home/container -m container
USER		container
ENV			USER=container HOME=/home/container

# Switch to the container of the server
WORKDIR		/home/container

# Install steamcmd
RUN			mkdir /home/container/steamcmd && \
			curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxf - -C /home/container/steamcmd/.

# Copy some files over to the container
COPY		./entrypoint.sh /entrypoint.sh
COPY		./LinuxStdinSupport.dll /LinuxStdinSupport.dll

# CMD		[ "/bin/bash", "/entrypoint.sh" ]