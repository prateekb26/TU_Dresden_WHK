

Host node2
     HostName node2.my.very.long.domain.com
     Port 22
     User scone
     IdentityFile ~/.ssh/id_rsa

Host alice
        ControlMaster auto
        ControlPath ~/.ssh/ssh_mux_%h_%p_%r
        user ubuntu
        port 10101
        hostname sshproxy.cloudprovider.com


$ cp -rf $HOME/.xssh/* $HOME/.ssh

$ SA=$(ssh-agent)
$ eval "$SA"

$ ssh-add

alice ALL=(ALL) NOPASSWD: ALL

$ ssh-keygen -b 4096 -t rsa
