
echo next
$ scone stack deploy --compose-file compose.yml --manager faye nginx
echo next
$ export SCONE_MANAGER=faye
$ scone stack deploy --compose-file compose.yml nginx