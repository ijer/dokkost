#install dokku
echo '--- installing dokku ---\n'
sudo apt-get update
apt-get install -y python-software-properties
wget -qO- https://raw.github.com/progrium/dokku/v0.2.2/bootstrap.sh | sudo DOKKU_TAG=v0.2.2 bash

#install dokku plugins
echo '--- installing dokku plugins (domains and mysql) ---\n'
cd /var/lib/dokku/plugins
git clone https://github.com/wmluke/dokku-domains-plugin.git domains-plugin
git clone https://github.com/statianzo/dokku-supervisord.git dokku-supervisord
git clone https://github.com/hughfletcher/dokku-mysql-plugin mysql
chmod +x mysql/install mysql/commands mysql/pre-release
dokku plugins-install

#add swap of 512Mb
echo '--- adding swap space ---\n'
dd if=/dev/zero of=/extraswap bs=1M count=512
mkswap /extraswap
echo '/extraswap         none            swap    sw                0       0' >> /etc/fstab
swapon -a

echo '--- installation completed ---\n'
