#!/usr/bin/env bash
#
# Modify this script as needed to apply your deployment as soon as the instance starts.
#

# Function with commands to be used in Ubuntu.
ubuntu() {

	# Export the variable to not ask for confirmation during update operations.
	export DEBIAN_FRONTEND=noninteractive

	echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
	echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
	sudo apt update
	sudo apt upgrade -y
	sudo apt install nginx -y
	echo -e "<h1>It Works</h1>" | sudo tee /var/www/html/index*.html
	sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited && sudo netfilter-persistent save
}

# Function with commands to be used in Oracle Linux.
oraclelinux() {

	inst() {
		sudo dnf update -y
		sudo dnf install -y nginx
	}

	firewallrule() {
		sudo firewall-cmd --permanent --zone=public --add-service=http
		sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
		sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
		sudo firewall-cmd --reload
	}

	mods() {
		sudo groupadd www
		sudo adduser -G nginx -g www -d /usr/share/nginx/html www --system --shell=/bin/false
		sudo echo -e "<h1>It Works</h1>" | sudo tee /usr/share/nginx/html/index.html
	}

	servs() {
		sudo systemctl enable --now nginx
		sudo systemctl start nginx
	}

	inst
	firewallrule
	mods
	servs
}

# Checks the systems and runs the respective script.
if [[ $(lsb_release -is) = 'Ubuntu' ]] </dev/null >/dev/null 2>&1; then
	ubuntu
else
	[[ $(cat /etc/*release | head -1 | awk '{ print $1 }') =~ ^(Oracle|AlmaLinux)$ ]] </dev/null >/dev/null 2>&1
	oraclelinux
fi