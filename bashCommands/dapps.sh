

git clone https://github.com/scontain/copy_dapp.git
cd copy_dapp

./build-image.sh

mkdir -p EXAMPLE
cd EXAMPLE
mkdir -p KEYS INPUTS OUTPUTS ZIP
echo "Hello world" > INPUTS/f1.txt
echo "Hello together" > INPUTS/f2.txt
cp ../copy_dapp.yml KEYS/

CMD=$(docker run -t --rm -v $PWD/KEYS:/conf -v $PWD/INPUTS:/inputs sconecuratedimages/iexecsgx:scone.cli encryptedpush --application sconecuratedimages/iexecsgx:copy_demo -t /conf/copy_dapp.yml)

echo $CMD

 "cmdline": --sessionID 180713033312847980809017601/application --secretManagementService 87.190.236.136 --url https://filepush.co/XPHT/scone-upload.zip

ssh $host docker pull sconecuratedimages/iexecsgx:copy_demo



URL=$(ssh $host docker run -t --device=/dev/isgx --rm sconecuratedimages/iexecsgx:copy_demo ${CMD//[$'\t\r\n']} --push filepush.co/upload)

echo $URL

https://filepush.co/qSMf/scone-upload.zip

curl --output ZIP/encryptedOutputFiles.zip ${URL//[$'\t\r\n']}

docker run -t --rm -v $PWD/KEYS:/conf -v $PWD/ZIP:/encryptedOutputs  -v  $PWD/OUTPUTS:/decryptedOutputs sconecuratedimages/iexecsgx:scone.cli decrypt

cat OUTPUTS/f1.txt

cat OUTPUTS/f2.txt