
echo next
> ls /dev/isgx 
/dev/isgx
echo next
> git clone https://github.com/christoffetzer/SCONE_TUTORIAL.git
echo next
> cd SCONE_TUTORIAL/DLDockerFile
echo next
echo next
> ./generate.sh
echo next
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
echo next
[Error] Could not create enclave: Error opening SGX device 
echo next
> cd SCONE_TUTORIAL/DockerFile
echo next
./generate.sh
echo next
export TAG="again"
export FULLTAG="sconecuratedimages/helloworld:$TAG"
echo next
echo next
echo next
echo next
> export TAG="latest"
> export IMAGE_NAME="myrepository/helloAgain"
