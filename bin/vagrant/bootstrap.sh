#!/usr/bin/env bash

##############################################################
# bootstrap.sh
##############################################################


#
# Execute a command as the vagrant user.
# Otherwise, commands are executed as root.
#
function v() {
  # NB: This executes the vagrant .profile.
  su - -c "$1" vagrant
}


#
# Set up Ubuntu
#
export LC_ALL=en_US.UTF-8  # Set the locale correctly
export LC_CTYPE=$LC_ALL
export LANG=$LC_ALL
export LANGUAGE=$LC_ALL
export TZ=America/Los_Angeles
export DEBIAN_FRONTEND=noninteractive
aptitude -q -y update
aptitude -q -y install curl locales git htop imagemagick libpq-dev nodejs openjdk-7-jre \
                       postgresql redis-server software-properties-common vim

#
# Install Elasticsearch
#
wget https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.6.0.deb
dpkg -i elasticsearch*
service elasticsearch start

#
# RVM and Ruby 2.1.4
#
VERSION=2.1.4
v "curl -L https://get.rvm.io | bash"
v "source ~/.rvm/scripts/rvm"
v "rvm install $VERSION"
v "rvm use --default $VERSION"
v "echo 'gem: --no-rdoc --no-ri' > /home/vagrant/.gemrc"
v "cd /vagrant ; gem update --system; gem update"
v "cd /vagrant ; gem install bundler pry mailcatcher foreman"
sed '/source "\$HOME\/\.profile"/d' /home/vagrant/.bash_profile > /home/vagrant/.profile # RVM plays with these files.
rm  /home/vagrant/.bash_profile
BASHRC=/home/vagrant/.bashrc
echo "alias ls='ls -F --color'" >> $BASHRC
echo "alias h=history" >> $BASHRC
echo "export TZ=America/Los_Angeles" >> $BASHRC
v "echo 'source ~/.bashrc' >> ~/.profile"
v "rvm rvmrc warning ignore allGemfiles"


#
# Set up the app and test it
#
sudo -u postgres createuser --superuser vagrant
v "cd /vagrant; bin/init ./"
v "cd /vagrant; rspec"
