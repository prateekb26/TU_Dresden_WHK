
echo next
$ scone host install --name dorothy 
echo next
$ scone host install --name faye --as-manager
echo next
$ scone swarm ls --manager faye
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         faye                 Ready      Active        Leader    
echo next
$ scone host install --name edna --join faye
echo next
$ scone swarm ls --manager faye`
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         edna                 Ready      Active                  
2             1             SCONE         SCONE         faye                 Ready      Active        Leader    
echo next
$ scone host install --name edna --join faye --as-manager
echo next
$ scone host swarm --name dorothy --join faye 
echo next
$ scone host swarm --name dorothy --join faye --as-manager
echo next
$ scone host check --name faye
echo next
$ sudo lsof | grep dev/isgx 
echo next
$ scone host reboot --name  dorothy --force 
echo next
$ scone host reboot --name  dorothy --force --wait
echo next
$ scone host uninstall --name  edna --force --manager faye
echo next
$ scone host uninstall --name  edna --force --noswarm
echo next
$ scone host check --name faye
$ scone swarm ls --manager faye
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         faye                 Ready      Active        Leader    
echo next
$ scone host uninstall --name faye --noswarm --manager faye --force