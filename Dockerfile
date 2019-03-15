FROM lanopsdev/gameserver-steamcmd:latest
MAINTAINER Thornton Phillis (Th0rn0@lanops.co.uk)

# Env - Defaults

ENV SRCDS_HOSTNAME default
ENV SRCDS_PORT 27015 
ENV SRCDS_MAXPLAYERS 14 
ENV SRCDS_TOKEN 0 
ENV SRCDS_RCONPW rconpass 
ENV SRCDS_REGION -1
ENV SRCDS_PURE 1
ENV SRCDS_MAP de_dust2
ENV SRCDS_LAN 0
ENV SRCDS_GAME_TYPE 0
ENV SRCDS_GAME_MODE 0
ENV SRCDS_MAP_GROUP mg_active
ENV SRCDS_TICKRATE 128

# Env - Server

ENV SRCDS_SRV_DIR /home/steam/csgo
ENV SRCDS_APP_ID 740

# Env - SourceMod & MetaMod

ENV SOURCEMOD_VERSION_MAJOR 1.9
ENV SOURCEMOD_VERSION_MINOR 0
ENV SOURCEMOD_BUILD 6275
ENV METAMOD_VERSION_MAJOR 1.10
ENV METAMOD_VERSION_MINOR 7
ENV METAMOD_BUILD 968

# Add Start Script

RUN mkdir -p ${SRCDS_SRV_DIR}
RUN { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'login anonymous'; \
        echo 'force_install_dir $SRCDS_SRV_DIR'; \
        echo 'app_update $SRCDS_APP_ID'; \
        echo 'quit'; \
} > /home/steam/csgo_update.txt
ADD resources/root/startServer.sh /home/steam/startServer.sh

# Pre Load LanOps Server Configs

RUN mkdir -p ${SRCDS_SRV_DIR}/csgo/cfg/
COPY resources/root/cfg /tmp/cfg/
RUN ls /tmp

# Expose Ports

EXPOSE ${SRCDS_PORT}
EXPOSE ${SRCDS_PORT}/udp
EXPOSE 27020 27005 51840

# Start Server

CMD ["/home/steam/startServer.sh"]