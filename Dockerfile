FROM debian:stable-slim

RUN apt update && apt -y install curl jq

ARG KUBERNETES_VERSION=v1.12.1
ADD https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl
