FROM ubuntu:18.04

COPY hello /

ENTRYPOINT ["/hello"]
