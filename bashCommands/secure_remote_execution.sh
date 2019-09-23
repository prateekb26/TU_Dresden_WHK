

docker run -it --rm -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli add-host --alias caroline --hostname 1.2.3.4

docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:copy_demo --host caroline

mkdir -p INPUTS OUTPUTS
echo "Hello World" > INPUTS/f1.txt

docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:copy_demo --host caroline

cat OUTPUTS/f1.txt

mkdir -p EXAMPLE
TRANSFER="transfer.sh"
CAS="ask info@scontain.com for CAS hostname"
cd EXAMPLE
mkdir -p conf INPUTS OUTPUTS

alias aeblender="docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:blender --host caroline  -r $TRANSFER  -s $CAS"

curl https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/master/iExecBlockchainComputing/Blender/iexec-rlc.blend -o INPUTS/iexec-rlc.blend

aeblender

open OUTPUTS/0001.png

curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/cube.blend

aeblender

curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/scene-Helicopter-27-cycles.blend

aeblender

curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/bmw27_cpu.blend

aeblender