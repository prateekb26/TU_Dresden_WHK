
echo next
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
echo next
gcc -o helloworld helloworld.c
echo next
./helloworld
echo next
SCONE_VERSION=1 ./helloworld