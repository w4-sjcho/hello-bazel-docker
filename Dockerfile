FROM alpine:3.6

COPY hello /

ENTRYPOINT ["/hello"]
