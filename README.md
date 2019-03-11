# CSGO Docker Image

## Usage

```
docker run -it --name "CSGO" \
    -e SRCDS_HOSTNAME=myServer \
    -e SRCDS_PORT=27015 \
    -e SRCDS_MAP=de_dust2 \
    -e SRCDS_MAXPLAYERS=24 \
    -e SRCDS_TOKEN=xxx \
    -e SRCDS_PW=default \
    -e SRCDS_RCONPW=default \
    -p 27015:27015 \
    -p 27015:27015/udp \
    lanopsdev/gameserver-csgo
```

### For Persistance mount the /home/steam/csgo directory

```
docker run -it --name "CSGO" \
    -v localVolume:/home/steam/csgo \
    -e SRCDS_HOSTNAME=myServer \
    -e SRCDS_PORT=27015 \
    -e SRCDS_MAP=de_dust2 \
    -e SRCDS_MAXPLAYERS=24 \
    -e SRCDS_TOKEN=xxx \
    -p 27015:27015 \
    -p 27015:27015/udp \
    lanopsdev/gameserver-csgo
```


## Environment Variables

* SRCDS_PORT - Port Number for the server to run on (Default 27015)
* SRCDS_PURE - Set the pure level of the server (Default 1)
* SRCDS_MAXPLAYERS - Max number of players (Default 14)
* SRCDS_HOSTNAME - Server Name (Default myServer)
* SRCDS_PW - Password for access to the server (Default password)
* SRCDS_RCONPW - Password for RCON (Default rconpass)
* SRCDS_REGION - Server Region (Default -1)
* SRCDS_TOKEN - Server token from [http://steamcommunity.com/dev/managegameservers](http://steamcommunity.com/dev/managegameservers) - Required for Browser Broadcast
* SRCDS_LAN - Set Lan Server (Default 0)
* SRCDS_MAP - Starting Map (Default de_dust2)
* SRCDS_GAME_TYPE - CSGO Game Type (Default 0)
* SRCDS_GAME_MODE - CSGO Game Mode (Default 0)
* SRCDS_MAP_GROUP - CSGO Map Group (Default mg_active)