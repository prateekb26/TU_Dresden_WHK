
echo next
curl -fssl https://raw.githubusercontent.com/SconeDocs/SH/master/install_sgx_driver.sh | bash
echo next
ls /dev/isgx >/dev/null 2>1  && echo "SGX Driver installed" || echo "SGX Driver NOT installed"
echo next
# preferred alternative: required for swarms to work: SGX device is available in all containers by default
docker run --rm sconecuratedimages/checksgx || echo "SGX device is not automatically mapped inside of container"
echo next
# alternative: use --device option without --privileged flag
docker run --device=/dev/isgx --rm sconecuratedimages/checksgx || echo "--device=/dev/isgx: failed to map SGX device inside of container"
echo next
# last alternative: use --device option with --privileged flag
sudo docker run -v /dev/isgx:/dev/isgx --privileged  --rm sconecuratedimages/checksgx || echo "SGX device NOT available inside of container"