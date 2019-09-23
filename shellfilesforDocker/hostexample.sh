


gcc -o helloworld helloworld.c

SCONE_VERSION=1 ./helloworld

exit

cat > sgx-musl.conf << EOF
Q 1
e -1 0 0
s -1 0 0
EOF

SCONE_CONFIG="$PWD"/sgx-musl.conf SCONE_VERSION=1 ./helloworld
