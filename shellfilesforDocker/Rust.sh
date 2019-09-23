

$ scone rustc --version
rustc 1.20.0 (f3d6973f4 2017-08-27)

$ mkdir ~/projects
$ cd ~/projects
$ mkdir hello_world
$ cd hello_world

$ cat > main.rs << EOF
fn main() {
    println!("Hello, world!");
}
EOF

$ scone rustc main.rs
$ ls
main  main.rs

$ SCONE_MODE=HW SCONE_VERSION=1 ./main
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
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=no
export SCONE_ALLOW_DLOPEN2=no

Hello, world!

$ scone cargo build --target=x86_64-scone-linux-musl

$ OPENSSL_LIB_DIR=/libressl-2.4.5 OPENSSL_INCLUDE_DIR=/libressl-2.4.5/include/ OPENSSL_STATIC=1 PKG_CONFIG_ALLOW_CROSS=1 scone-cargo build --target=scone 
