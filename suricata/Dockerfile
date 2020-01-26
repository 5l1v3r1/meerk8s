FROM debian:buster-slim AS suricata-rules

MAINTAINER Michael Torres

RUN apt-get update && \
    apt-get install -y suricata && \
    apt-get clean && \
    oinkmaster -C /etc/suricata/suricata-oinkmaster.conf -o /etc/suricata/rules/


FROM debian:buster-slim AS suricata-build

MAINTAINER Michael Torres

RUN apt-get update && \
    apt-get install --no-install-recommends -y libpcre3-dev libgeoip-dev libgnutls28-dev \ 
            build-essential autoconf automake libnss3-dev libtool libpcap-dev libnet1-dev \
	    libyaml-0-2 libyaml-dev zlib1g zlib1g-dev libmagic-dev libcap-ng-dev libhtp-dev \
 	    libjansson-dev pkg-config git rustc cargo make python ca-certificates \ 
            libhyperscan-dev && \
    apt-get clean && \
    mkdir /install && \
    cd /root && \
    git clone https://github.com/OISF/suricata.git && cd suricata && \
    git clone https://github.com/OISF/libhtp.git && \
    /root/suricata/autogen.sh && \
    /root/suricata/configure --prefix=/install --exec-prefix=/install --enable-rust && \
    make && make install


FROM debian:buster-slim as suricata

RUN apt-get update && \
    apt-get install --no-install-recommends -y libpcre3 libnet1 libgeoip1 libgnutls30 zlib1g \
            libyaml-0-2 libmagic1 libhyperscan5 libcap-ng0 libjansson4 python iproute2 \
            libnss3 libpcap0.8 && \
    apt-get clean

COPY --from=suricata-rules /etc/suricata/ /etc/suricata/
COPY --from=suricata-build /install/bin /usr/bin
COPY --from=suricata-build /install/lib/libhtp.s* /usr/lib/x86_64-linux-gnu/
COPY ./etc/suricata /etc/suricata/

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"] 
