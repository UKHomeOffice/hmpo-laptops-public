GRUBFILE='/etc/default/grub'
USER=oem
SSHKEY=/home/$USER/.ssh/id_rsa
TIMEOUT=4

##Disable IPv6
echo Removing IPv6 functionality
sudo sed -i -e 's/""/"ipv6.disable=1"/g'  $GRUBFILE
sudo sed -i -e 's/quiet splash"/quiet splash ipv6.disable=1"/g'  $GRUBFILE


##INSTALL ANSIBLE
echo installing ansible and configuring ansible
rm -rf ~/.cache
if [ -f $SSHKEY ]; then
   echo "File $SSHKEY already exists."
else
   echo "File $SSHKEY does not exist. Creating."
   ssh-keygen -t rsa -C "example@example.com"
fi
sudo apt-get update &&\
       	sudo apt-get upgrade -y &&\
       	sudo apt-get install python3-pip -y
sudo pip3 install ansible
sudo mkdir -p /etc/ansible
echo localhost ansible_host=localhost ansible_connection=local ansible_python_interpreter=/usr/bin/python3| sudo tee /etc/ansible/hosts


##INSTALL GALAXY DEPENDANCIES
sudo mkdir -p /etc/ansible/roles
sudo mkdir -p /usr/share/ansible/roles
echo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 |\
       	sudo tee /etc/environment #circumnavigate ansible apt error
ansible-galaxy install darkwizard242.googlechrome
ansible-galaxy install oefenweb.slack


#TEST ANSIBLE IS INSTALLED
echo confirming ansible is installed... &&\
       	ansible -m ping all &&\
       	ansible-playbook site.yml  ||\
       	echo not installed

ansible-playbook site.yml
#Run playbook

##Test IPv 6 config lines are in place
echo Checking IPv6 lines are in grub config file 
grep "ipv6.disable=1" $GRUBFILE && echo ipv6 disabled || echo ipv6 not disabled 

##Test if chrome is installed 
google-chrome 2>/dev/null &
GOOGLEPID=$!
echo testing Google $GOOGLEPID
sleep $TIMEOUT
kill $GOOGLEPID 
echo Google checked

##Test if slack is installed 
slack 2>/dev/null >/dev/null &
SLACKPID=$! 
echo testing Slack $SLACKPID
sleep $TIMEOUT
kill $SLACKPID
echo Slack checked

sleep $TIMEOUT

#Test ansible user
PUB_KEY_CHECKSUM=$(sudo md5sum /home/ansible/.ssh/id_rsa.pub| awk '{print $1}')
AUTH_USERS_CHECKSUM=$(sudo md5sum /home/ansible/.ssh/authorized_keys| awk '{print $1}')
if [ "${PUB_KEY_CHECKSUM}" == "${AUTH_USERS_CHECKSUM}" ]; then
	echo "ssh key in authorized"
else
	echo "ssh key not in authorised"
fi

if [ -d "/home/ansible/ansible" ]; then
	echo "repo installed"
else
	echo "repo not installed"
fi
