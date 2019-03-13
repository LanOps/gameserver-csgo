FROM lanopsdev/gameserver-steamcmd:latest
MAINTAINER Thornton Phillis (Th0rn0@lanops.co.uk)

# Env - Defaults

ENV SRCDS_HOSTNAME default
ENV SRCDS_PORT 27015 
ENV SRCDS_MAXPLAYERS 14 
ENV SRCDS_TOKEN 0 
ENV SRCDS_RCONPW rconpass 
ENV SRCDS_PW password
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
RUN mkdir -p ${SRCDS_SRV_DIR}/csgo
RUN { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'login anonymous'; \
        echo 'force_install_dir $SRCDS_SRV_DIR'; \
        echo 'app_update $SRCDS_APP_ID'; \
        echo 'quit'; \
} > /home/steam/csgo_update.txt
ADD resources/root/startServer.sh /home/steam/startServer.sh

# Install MetaMod

RUN curl -sSL https://mms.alliedmods.net/mmsdrop/$METAMOD_VERSION_MAJOR/mmsource-$METAMOD_VERSION_MAJOR.$METAMOD_VERSION_MINOR-git$METAMOD_BUILD-linux.tar.gz -o /tmp/metamod.tar.gz
RUN tar -xzvf /tmp/metamod.tar.gz --directory $SRCDS_SRV_DIR/csgo && rm /tmp/metamod.tar.gz

# Install SourceMod

RUN curl -sSL https://sm.alliedmods.net/smdrop/$SOURCEMOD_VERSION_MAJOR/sourcemod-$SOURCEMOD_VERSION_MAJOR.$SOURCEMOD_VERSION_MINOR-git$SOURCEMOD_BUILD-linux.tar.gz -o /tmp/sourcemod.tar.gz
RUN tar -xzvf /tmp/sourcemod.tar.gz --directory $SRCDS_SRV_DIR/csgo && rm /tmp/sourcemod.tar.gz

# Expose Ports
EXPOSE 27015 27020 27005 51840
EXPOSE 27015/udp

# Start Server
CMD ["/home/steam/startServer.sh"]