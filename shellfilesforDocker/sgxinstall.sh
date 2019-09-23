

curl -fssl https://raw.githubusercontent.com/SconeDocs/SH/master/install_sgx_driver.sh | bash

ls /dev/isgx >/dev/null 2>1  && echo "SGX Driver installed" || echo "SGX Driver NOT installed"

# preferred alternative: required for swarms to work: SGX device is available in all containers by default

# alternative: use --device option without --privileged flag

# last alternative: use --device option with --privileged flag
