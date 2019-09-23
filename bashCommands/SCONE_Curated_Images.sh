

> docker login

docker pull sconecuratedimages/muslgcc

docker pull sconecuratedimages/crosscompilers:runtime

docker pull sconecuratedimages/crosscompilers

docker pull sconecuratedimages/helloworld

> docker run sconecuratedimages/helloworld
Hello World

docker run sconecuratedimages/helloworld

error opening sgx device: No such file or directory

> docker run --device=/dev/isgx sconecuratedimages/helloworld
Hello World

> docker run --device=/dev/isgx sconecuratedimages/helloworld
docker: Error response from daemon: linux runtime spec devices: error gathering device information while adding custom device "/dev/isgx": no such file or directory.