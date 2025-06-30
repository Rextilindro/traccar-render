FROM openjdk:17-jdk-slim

WORKDIR /opt/traccar

RUN apt-get update && apt-get install -y wget unzip && \
    wget https://github.com/traccar/traccar/releases/download/v5.12/traccar-other-5.12.zip && \
    unzip traccar-other-5.12.zip && \
    rm traccar-other-5.12.zip

# Expone el puerto que Render asigna
EXPOSE 8082

# Sustituye el valor en traccar.xml antes de ejecutar el servidor
CMD sed -i "s/<entry key='web.port'>.*<\/entry>/<entry key='web.port'>${PORT}<\/entry>/" conf/traccar.xml && \
    java -jar tracker-server.jar conf/traccar.xml
