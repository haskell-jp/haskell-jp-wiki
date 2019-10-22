FROM haskell:8.6

RUN cabal v2-update

RUN cabal v2-install gitit

RUN mkdir /work

COPY ./run-gitit.sh /work
RUN chmod +x /work/run-gitit.sh

COPY ./gitit.conf /work

WORKDIR /work

CMD ["./run-gitit.sh"]
