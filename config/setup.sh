#!/bin/bash

echo "######################################"
echo "# Configuring"
echo "######################################"
echo "######################################"
echo "## Globals"
echo "######################################"

SOLDAT_DOWNLOAD_INDEX_URL=${SOLDAT_DOWNLOAD_INDEX_URL:=http://static.soldat.pl/downloads}
echo "Download URL:    ${SOLDAT_DOWNLOAD_INDEX_URL}"

SOLDAT_VERSION=${SOLDAT_VERSION:=latest}
echo "Desired Version: ${SOLDAT_VERSION}"

if [ $SOLDAT_VERSION == "latest" ]; then
	SOLDAT_SERVER_ZIP=`wget --no-check-certificate -O - -o /dev/null $SOLDAT_DOWNLOAD_INDEX_URL | grep -o -E "soldatserver[0-9]+\.[0-9]+\.[0-9]+_[0-9]+\.[0-9]+\.[0-9]+\.zip" | sort | tail -1`
else
	SOLDAT_SERVER_ZIP="soldatserver${SOLDAT_VERSION}.zip"
fi
echo "Server Zip:  ${SOLDAT_SERVER_ZIP}"

SOLDAT_SERVER_URL="${SOLDAT_DOWNLOAD_INDEX_URL}/${SOLDAT_SERVER_ZIP}"
echo "Server URL:  ${SOLDAT_SERVER_URL}"



echo "######################################"
echo "## SOLDAT INI File"
echo "######################################"

SOLDAT_INI_GAME_Weapon_1=${SOLDAT_INI_GAME_Weapon_1:=1}
SOLDAT_INI_NETWORK_Admin_Password=${SOLDAT_INI_NETWORK_Admin_Password:=admin}
SOLDAT_INI_NETWORK_Game_Password=${SOLDAT_INI_NETWORK_Game_Password:=123456}
SOLDAT_INI_NETWORK_Greeting_Message=${SOLDAT_INI_NETWORK_Greeting_Message:=Welcome to Vertigion. You are born to kill.}
SOLDAT_INI_NETWORK_Port=${SOLDAT_INI_NETWORK_Port:=23073}
SOLDAT_INI_NETWORK_Server_Name=${SOLDAT_INI_NETWORK_Server_Name:=Vertigion Server}
SOLDAT_INI_NETWORK_Server_Info=${SOLDAT_INI_NETWORK_Server_Info:=Server running in Docker (vertigoray/docker-soldat). Courtesy of Vertigion (http://vertigion.com).}


touch /tmp/soldat.ini
prev_section=""
regex='SOLDAT_INI_([a-zA-Z0-9]+)_(.+)'
for var in ${!SOLDAT_INI*}; do
	echo "${var}: ${!var}"
	if [[ $var =~ $regex ]]; then
		section="${BASH_REMATCH[1]}"
		name="${BASH_REMATCH[2]}"
		if [[ $section != $prev_section ]]; then
			prev_section=$section
			echo >> /tmp/soldat.ini
			echo "[${section}]" >> /tmp/soldat.ini
		fi
		echo "${name}=${!var}" >> /tmp/soldat.ini
	fi
done



echo "######################################"
echo "## SERVER INI File"
echo "######################################"

touch /tmp/server.ini
prev_section=""
regex='SERVER_INI_([a-zA-Z0-9]+)_(.+)'
for var in ${!SERVER_INI*}; do
	echo "${var}: ${!var}"
	if [[ $var =~ $regex ]]; then
		section="${BASH_REMATCH[1]}"
		name="${BASH_REMATCH[2]}"
		if [[ $section != $prev_section ]]; then
			prev_section=$section
			echo >> /tmp/server.ini
			echo "[${section}]" >> /tmp/server.ini
		fi
		echo "${name}=${!var}" >> /tmp/server.ini
	fi
done



echo "######################################"
echo "# Download and Extract"
echo "######################################"

wget --no-check-certificate $SOLDAT_SERVER_URL -P /soldat/
unzip -o /soldat/$SOLDAT_SERVER_ZIP -d /soldat
rm /soldat/$SOLDAT_SERVER_ZIP
ls -la /soldat



echo "######################################"
echo "# Setup server in $(pwd)"
echo "######################################"

ls -la /tmp
mv /tmp/soldat.ini /soldat
mv /tmp/server.ini /soldat
chmod +x /soldat/soldatserver
chmod -R 0777 /soldat/logs
chmod -R u+w /soldat/logs
chmod -R u+w /soldat/anti-cheat
chmod 666 /soldat/banned*.txt
ls -la /soldat
cd /soldat


echo "######################################"
echo "# Run Server"
echo "######################################"
./soldatserver
