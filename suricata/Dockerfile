FROM debian:buster-slim AS suricata-rules

MAINTAINER Michael Torres

RUN apt-get update && \
    apt-get install -y suricata && \
    apt-get clean && \
    oinkmaster -C /etc/suricata/suricata-oinkmaster.conf -o /etc/suricata/rules/

FROM debian:buster-slim AS suricata-base

MAINTAINER Michael Torres

RUN apt-get update && \
    apt-get install --no-install-recommends -y suricata iproute2 && \
    apt-get clean

COPY --from=suricata-rules /etc/suricata/rules /etc/suricata/rules
COPY ./etc/suricata /etc/suricata/

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"] 
