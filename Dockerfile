FROM lanopsdev/gameserver-steamcmd:latest
MAINTAINER Thornton Phillis (Th0rn0@lanops.co.uk)

# Env Defaults
ENV SRCDS_HOSTNAME default
ENV SRCDS_PORT 27015 
ENV SRCDS_MAXPLAYERS 14 
ENV SRCDS_TOKEN 0 
ENV SRCDS_RCONPW rconpass 
ENV SRCDS_PW password
ENV SRCDS_REGION -1
ENV SRCDS_PURE 1
ENV SRCDS_MAP de_dust2
ENV SRCDS_GAME_TYPE 0
ENV SRCDS_GAME_MODE 0
ENV SRCDS_MAP_GROUP mg_active
ENV APP_ID 740

# Add Start Script
RUN mkdir -p /home/steam/csgo 
RUN { \
        echo '@ShutdownOnFailedCommand 1'; \
        echo '@NoPromptForPassword 1'; \
        echo 'login anonymous'; \
        echo 'force_install_dir /home/steam/csgo/'; \
        echo 'app_update $APP_ID'; \
        echo 'quit'; \
} > /home/steam/csgo_update.txt
ADD startServer.sh /home/steam/startServer.sh

# Expose Ports
EXPOSE 27015 27020 27005 51840
EXPOSE 27015/udp

# Start Server
CMD ["/home/steam/startServer.sh"]

