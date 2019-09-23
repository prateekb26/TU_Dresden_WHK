

docker run --rm sconecuratedimages/apps:check_cpuid

cat > /etc/sgx-musl.conf << EOF
Q 1
e -1 0 0
s -1 0 0
EOF