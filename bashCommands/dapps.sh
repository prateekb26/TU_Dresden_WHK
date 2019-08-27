
echo next
git clone https://github.com/scontain/copy_dapp.git
cd copy_dapp
echo next
./build-image.sh
echo next
mkdir -p EXAMPLE
cd EXAMPLE
mkdir -p KEYS INPUTS OUTPUTS ZIP
echo "Hello world" > INPUTS/f1.txt
echo "Hello together" > INPUTS/f2.txt
cp ../copy_dapp.yml KEYS/
echo next
CMD=$(docker run -t --rm -v $PWD/KEYS:/conf -v $PWD/INPUTS:/inputs sconecuratedimages/iexecsgx:scone.cli encryptedpush --application sconecuratedimages/iexecsgx:copy_demo -t /conf/copy_dapp.yml)
echo next
echo $CMD
echo next
 "cmdline": --sessionID 180713033312847980809017601/application --secretManagementService 87.190.236.136 --url https://filepush.co/XPHT/scone-upload.zip
echo next
ssh $host docker pull sconecuratedimages/iexecsgx:copy_demo
echo next

echo next
URL=$(ssh $host docker run -t --device=/dev/isgx --rm sconecuratedimages/iexecsgx:copy_demo ${CMD//[$'\t\r\n']} --push filepush.co/upload)
echo next
echo $URL
echo next
https://filepush.co/qSMf/scone-upload.zip
echo next
curl --output ZIP/encryptedOutputFiles.zip ${URL//[$'\t\r\n']}
echo next
docker run -t --rm -v $PWD/KEYS:/conf -v $PWD/ZIP:/encryptedOutputs  -v  $PWD/OUTPUTS:/decryptedOutputs sconecuratedimages/iexecsgx:scone.cli decrypt
echo next
cat OUTPUTS/f1.txt
echo next
cat OUTPUTS/f2.txt