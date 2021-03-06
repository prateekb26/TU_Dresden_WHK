

> cd SCONE_TUTORIAL/CreateImage

> docker login
> sudo ./Dockerfile.sh

> export TAG="latest"
> export IMAGE_NAME="sconecuratedimages/helloworld"


> CONTAINER_ID=`docker run -d -it --device=/dev/isgx  -v $(pwd):/mnt sconecuratedimages/crosscompilers bash -c "
set -e
printf 'Q 1\ne 0 0 0\ns 1 0 0\n' > /etc/sgx-musl.conf
sgxmusl-hw-async-gcc /mnt/hello_world.c  -o /usr/local/bin/sgx_hello_world
"`

> IMAGE_ID=$(docker commit -p -c 'CMD sgx_hello_world' $CONTAINER_ID $IMAGE_NAME:$TAG)

> sudo docker run --device=/dev/isgx $IMAGE_NAME:$TAG

> sudo docker login

> sudo docker push $IMAGE_NAME:$TAG