# Container image that runs your code
FROM ubuntu:jammy


RUN DEBIAN_FRONTEND=noninteractive apt-get update < /dev/null > /dev/null
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq install apt-transport-https curl gnupg 
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" |  tee /etc/apt/sources.list.d/bazel.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update < /dev/null > /dev/null
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qq python3.10 python3.10-dev python3.10-distutils bazel \
  gcc g++ cmake nodejs git build-essential < /dev/null > /dev/null

RUN ln -s $(which python3) /usr/local/bin/python

RUN echo "Downloading Skaffold..."
RUN curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
  install skaffold /usr/local/bin

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN groupadd -g 1001 shadowuser && useradd --system -m -u 1001 -g shadowuser shadowuser

#USER shadowuser
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
