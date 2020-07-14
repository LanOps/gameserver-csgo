# CSGO Docker Image
[![Build Status](http://drone.th0rn0.co.uk/api/badges/LanOps/gameserver-csgo/status.svg)](http://drone.th0rn0.co.uk/LanOps/gameserver-csgo)

CSGO Dedicated Server with Metamod & Sourcemod running at 128 Tick.

## Prerequisites

You must create the mount directory and give the container full read and write permissions.

## Usage

```
docker run -it --name "CSGO"                        \
    -v /path/to/local/m:/home/steam/csgo            \
    -p 27015:27015                                  \
    -p 27015:27015/udp                              \
    lanopsdev/gameserver-csgo
```

You can also use the Entrypoint and CMD to customize configs and plugins like you would normally with SRCDS (Port & Tickrate must be changed via Env Variable)

```
docker run -it --name "CSGO"                        \
    -v /path/to/local/m:/home/steam/csgo            \
    -p 27015:27015                                  \
    -p 27015:27015/udp                              \
    lanopsdev/gameserver-csgo                       \
    -maxplayers_override ${SRCDS_MAXPLAYERS}        \
    +sv_pure ${SRCDS_PURE}                          \
    +sv_region ${SRCDS_REGION}                      \
    +sv_setsteamaccount ${SRCDS_TOKEN}              \
    +sv_lan ${SRCDS_LAN}                            \
    +map ${SRCDS_MAP}                               \
    +game_type ${SRCDS_GAME_TYPE}                   \
    +game_mode ${SRCDS_GAME_MODE}                   \
    +mapgroup ${SRCDS_MAP_GROUP}                    \
    +ip 0.0.0.0

```

## Environment Variables

* SRCDS_PORT - Port Number for the server to run on (Default 27015)
* SRCDS_TICKRATE - CSGO Tickrate (Default 128)
