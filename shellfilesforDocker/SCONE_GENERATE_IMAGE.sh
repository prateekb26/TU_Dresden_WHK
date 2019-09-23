

> cd SCONE_TUTORIAL/CreateImage

> sudo ./Dockerfile.sh

> export TAG="latest"
> export IMAGE_NAME="sconecuratedimages/helloworld"


set -e
printf 'Q 1\ne 0 0 0\ns 1 0 0\n' > /etc/sgx-musl.conf
sgxmusl-hw-async-gcc /mnt/hello_world.c  -o /usr/local/bin/sgx_hello_world
"`




