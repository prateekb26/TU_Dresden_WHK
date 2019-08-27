
echo next
> docker login
echo next
docker pull sconecuratedimages/muslgcc
echo next
docker pull sconecuratedimages/crosscompilers:runtime
echo next
docker pull sconecuratedimages/crosscompilers
echo next
docker pull sconecuratedimages/helloworld
echo next
> docker run sconecuratedimages/helloworld
Hello World
echo next
docker run sconecuratedimages/helloworld
echo next
error opening sgx device: No such file or directory
echo next
> docker run --device=/dev/isgx sconecuratedimages/helloworld
Hello World
echo next
> docker run --device=/dev/isgx sconecuratedimages/helloworld
docker: Error response from daemon: linux runtime spec devices: error gathering device information while adding custom device "/dev/isgx": no such file or directory.