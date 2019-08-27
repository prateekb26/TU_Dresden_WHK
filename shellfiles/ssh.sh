
echo next
Host node2
     HostName node2.my.very.long.domain.com
     Port 22
     User scone
     IdentityFile ~/.ssh/id_rsa
echo next
Host alice
        ControlMaster auto
        ControlPath ~/.ssh/ssh_mux_%h_%p_%r
        user ubuntu
        port 10101
        hostname sshproxy.cloudprovider.com
echo next
echo next
$ cp -rf $HOME/.xssh/* $HOME/.ssh
echo next
$ SA=$(ssh-agent)
$ eval "$SA"
echo next
$ ssh-add
echo next
alice ALL=(ALL) NOPASSWD: ALL
echo next
$ ssh-keygen -b 4096 -t rsa
