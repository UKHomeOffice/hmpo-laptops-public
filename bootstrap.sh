##Disable IPv6
GRUBFILE='/etc/default/grub'
echo Removing IPv6 functionality
sudo sed -i -e 's/""/"ipv6.disable=1"/g'  /etc/default/grub
sudo sed -i -e 's/quiet splash"/quiet splash ipv6.disable=1"/g'  $GRUBFILE


##Test IPv 6 config lines are in place
echo Checking IPv6 lines are in grub config file
grep "ipv6.disable=1" $GRUBFILE

##INSTALL ANSIBLE
echo installing ansible and configuring ansible
rm -rf ~/.cache
FILE=/home/oem/.ssh/id_rsa
if [ -f $FILE ]; then
   echo "File $FILE already exists."
else
   echo "File $FILE does not exist. Creating."
   ssh-keygen -t rsa -C "example@example.com"
fi
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install python3-pip -y
sudo pip3 install ansible
sudo mkdir -p /etc/ansible
echo localhost| sudo tee /etc/ansible/hosts

#TEST ANSIBLE IS INSTALLED
echo confirming ansible is installed...
ansible -m ping all


##INSTALL GALAXY DEPENDANCIES
sudo mkdir -p /etc/ansible/roles
sudo mkdir -p /usr/share/ansible/roles
echo APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 | sudo tee /etc/environment #circumnavigate apt error
ansible-galaxy install darkwizard242.googlechrome
ansible-galaxy install oefenweb.slack


#Run playbook
ansible-playbook playbook.yml

##Test if chrome is installed 
google-chrome &
slack &


