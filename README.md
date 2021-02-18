# Repository for configuring an Ubuntu laptop

This repo contains files used for basic configuration of Ubuntu Desktop 18.04 using ansible.

## Pre-requisites for using this repo

* An oem install of Ubuntu Desktop 18.04 LTS installed on Ubuntu Certified hardware.

* A working internet connection on the target laptop.

* Updated packages and install git to pull this repo onto the target and ansible (with updates) for doing snap installs.

```
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt update
sudo apt install git ansible
cd $TARGET_DIRECTORY
git clone $TARGET_GIT_URL
```

## Using this repo

There is a bootstrap.sh that should help with the setup, use at your own risk. The intended use of this repo doesn't require it so it may not be up-to-date.

## Intended usage

As part of a scheduled cron job this ansible is intended to do install a subset of required software and ensure that some standard configuration is applied before the managed laptops login to the VPN.
