

docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers

gcc -o helloworld helloworld.c

./helloworld

SCONE_VERSION=1 ./helloworld