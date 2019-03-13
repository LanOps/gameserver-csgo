#!/bin/sh

cd ${SRCDS_SRV_DIR}
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
    -steam_dir ${SRCDS_SRV_DIR}                     \
    -steamcmd_script /home/steam/csgo_update.txt    \
    -port ${SRCDS_PORT}                             \
    -net_port_try 1                                 \
    +sv_pure ${SRCDS_PURE}                          \
    +maxplayers ${SRCDS_MAXPLAYERS}                 \
    +hostname "${SRCDS_HOSTNAME}"                   \
    +sv_password ${SRCDS_PW}                        \
    +rcon_password ${SRCDS_RCONPW}                  \
    sv_region ${SRCDS_REGION}                       \
    +sv_setsteamaccount "${SRCDS_TOKEN}"            \
    +sv_lan "${SRCDS_LAN}"                          \
    +map ${SRCDS_MAP}                               \
    +game_type "${SRCDS_GAME_TYPE}"                 \
    +game_mode "${SRCDS_GAME_MODE}"                 \
    +mapgroup ${SRCDS_MAP_GROUP}                    \
