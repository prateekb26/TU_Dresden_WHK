

$ scone host install --name alice

$ scone host check --name alice

$ scone host install --name alice --as-manager
$ scone host install --name bob --as-manager --join alice
$ scone host install --name caroline  --join alice

