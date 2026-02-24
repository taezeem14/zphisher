FROM alpine:latest
LABEL MAINTAINER="Muhammad Taezeem (Fork of htr-tech/zphisher - Educational Purposes Only)"
LABEL version="3.0.0"
LABEL description="Zphisher - Automated Phishing Tool for Educational Purposes Only"
WORKDIR /zphisher/
ADD . /zphisher
RUN apk add --no-cache bash ncurses curl unzip wget php openssh-client git 
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8080/ || exit 1
CMD ["./zphisher.sh"]
