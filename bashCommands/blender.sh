
echo next
docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:blender_python --host faye
echo next
docker run -it --rm -v $PWD/INPUTS:/inputs -v  $PWD/OUTPUTS:/decryptedOutputs  -v $PWD/conf/:/conf sconecuratedimages/iexecsgx:cli execute --application sconecuratedimages/iexecsgx:blender_python --host faye