#!/bin/bash

sudo yum install -y nfs-utils

sudo systemctl enable firewalld --now

sudo firewall-cmd --add-service="nfs3" \
--add-service="rpc-bind" \
--add-service="mountd" \
--permanent 

sudo firewall-cmd --reload

sudo systemctl enable nfs --now

sudo mkdir -p /srv/share/upload
sudo chown -R nfsnobody:nfsnobody /srv/share
sudo chmod 0777 /srv/share/upload

sudo cat << EOF > /etc/exports 
/srv/share 192.168.50.11/32(rw,sync,root_squash) 
EOF
sudo exportfs -r
sudo exportfs -s