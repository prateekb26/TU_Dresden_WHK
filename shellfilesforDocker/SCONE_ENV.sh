

$ sudo tee  /etc/sgx-musl.conf << EOF
Q 4
e -1 0 0
s -1 0 0
e -1 1 0
s -1 1 0
e -1 2 0
s -1 2 0
e -1 3 0
s -1 3 0
EOF

export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=2147483648
export SCONE_STACK=81920
export SCONE_LOG=6
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_ESPINS=10000
export SCONE_MODE=hw
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=yes (unprotected)
export SCONE_MPROTECT=yes
Revision: e37dda73a6db435973f2e00347bd4cf462e4e027 (Sat Aug 25 22:59:30 2018 +0200)
Branch: master
Configure options: --enable-file-prot --enable-shared --enable-debug --prefix=/scone/src/built/cross-compiler/x86_64-linux-musl
