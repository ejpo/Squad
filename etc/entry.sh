#!/bin/bash
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

bash end=$((SECONDS+3600)) \
while [ $SECONDS -lt $end ]; do \
    echo $SECONDS \
    : \
done

rm -rf ${STEAMAPPDIR}/SquadGame/ServerConfig/*

python3 downloadconfig.py

unzip "${CONTAINER_NAME}.zip"

mv ${STEAMAPPDIR}/${CONTAINER_NAME}/* ${STEAMAPPDIR}/SquadGame/ServerConfig/.

# Change rcon port on first launch, because the default config overwrites the commandline parameter (you can comment this out if it has done it's purpose)
sed -i -e 's/Port=21114/'"Port=${RCONPORT}"'/g' "${STEAMAPPDIR}/SquadGame/ServerConfig/Rcon.cfg"



#bash "${STEAMAPPDIR}/SquadGameServer.sh" \
#			Port="${PORT}" \
#			QueryPort="${QUERYPORT}" \
#			RCONPORT="${RCONPORT}" \
#			FIXEDMAXPLAYERS="${FIXEDMAXPLAYERS}" \
#			FIXEDMAXTICKRATE="${FIXEDMAXTICKRATE}"
