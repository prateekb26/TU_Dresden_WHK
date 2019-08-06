
cat > Dockerfile << EOF
FROM sconecuratedimages/crosscompilers
RUN apk update \
&& apk add git curl go \
&& go get -compiler gccgo -u github.com/golang/groupcache \
&& curl  -fsSL --output  groupcache.go https://gist.githubusercontent.com/fiorix/816117cfc7573319b72d/raw/797d2ed5b567dcffb8ebd8896a3d7671b1a44b31/groupcache.go \
&& export SCONE_HEAP=1G \
&& go build -compiler gccgo -buildmode=exe groupcache.go

FROM alpine:latest
COPY --from=0 /groupcache /
COPY --from=0 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgo.so.11 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgo.so.11
COPY --from=0 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgcc_s.so.1 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libgcc_s.so.1
COPY --from=0 /opt/scone/lib/ld-scone-x86_64.so.1 /opt/scone/lib/ld-scone-x86_64.so.1
COPY --from=0 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libc.scone-x86_64.so.1 /opt/scone/cross-compiler/x86_64-linux-musl/lib/libc.scone-x86_64.so.1
COPY --from=0 /etc/sgx-musl.conf /etc/sgx-musl.conf
CMD sh -c "SCONE_HEAP=1G /groupcache"
EOF
docker build --pull -t groupcache .
docker run --rm --publish 8080:8080  groupcache
curl localhost:8080/color?name=green