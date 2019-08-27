
echo next
> cd SCONE_TUTORIAL/CreateImage
echo next
> docker login
> sudo ./Dockerfile.sh
echo next
> export TAG="latest"
> export IMAGE_NAME="sconecuratedimages/helloworld"
echo next

> CONTAINER_ID=`docker run -d -it --device=/dev/isgx  -v $(pwd):/mnt sconecuratedimages/crosscompilers bash -c "
set -e
printf 'Q 1\ne 0 0 0\ns 1 0 0\n' > /etc/sgx-musl.conf
sgxmusl-hw-async-gcc /mnt/hello_world.c  -o /usr/local/bin/sgx_hello_world
"`
echo next
> IMAGE_ID=$(docker commit -p -c 'CMD sgx_hello_world' $CONTAINER_ID $IMAGE_NAME:$TAG)
echo next
> sudo docker run --device=/dev/isgx $IMAGE_NAME:$TAG
echo next
> sudo docker login
echo next
> sudo docker push $IMAGE_NAME:$TAG