
echo next
echo next
echo next
mkdir -p INPUTS OUTPUTS
echo "Hello World" > INPUTS/f1.txt
echo next
echo next
cat OUTPUTS/f1.txt
echo next
mkdir -p EXAMPLE
TRANSFER="transfer.sh"
CAS="ask info@scontain.com for CAS hostname"
cd EXAMPLE
mkdir -p conf INPUTS OUTPUTS
echo next
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
