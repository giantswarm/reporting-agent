FROM alpine:3.8

RUN apk add --no-cache curl jq

ARG KUBERNETES_VERSION=v1.12.1
ADD https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl /usr/local/bin
RUN chmod +x /usr/local/bin/kubectl

COPY agent.sh /usr/local/bin/reporting-agent
RUN chmod +x /usr/local/bin/reporting-agent
ENTRYPOINT /usr/local/bin/reporting-agent
