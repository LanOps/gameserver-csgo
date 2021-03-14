FROM lanopsdev/gameserver-steamcmd:latest
MAINTAINER Thornton Phillis (dev@th0rn0.co.uk)

# Env - Defaults

ENV SRCDS_PORT 27015 
ENV SRCDS_TICKRATE 128

# Env - Server

ENV SRCDS_SRV_DIR /home/steam/csgo
ENV SRCDS_APP_ID 740

# Env - SourceMod & MetaMod

ENV SOURCEMOD_VERSION_MAJOR 1.9
ENV SOURCEMOD_VERSION_MINOR 0
ENV SOURCEMOD_BUILD 6276
ENV METAMOD_VERSION_MAJOR 1.10
ENV METAMOD_VERSION_MINOR 7
ENV METAMOD_BUILD 970

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

# Expose Ports

EXPOSE ${SRCDS_PORT}
EXPOSE ${SRCDS_PORT}/udp
EXPOSE 27020 27005 51840

# Start Server

ENTRYPOINT ["/home/steam/startServer.sh"]
CMD ["+sv_pure 1 +sv_region -1 +sv_lan 0 +map de_dust2 +game_type 0 +exec server.cfg +game_mode 0 +mapgroup mg_active +ip 0.0.0.0"]
