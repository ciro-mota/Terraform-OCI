#!/usr/bin/env bash
#
# Modify this script as needed to apply your deployment as soon as the instance starts.
#

if [ -f /etc/debian_version ]; then
	export DEBIAN_FRONTEND=noninteractive
	sudo apt-get -q update && sudo apt-get -qy install ansible

	firewallDebRule() {
		echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
		echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
		sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited && sudo netfilter-persistent save
	}

	firewallDebRule

elif [ -f /etc/redhat-release ]; then
	sudo dnf install -y ansible-core

	firewallRhelRule() {
		firewall-cmd --permanent --zone=public --add-port=80/tcp &&
		firewall-cmd --permanent --zone=public --add-port=443/tcp &&
		firewall-cmd --reload
	}

	firewallRhelRule

	ansible-galaxy collection install community.general
else
	echo "Unsuported Distro."
fi

tee -a requirements.yml <<'EOF'
---
- src: nginxinc.nginx
EOF

tee -a playbook.yml <<'EOF'
---
- name: "Provision Nginx"
  hosts: localhost
  become: true
  roles:
    - nginxinc.nginx
EOF

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml

printf "<h1>Oracle OCI - It Works</h1>" >/usr/share/nginx/html/index.html
