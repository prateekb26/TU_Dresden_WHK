
echo next
docker run -it --rm -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli add-host --alias caroline --hostname 1.2.3.4
echo next
docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:copy_demo --host caroline
echo next
mkdir -p INPUTS OUTPUTS
echo "Hello World" > INPUTS/f1.txt
echo next
docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:copy_demo --host caroline
echo next
cat OUTPUTS/f1.txt
echo next
mkdir -p EXAMPLE
TRANSFER="transfer.sh"
CAS="ask info@scontain.com for CAS hostname"
cd EXAMPLE
mkdir -p conf INPUTS OUTPUTS
echo next
alias aeblender="docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:blender --host caroline  -r $TRANSFER  -s $CAS"
echo next
curl https://raw.githubusercontent.com/iExecBlockchainComputing/iexec-dapps-registry/master/iExecBlockchainComputing/Blender/iexec-rlc.blend -o INPUTS/iexec-rlc.blend
echo next
aeblender
echo next
open OUTPUTS/0001.png
echo next
curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/cube.blend
echo next
aeblender
echo next
curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/scene-Helicopter-27-cycles.blend
echo next
aeblender
echo next
curl  --output INPUTS/iexec-rlc.blend  https://raw.githubusercontent.com/golemfactory/golem/develop/apps/blender/benchmark/test_task/bmw27_cpu.blend
echo next
aeblender