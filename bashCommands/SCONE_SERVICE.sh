
echo next
$  scone service registry --manager MANAGER
echo next
   REPOSITORY/IMAGE[:TAG]
echo next
   localhost:5000/IMAGE[:TAG]
echo next
$ export SCONE_MANAGER=faye
$ scone service registry
echo next
$ scone service pull sconecuratedimages/sconetainer:shielded
echo next
$ scone service create --name nginx-shielded --detach=true  --publish 8090:8080 --publish 8092:8082 localhost:5000/sconetainer:shielded