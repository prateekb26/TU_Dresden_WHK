

docker run -it sconecuratedimages/crosscompilers

docker run --rm sconecuratedimages/apps:check_cpuid

gcc -o helloworld helloworld.c

./helloworld

SCONE_VERSION=1 ./helloworld