

docker pull sconecuratedimages/crosscompilers
docker run -it  sconecuratedimages/apps:python-2.7-alpine3.6 sh
SCONE_HASH=1 SCONE_ALPINE=1 /usr/local/bin/python 5430b3c0ab0e8a24ea4481e6022704cdbbcff68f6457eb0cdeaecfd734fec541

SCONE_HEAP=2G SCONE_HASH=1 SCONE_ALPINE=1 /usr/local/bin/python aa25d6e1863819fca72f4f3315131ba4a438d1e1643c030190ca665215912465

SCONE_ALLOW_DLOPEN=1 SCONE_HEAP=2G SCONE_HASH=1 SCONE_ALPINE=1 /usr/local/bin/python 9c56db536e046a5fb84a5c482ce86e6592071dff75dc0e3eb27d701cf2c40508

SCONE_ALLOW_DLOPEN=1 SCONE_HEAP=2G SCONE_VERSION=1 SCONE_ALPINE=1 /usr/local/bin/python
export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=2147483648
export SCONE_STACK=81920
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=sim
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=yes (protected)
export SCONE_MPROTECT=no
Revision: b6a40e091e2adb253f019401723d2a734e887a74 (Fri Jan 26 07:44:44 2018 +0100)
Branch: master (dirty)
Configure options: --enable-shared --enable-debug --prefix=/scone/src/built/cross-compiler/x86_64-linux-musl

Enclave hash: 9c56db536e046a5fb84a5c482ce86e6592071dff75dc0e3eb27d701cf2c40508
Python 2.7.14 (default, Jan 10 2018, 05:35:30) 
[GCC 6.4.0] on linux2
Type "help", "copyright", "credits" or "license" for more information.