
echo next
docker run -it sconecuratedimages/crosscompilers
echo next
docker run --rm sconecuratedimages/apps:check_cpuid
echo next
gcc -o helloworld helloworld.c
echo next
./helloworld
echo next
SCONE_VERSION=1 ./helloworld