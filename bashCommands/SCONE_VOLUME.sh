

$ scone volume  install --verbose --manager alice  --capacity 15

$ scone volume  install --verbose --manager alice  --as scone --capacity 5 --silo  my-silo --network scone-networkg

$ scone volume install --manager alice --help

$ scone volume  create --verbose --fast --name new-volume --verbose

$ scone volume  create --verbose --manager alice  --as scone --name  my-volume --capacity 5 --silo  my-silo --network scone-network  --export config

$ scone volume  check --verbose --manager alice

$ scone volume  delete --verbose --manager alice --volume new-volume

$ scone volume  install --verbose --manager faye  --capacity 15 

$ scone volume create --verbose --manager faye --as test_scone_user --name  test_scone_volume 

$ scone volume  create --verbose --fast --manager faye --as test_scone_user  --name  test_scone2_volume 

$ scone volume  check --verbose --manager faye 

$ scone volume delete --verbose --manager faye  --as test_scone_user --name  test_scone2_volume