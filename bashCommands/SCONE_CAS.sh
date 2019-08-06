
$ export SCONE_MANAGER=faye
$ scone swarm ls
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         edna                 Ready      Active        Reachable 
1             1             SCONE         SCONE         faye                 Ready      Active        Leader    
$ scone service pull sconecuratedimages/services:las
$ scone service create --detach=true --mode global --publish mode=host,target=18766,published=18766 --name=las localhost:5000/services:las
$ scone service ps las
ID                  NAME                            IMAGE                            NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
xvnsruar64qx        las.q26sp44pp12uf81zlyhb5pnxf   localhost:5000/services:las       edna                Running             Running 3 minutes ago                       *:18766->18766/tcp
zfgx4t292ew6        las.cr3bxhy0nqmg77goxaih5sw8d   localhost:5000/services:las       dorothy             Running             Running 3 minutes ago                       *:18766->18766/tcp
n441o9qqmnwa        las.os7ihjrel2jb4bplcn81h7f0i   localhost:5000/services:las       faye                Running             Running 3 minutes ago                       *:18766->18766/tcp
$ scone service pull sconecuratedimages/services:cas
$ scone service create --name cas --detach=true  --publish 8081:8081 --publish 18765:18765 localhost:5000/services:cas
$ scone service ps cas
ID                  NAME                IMAGE                            NODE                DESIRED STATE       CURRENT STATE         ERROR               PORTS
e6b0skuph9ve        cas.1               localhost:5000/services:cas   edna                Running             Running 3 hours ago                       