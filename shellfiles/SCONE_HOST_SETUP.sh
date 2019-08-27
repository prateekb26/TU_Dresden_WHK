
echo next
$ scone host install --name alice
echo next
$ scone host check --name alice
echo next
$ scone host install --name alice --as-manager
$ scone host install --name bob --as-manager --join alice
$ scone host install --name caroline  --join alice
echo next
