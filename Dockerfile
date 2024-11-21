FROM ubuntu:latest

LABEL maintainer="Jim Davidson"
LABEL version="2.8.8"
LABEL release-date="2024-07-31"
LABEL source="https://github.com/jimusik/nxrelay-docker"

ENV TZ=${TZ:-Etc/UTC}

RUN apt -y update && apt -y upgrade \
  && apt -y install --no-install-recommends dnsutils iputils-ping tzdata curl openjdk-11-jre-headless \
  && curl $(printf ' -O http://pub.nxfilter.org/nxrelay-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y install --no-install-recommends ./$(printf 'nxrelay-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf ./$(printf 'nxrelay-%s.deb' $(curl https://nxfilter.org/curnxc.php)) \
  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log \
  && echo "$(curl https://nxfilter.org/curnxc.php)" > /nxcloud/version.txt

EXPOSE 53/udp

CMD ["/nxrelay/bin/startup.sh"]
