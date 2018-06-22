#!/bin/bash
echo “your current directly is: ”
pwd
echo " Current user"
who am i
sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
sudo cat <<EOF >/etc/yum.repos.d/elastic-beats.repo
[beats]
name=Elastic Beats Repository
baseurl=https://packages.elastic.co/beats/yum/el/$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1
EOF
sudo yum -y install filebeat
cd ~
sudo scp elkuser@logio.cloudocean.guru:/etc/pki/tls/certs/logstash-forwarder.crt /tmp
sudo cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
cp filebeat.yml /etc/filebeat/
sudo systemctl start filebeat
sudo systemctl enable filebeat
