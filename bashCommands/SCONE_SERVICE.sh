

$  scone service registry --manager MANAGER

   REPOSITORY/IMAGE[:TAG]

   localhost:5000/IMAGE[:TAG]

$ export SCONE_MANAGER=faye
$ scone service registry

$ scone service pull sconecuratedimages/sconetainer:shielded

$ scone service create --name nginx-shielded --detach=true  --publish 8090:8080 --publish 8092:8082 localhost:5000/sconetainer:shielded