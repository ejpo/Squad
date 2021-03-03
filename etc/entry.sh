#!/bin/bash
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

bash rm -rf ${STEAMAPPDIR}/SquadGame/ServerConfig/*

python3 etc/downloadconfig.py

unzip "${CONTAINER_NAME}.zip"

bash mv ${CONTAINER_NAME}/* ${STEAMAPPDIR}/SquadGame/ServerConfig/.

# Change rcon port on first launch, because the default config overwrites the commandline parameter (you can comment this out if it has done it's purpose)
sed -i -e 's/Port=21114/'"Port=${RCONPORT}"'/g' "${STEAMAPPDIR}/SquadGame/ServerConfig/Rcon.cfg"

bash "${STEAMAPPDIR}/SquadGameServer.sh" \
			Port="${PORT}" \
			QueryPort="${QUERYPORT}" \
			RCONPORT="${RCONPORT}" \
			FIXEDMAXPLAYERS="${FIXEDMAXPLAYERS}" \
			FIXEDMAXTICKRATE="${FIXEDMAXTICKRATE}"
