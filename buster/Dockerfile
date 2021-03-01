############################################################
# Dockerfile that builds a Squad Gameserver
############################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 403240
ENV STEAMAPP squad
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/ejpo/Squad/sos-dev

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		git=1:2.20.1-2+deb10u3 \
	&& wget "${DLURL}/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod 755 "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& chown "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*

ENV PORT=7787 \
	QUERYPORT=27165 \
	RCONPORT=21114 \
	FIXEDMAXPLAYERS=100 \
	FIXEDMAXTICKRATE=50

USER ${USER}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 7787/udp \
	27165/tcp \
	27165/udp \
	21114/tcp \
	21114/udp
