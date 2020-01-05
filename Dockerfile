FROM debian:buster-slim

RUN apt-get update && apt-get install gitit locales locales-all -y

COPY ./run-gitit.sh ./gitit.conf /work/

RUN chmod +x /work/run-gitit.sh

WORKDIR /work/

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["./run-gitit.sh"]
