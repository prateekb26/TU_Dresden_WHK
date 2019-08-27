
echo next
curl -fssl https://raw.githubusercontent.com/SconeDocs/SH/master/install_sgx_driver.sh | bash
echo next
ls /dev/isgx >/dev/null 2>1  && echo "SGX Driver installed" || echo "SGX Driver NOT installed"
echo next
# preferred alternative: required for swarms to work: SGX device is available in all containers by default
echo next
# alternative: use --device option without --privileged flag
echo next
# last alternative: use --device option with --privileged flag
