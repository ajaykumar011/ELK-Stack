#!/bin/bash
yum -y -q install git curl wget openssl
echo "RUN THIS SCRIPT FROM the downloaded location of git"
echo “your current directory is: ”
pwd

echo "--------------------Current user--------------------------"
who am i
echo "--------------------Installation Starts--------------------"
rm -rf /etc/yum.repos.d/elastic-beats.repo
sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch
echo [beats] >>/etc/yum.repos.d/elastic-beats.repo
echo name=Elastic Beats Repository >> /etc/yum.repos.d/elastic-beats.repo
echo baseurl=https://packages.elastic.co/beats/yum/el/'$basearch' >> /etc/yum.repos.d/elastic-beats.repo
echo enabled=1 >> /etc/yum.repos.d/elastic-beats.repo
echo gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch >> /etc/yum.repos.d/elastic-beats.repo
echo gpgcheck=1 >> /etc/yum.repos.d/elastic-beats.repo

sudo yum -y -q install filebeat
sudo scp elkuser@logio.cloudocean.guru:/etc/pki/tls/certs/logstash-forwarder.crt /tmp
sudo cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/
cd ~
curl -O https://github.com/ajaykumar011/elkclient/blob/master/filebeat.yml
cp filebeat.yml /etc/filebeat/
sudo systemctl start filebeat
sudo systemctl enable filebeat
echo "------------------------------------------------------------------------"
echo " Great your client is connected to logio.cloudcean.guru ELK Server"
echo "------------------------------------------------------------------------"
