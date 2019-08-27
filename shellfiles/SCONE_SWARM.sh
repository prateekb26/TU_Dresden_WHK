
echo next
$ scone swarm ls --manager faye
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         dorothy              Ready      Active                  
2             1             SCONE         SCONE         edna                 Ready      Active                  
3             1             SCONE         SCONE         faye                 Ready      Active        Leader   
echo next
$ scone swarm ls --manager alice
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         alice                Ready      Active        Leader    
2             1             SCONE         SCONE         beatrix              Ready      Active                  
3             1             SCONE         SCONE         caroline             Ready      Active                  
echo next
$ export SCONE_MANAGER=faye
$ scone swarm ls 
NODENO        SGX VERSION   DOCKER-ENGINE SGX-DRIVER    HOST                 STATUS     AVAILABILITY  MANAGER   
1             1             SCONE         SCONE         dorothy              Ready      Active                  
2             1             SCONE         SCONE         edna                 Ready      Active                  
3             1             SCONE         SCONE         faye                 Ready      Active        Leader   
echo next
$ scone swarm check --manager faye --verbose
