rm -rf ~/.cache
ssh-keygen -t rsa -C "example@example.com"
sudo apt-get update && sudo apt-get upgrade && sudo apt-get install python3-pip -y
sudo pip3 install ansible
sudo mkdir -p /etc/ansible
echo localhost| sudo tee /etc/ansible/hosts

echo confirming ansible is installed...
ansible -m ping all
