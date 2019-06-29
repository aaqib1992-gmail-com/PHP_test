# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$install_requirements = <<SCRIPT

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/homestead_password password secret'
sudo debconf-set-selections <<< 'mysql-server mysql-server/homestead_password_again password secret'

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install software-properties-common
sudo add-apt-repository -y ppa:ondrej/php
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update

export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y php7.3 apache2 libapache2-mod-php7.3 php7.3-curl php7.2-gd php7.1-mcrypt php7.3-readline mysql-server-5.7 php7.3-mysql php7.3-zip git-core
sudo apt-get install -y apache2 git curl php7.3 php7.3-bcmath php7.3-bz2 php7.3-cli php7.3-curl php7.3-intl php7.3-json php7.3-mbstring php7.3-opcache php7.3-soap php7.3-sqlite3 php7.3-xml php7.3-xsl php7.3-zip libapache2-mod-php7.3 php-xdebug memcached php-memcached nodejs rubygems-integration beanstalkd supervisor

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y update
sudo apt-get -y upgrade

sudo npm install -g npm

# directory=“/home/vagrant/$$”
su -c "mkdir /home/vagrant/node_modules" vagrant
cd /vagrant
rm -rf node_modules
su -c "ln -s /home/vagrant/node_modules /vagrant/node_modules" vagrant

npm install -g npm-check-updates grunt grunt-cli

su -c "cd /vagrant; npm install" vagrant

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install ruby-dev
sudo gem install compass

mysql -u homestead -psecret -e'create database races'

cat << EOF | sudo tee -a /etc/php/7.3/mods-available/xdebug.ini
xdebug.remote_enable = on
xdebug.remote_connect_back = on
xdebug.idekey = "vagrant"

xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

mysql -u homestead -psecret -e"grant all on *.* to homestead@'192.168.33.1' IDENTIFIED BY 'secret'" mysql

sudo a2enmod rewrite

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php/7.3/cli/php.ini
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/my.cnf
sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd

# add supervisor config for laravel beantstalk queue
SUPER=$(cat <<EOF
command=php artisan queue:listen --queue=offload-notification --tries=1 --env=vagrant
directory=/vagrant
stdout_logfile=/vagrant/app/storage/logs/offload-notification_supervisord.log
redirect_stderr=true
autostart=true
autorestart=true
EOF
)
echo "${SUPER}" > /etc/supervisor/conf.d/offload-notification.conf

#need to do this for some port collision issue
sudo unlink /var/run/supervisor.sock

#start services
sudo service mysql restart
sudo service apache2 restart
sudo service beanstalkd start
sudo service supervisor start

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

echo "Australia/Sydney" | sudo tee /etc/timezone
[program:offload-notification]
echo "cd /vagrant" >> /home/vagrant/.bashrc


echo "192.168.33.33 phptest.test" | sudo tee -a /etc/hosts

cd /vagrant
composer install
php artisan migrate
php artisan db:seed

SCRIPT

$vhost_setup = <<SCRIPT
VHOST=$(cat <<EOF
<VirtualHost *:80>
  DocumentRoot "/vagrant/public"
  ServerName localhost
  ServerAlias risk.dev
  <Directory "/vagrant/public">
    AllowOverride All
    Require all granted
  </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

sudo service apache2 restart
SCRIPT


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision "shell", inline: $install_requirements
  config.vm.provision "shell", inline: $vhost_setup
  config.vm.box = "laravel/homestead"
  config.vm.network "forwarded_port", guest: 80, host: 8013
  #config.vm.network "forwarded_port", guest: 8001, host: 8000
  config.vm.network "private_network", ip: "192.168.33.33"
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777","fmode=776"]

  config.vm.provider "virtualbox" do |v|
          host = RbConfig::CONFIG['host_os']

          # Give VM 1/8 system memory & access to all cpu cores on the host
          if host =~ /darwin/
            cpus = `sysctl -n hw.ncpu`.to_i
            # sysctl returns Bytes and we need to convert to MB
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 8
          elsif host =~ /linux/
            cpus = `nproc`.to_i
            # meminfo shows KB and we need to convert to MB
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 8
          else # sorry Windows folks, I can't help you
            cpus = 2
            mem = 1024
          end

          v.customize ["modifyvm", :id, "--memory", mem]
          v.customize ["modifyvm", :id, "--cpus", cpus]
        end
end
