
echo next
$ scone service registry --verbose
Registry is already running in swarm beatrix
echo next
$ scone service pull sconecuratedimages/sconetainer:noshielding
new tag: localhost:5000/sconetainer:noshielding
echo next
$ scone service ps ha
ID                  NAME                IMAGE                      NODE                DESIRED STATE       CURRENT STATE           ERROR                       PORTS
f65id6ow5n6w        ha.1                sconecuratedimages/nginx   beatrix             Ready               Ready 1 second ago                                  
jt6wj5e3lso4         \_ ha.1            sconecuratedimages/nginx   beatrix             Shutdown            Failed 3 seconds ago    "task: non-zero exit (1)"   
sspou3mcis8m         \_ ha.1            sconecuratedimages/nginx   beatrix             Shutdown            Failed 9 seconds ago    "task: non-zero exit (1)"   
p3bw780pu63b         \_ ha.1            sconecuratedimages/nginx   beatrix             Shutdown            Failed 15 seconds ago   "task: non-zero exit (1)"   
75zjsesil5k4         \_ ha.1            sconecuratedimages/nginx   beatrix             Shutdown            Failed 22 seconds ago   "task: non-zero exit (1)"   
echo next
$ scone swarm check
warning:  'sgx device is not automatically mapped inside of container on host beatrix (stack=198 434 0)'  (Line numer: '198')
warning:  '--device=/dev/isgx: device mapper does not work inside of container on host beatrix (stack=199 434 0)'  (Line numer: '199')
echo next
$ scone swarm ls
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
2             1             SCONE         SCONE         caroline             Ready      Active        Reachable 
3             1             SCONE         SCONE         dorothy              Ready      Active                  
4             1             SCONE         SCONE         edna                 Ready      Active        Reachable 
1             1             SCONE         SCONE         beatrix              Ready      Active        Leader    
echo next
$ scone service pull sconecuratedimages/sconetainer:noshielding
new tag: localhost:5000/sconetainer:noshielding
echo next
$ scone service create --name sconeweb --detach=true  --publish 80:80 --publish 443:443 --replicas=2 localhost:5000/sconetainer:noshielding
echo next
$ scone service ps sconeweb
ID                  NAME           IMAGE                              NODE                DESIRED STATE       CURRENT STATE            ERROR                              PORTS
ba3odjkz6mx2        sconeweb.1     localhost:5000/nginx:noshielding   alice               Running             Running 8 minutes ago         
x2xq1c3aede7        sconeweb.2     localhost:5000/nginx:noshielding   beatrix               Running             Running 8 minutes ago         
echo next
$ scone service ps sconeweb
ID                  NAME                IMAGE                                        NODE                DESIRED STATE       CURRENT STATE          ERROR                              PORTS
o79714pw2fpn        sconeweb.1          sconecuratedimages/sconetainer:noshielding   alice               Running             Running 4 hours ago                                       
t0byepte0fzj         \_ sconeweb.1      sconecuratedimages/sconetainer:noshielding   beatrix             Shutdown            Rejected 4 hours ago   "No such image: sconecuratedim…"   
mg4xdq868syq         \_ sconeweb.1      sconecuratedimages/sconetainer:noshielding   beatrix             Shutdown            Rejected 4 hours ago   "No such image: sconecuratedim…"   
ry1pqen9jgan         \_ sconeweb.1      sconecuratedimages/sconetainer:noshielding   beatrix             Shutdown            Rejected 4 hours ago   "No such image: sconecuratedim…"   
q05ti7gkxc7r         \_ sconeweb.1      sconecuratedimages/sconetainer:noshielding   beatrix             Shutdown            Rejected 4 hours ago   "No such image: sconecuratedim…"   
zxj74inh2zdf        sconeweb.2          sconecuratedimages/sconetainer:noshielding   alice               Running             Running 4 hours ago                                       
echo next
$ scone service rm sconeweb
echo next
$ scone pull sconecuratedimages/sconetainer:noshielding
echo next
$ scone service update --image  localhost:5000/sconetainer sconeweb
echo next
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
91a1vvex4dgozfrzy1y136gmg *   alice               Ready               Active              Leader
jhrayos9ylu02egwvkxpqtbwb     beatrix             Ready               Active              
echo next
echo next
