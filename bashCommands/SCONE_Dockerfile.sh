

> ls /dev/isgx 
/dev/isgx

> git clone https://github.com/christoffetzer/SCONE_TUTORIAL.git

> cd SCONE_TUTORIAL/DLDockerFile

> docker run --rm  -v "$PWD":/usr/src/myapp -w /usr/src/myapp sconecuratedimages/muslgcc gcc  hello_again.c -o dyn_hello_again

> ./generate.sh

> docker run -it sconecuratedimages/helloworld:dynamic
export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=67108864
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=hw
Configure parameters: 
1.1.15
Hello Again

> docker run -it sconecuratedimages/helloworld:dynamic
[Error] Could not create enclave: Error opening SGX device 

> cd SCONE_TUTORIAL/DockerFile

> docker login
./generate.sh

export TAG="again"
export FULLTAG="sconecuratedimages/helloworld:$TAG"

> docker build --pull -t $FULLTAG .

> docker run -it $FULLTAG

> docker push $FULLTAG

> export TAG="latest"
> export IMAGE_NAME="myrepository/helloAgain"