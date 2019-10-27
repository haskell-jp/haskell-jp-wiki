FROM debian:buster-slim

COPY ./run-gitit.sh ./gitit.conf /work/

RUN apt-get update && apt-get install gitit -y && chmod +x /work/run-gitit.sh

WORKDIR /work/

CMD ["./run-gitit.sh"]
