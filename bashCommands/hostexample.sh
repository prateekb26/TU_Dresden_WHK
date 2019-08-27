
echo next
docker run -it -v "$PWD":/src sconecuratedimages/crosscompilers:ubuntu
echo next
gcc -o helloworld helloworld.c
echo next
SCONE_VERSION=1 ./helloworld
echo next
exit
echo next
cat > sgx-musl.conf << EOF
Q 1
e -1 0 0
s -1 0 0
EOF
echo next
SCONE_CONFIG="$PWD"/sgx-musl.conf SCONE_VERSION=1 ./helloworld