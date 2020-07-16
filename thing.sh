
if [ $(sudo md5sum /home/ansible/.ssh/id_rsa.pub| awk '{print $1}') == $(sudo md5sum /home/ansible/.ssh/authorized_keys| awk '{print $1}') ]; then
	echo "Keys match"
else
	echo "keys don't match"
fi
