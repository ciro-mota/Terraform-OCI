#!/bin/bash
#
# Modify this script as needed to apply your deployment as soon as the instance starts.
#

if [ -f /etc/debian_version ]; then
  export DEBIAN_FRONTEND=noninteractive
  apt-get -q update && apt-get -qy install ansible

  firewallDebRule() {
		echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
		echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
		sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited && sudo netfilter-persistent save
	}

	firewallDebRule

elif [ -f /etc/redhat-release ]; then
  dnf install -y ansible-core firewalld

  firewallrule() {
    systemctl start firewalld && \
    systemctl enable firewalld && \
    firewall-cmd --permanent --zone=public --add-port=80/tcp && \
    firewall-cmd --permanent --zone=public --add-port=443/tcp && \
    firewall-cmd --reload
    }

  firewallrule
  ansible-galaxy collection install community.general
else
  echo "Unsuported Distro."
fi

tee -a requirements.yml <<'EOF'
---
- src: dev-sec.ssh-hardening
- src: geerlingguy.nginx
EOF

tee -a playbook.yml <<'EOF'
---
- hosts: localhost
  become: true
  vars:
    ssh_kex:
    - sntrup761x25519-sha512@openssh.com
    - curve25519-sha256@libssh.org
    - diffie-hellman-group-exchange-sha256
    ssh_server_ports: ['22']
    ssh_permit_root_login: "without-password"
    ssh_use_pam: "true"
    sshd_authenticationmethods: "publickey"
    ssh_authorized_keys_file: ".ssh/authorized_keys"
  become: true
  tasks:
    - name: Install Nginx
      include_role:
        name: geerlingguy.nginx
    - name: SSH Hardening
      include_role:
        name: dev-sec.ssh-hardening
  handlers:
    - name: start nginx
      service:
        name: nginx
        state: started
EOF

ansible-galaxy install -r requirements.yml
ansible-playbook playbook.yml

if [ -f /etc/debian_version ]; then
  printf "<h1>DigitalOcean - It Works</h1>" > /var/www/html/index.nginx-debian.html
elif [ -f /etc/redhat-release ]; then
  printf "<h1>DigitalOcean - It Works</h1>" > /usr/share/nginx/html/index.html
else
  echo "Unsuported Distro."
fi
