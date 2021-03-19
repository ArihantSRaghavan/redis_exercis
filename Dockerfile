FROM	ubuntu

RUN 	apt-get update
RUN 	mkdir -p /home/redis/redis-stable
COPY 	redis-stable /home/redis/redis-stable/
WORKDIR /home/redis/redis-stable/
RUN 	cp src/redis-server /usr/local/bin/ && \
    	cp src/redis-cli /usr/local/bin/ 

ENTRYPOINT ["/bin/bash","-c","./start.sh"]
EXPOSE 6379/tcp
