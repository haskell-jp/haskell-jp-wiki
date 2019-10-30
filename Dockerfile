FROM debian:buster-slim

RUN apt-get update && apt-get install gitit -y

COPY ./run-gitit.sh ./gitit.conf /work/

RUN chmod +x /work/run-gitit.sh

WORKDIR /work/

CMD ["./run-gitit.sh"]
