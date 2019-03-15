#!/bin/bash

cd ${SRCDS_SRV_DIR}

getMetaMod="false"
getSourceMod="false"

if [ ! -d "csgo" ];
then
    mkdir csgo
    cp -r /tmp/cfg csgo/cfg/
fi

# Check if MetaMod Needs updating

if [ ! -d "csgo/addons/metamod" ] || [ ! -f "csgo/addons/mm-version" ];
then
    getMetaMod="true"
fi
if [ -f "csgo/addons/mm-version" ];
then
    content=$(head -n 1 csgo/addons/mm-version)
    if [ "${METAMOD_VERSION_MAJOR}.${METAMOD_VERSION_MINOR}-${METAMOD_BUILD}" != "$content" ];
    then
        getMetaMod="true"
    fi
fi

# Check if SourceMod Needs updating

if [ ! -d "csgo/addons/sourcemod" ] || [ ! -f "csgo/addons/sm-version" ];
then
    getSourceMod="true"
fi
if [ -f "csgo/addons/sm-version" ];
then
    content=$(head -n 1 csgo/addons/sm-version)
    if [ "${SOURCEMOD_VERSION_MAJOR}.${SOURCEMOD_VERSION_MINOR}-${SOURCEMOD_BUILD}" != "$content" ];
    then
        getSourceMod="true"
    fi
fi

# Update MetaMod

if [[ $getMetaMod == "true" ]];
then
    curl -sSL https://mms.alliedmods.net/mmsdrop/$METAMOD_VERSION_MAJOR/mmsource-$METAMOD_VERSION_MAJOR.$METAMOD_VERSION_MINOR-git$METAMOD_BUILD-linux.tar.gz \
        -o /tmp/metamod.tar.gz
    tar -xzvf /tmp/metamod.tar.gz --directory $SRCDS_SRV_DIR/csgo
    rm /tmp/metamod.tar.gz
    if [ -f "csgo/addons/mm-version" ];
    then
        rm csgo/addons/mm-version
    fi
    echo "${METAMOD_VERSION_MAJOR}.${METAMOD_VERSION_MINOR}-${METAMOD_BUILD}" > csgo/addons/mm-version
fi

# Update SourceMod

if [[ $getSourceMod == "true" ]];
then
    curl -sSL https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION_MAJOR/sourcemod-$SOURCEMOD_VERSION_MAJOR.$SOURCEMOD_VERSION_MINOR-git$SOURCEMOD_BUILD-linux.tar.gz \
        -o /tmp/sourcemod.tar.gz
    tar -xzvf /tmp/sourcemod.tar.gz --directory $SRCDS_SRV_DIR/csgo
    rm /tmp/sourcemod.tar.gz
    if [ -f "csgo/addons/sm-version" ];
    then
        rm csgo/addons/sm-version
    fi
    echo "${SOURCEMOD_VERSION_MAJOR}.${SOURCEMOD_VERSION_MINOR}-${SOURCEMOD_BUILD}" > csgo/addons/sm-version
fi

export SRCDS_HOSTNAME="${SRCDS_HOSTNAME:-An Amazing CSGO Server}"

sed -i 's/SERVER_NAME/'"$SRCDS_HOSTNAME"'/g' /home/steam/csgo/csgo/cfg/server.cfg
sed -i 's/RCON_PASSWORD/'"$SRCDS_RCONPW"'/g' /home/steam/csgo/csgo/cfg/server.cfg
sed -i 's/SV_PASSWORD/'"$SRCDS_PW"'/g' /home/steam/csgo/csgo/cfg/server.cfg

# Run Server

/home/steam/steamcmd/steamcmd.sh +login anonymous   \
        +force_install_dir ${SRCDS_SRV_DIR}         \
        +app_update ${SRCDS_APP_ID} validate        \
        +quit
./srcds_run                                         \
    -game csgo                                      \
    -tickrate ${SRCDS_TICKRATE}                     \
    -console                                        \
    -usercon                                        \
    -autoupdate                                     \
    -steam_dir /home/steam/steamcmd                 \
    -steamcmd_script /home/steam/csgo_update.txt    \
    -port ${SRCDS_PORT}                             \
    -net_port_try 1                                 \
    -nohltv                                         \
    -maxplayers_override ${SRCDS_MAXPLAYERS}        \
    +sv_pure ${SRCDS_PURE}                          \
    +sv_setsteamaccount ${SRCDS_TOKEN}              \
    +sv_lan ${SRCDS_LAN}                            \
    +map ${SRCDS_MAP}                               \
    +game_type ${SRCDS_GAME_TYPE}                   \
    +game_mode ${SRCDS_GAME_MODE}                   \
    +mapgroup ${SRCDS_MAP_GROUP}                    \
    +ip 0.0.0.0
