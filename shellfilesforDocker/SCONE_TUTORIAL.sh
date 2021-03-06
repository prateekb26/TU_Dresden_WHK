

REPOSITORY                          TAG                    IMAGE ID            CREATED             SIZE
sconecuratedimages/crosscompilers   latest                 dff7975b7f32        7 hours ago         1.57GB
sconecuratedimages/crosscompilers   scone                  dff7975b7f32        7 hours ago         1.57GB

> git clone https://github.com/christoffetzer/SCONE_TUTORIAL.git

> cd SCONE_TUTORIAL/HelloWorld/
> gcc hello_world.c  -o native_hello_world
> ./native_hello_world
Hello World


> ldd ./sgx_hello_world 
	linux-vdso.so.1 =>  (0x00007ffcf73ad000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f7c2a0e9000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f7c29d1f000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f7c2a306000)

> printf "Q 1\ne 0 0 0\ns 1 0 0\n" | sudo tee /etc/sgx-musl.conf

> ./sgx_hello_world
Hello World

> SCONE_VERSION=1 ./sgx_hello_world
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
export SCONE_SGXBOUNDS=no
export SCONE_ALLOW_DLOPEN=no
Revision: 9b355b99170ad434010353bb9f4dca24e532b1b7
Branch: master
Configure options: --enable-file-prot --enable-shared --enable-debug --prefix=/scone/src/built/cross-compiler/x86_64-linux-musl

Hello World



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
Hello World

[Error] Could not create enclave: Error opening SGX device

export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=67108864
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=sim
Configure parameters: 
1.1.15
Hello World

export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=67108864
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=sim
Configure parameters:
1.1.15
HelloWorld

Hello World
head strace.log
execve("/usr/src/myapp/sgx_hello_world", ["/usr/src/myapp/sgx_hello_world"], [/* 10 vars */]) = 0
brk(NULL)                               = 0x10e8000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f17f07f1000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=18506, ...}) = 0
mmap(NULL, 18506, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f17f07ec000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
