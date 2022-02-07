#!/usr/bin/env bash
#
# Modifique este script quando necessário para aplicar sua implantação assim que a instância iniciar.
#

# Exporta a variável para não solicitar confirmações durante operações de atualização.
export DEBIAN_FRONTEND=noninteractive

# Função com os comandos à serem usados no Ubuntu.
ubuntu() {
	echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
	echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
	sudo apt update
	sudo apt upgrade -y
	sudo apt install apache2 -y
	sudo iptables -D INPUT -j REJECT --reject-with icmp-host-prohibited && sudo netfilter-persistent save
}

# Função com os comandos à serem usados no Oracle Linux.
oraclelinux () {
	sudo dnf update -y
	sudo dnf install httpd -y
	sudo systemctl enable httpd
	sudo systemctl restart httpd
	sudo firewall-cmd --add-service=http --permanent
	sudo firewall-cmd --reload
}

# Função com os comandos à serem usados no CentOS 7.
centos7 () {
	sudo yum update -y
	sudo yum install httpd -y
	sudo systemctl enable httpd
	sudo systemctl restart httpd
	sudo firewall-cmd --add-service=http --permanent
	sudo firewall-cmd --reload
}

# Verifica os sistemas e executa o respectivo script.
if [[ $(lsb_release -is) = 'Ubuntu' ]] </dev/null >/dev/null 2>&1; then
	ubuntu
elif [[ $(cat /etc/oracle-release | awk '{ print $1 }') = "Oracle" ]] </dev/null >/dev/null 2>&1; then
	oraclelinux
else
	centos7
fi
