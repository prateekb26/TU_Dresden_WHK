
echo next
$ scone volume  install --verbose --manager alice  --capacity 15
echo next
$ scone volume  install --verbose --manager alice  --as scone --capacity 5 --silo  my-silo --network scone-networkg
echo next
$ scone volume install --manager alice --help
echo next
$ scone volume  create --verbose --fast --name new-volume --verbose
echo next
$ scone volume  create --verbose --manager alice  --as scone --name  my-volume --capacity 5 --silo  my-silo --network scone-network  --export config
echo next
$ scone volume  check --verbose --manager alice
echo next
$ scone volume  delete --verbose --manager alice --volume new-volume
echo next
$ scone volume  install --verbose --manager faye  --capacity 15 
echo next
$ scone volume create --verbose --manager faye --as test_scone_user --name  test_scone_volume 
echo next
$ scone volume  create --verbose --fast --manager faye --as test_scone_user  --name  test_scone2_volume 
echo next
$ scone volume  check --verbose --manager faye 
echo next
$ scone volume delete --verbose --manager faye  --as test_scone_user --name  test_scone2_volume
