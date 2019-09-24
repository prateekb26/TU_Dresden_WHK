

scone rustc --version

mkdir ~/projects
cd ~/projects
mkdir hello_world
cd hello_world

cat > main.rs << EOF
fn main() {
    println!("Hello, world!");
}
EOF

scone rustc main.rs
ls
main  main.rs

SCONE_MODE=HW SCONE_VERSION=1 ./main

scone cargo build --target=x86_64-scone-linux-musl

OPENSSL_LIB_DIR=/libressl-2.4.5 OPENSSL_INCLUDE_DIR=/libressl-2.4.5/include/ OPENSSL_STATIC=1 PKG_CONFIG_ALLOW_CROSS=1 scone-cargo build --target=scone 
