

$ scone host install --name dorothy 

$ scone host install --name faye --as-manager

$ scone swarm ls --manager faye
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         faye                 Ready      Active        Leader    

$ scone host install --name edna --join faye

$ scone swarm ls --manager faye`
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         edna                 Ready      Active                  
2             1             SCONE         SCONE         faye                 Ready      Active        Leader    

$ scone host install --name edna --join faye --as-manager

$ scone host swarm --name dorothy --join faye 

$ scone host swarm --name dorothy --join faye --as-manager

$ scone host check --name faye

$ sudo lsof | grep dev/isgx 

$ scone host reboot --name  dorothy --force 

$ scone host reboot --name  dorothy --force --wait

$ scone host uninstall --name  edna --force --manager faye

$ scone host uninstall --name  edna --force --noswarm

$ scone host check --name faye
$ scone swarm ls --manager faye
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         faye                 Ready      Active        Leader    

$ scone host uninstall --name faye --noswarm --manager faye --force