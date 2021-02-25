# Repository for configuring an Ubuntu laptop

This repo contains files used for basic configuration of Ubuntu Desktop 18.04 using ansible.

## Pre-requisites for using this repo

* Ubuntu Desktop 18.04 LTS installed on Ubuntu Certified hardware.

* A working internet connection on the target laptop.

* Updated packages and installs. Specifically, `git` to pull this repo onto the target and `ansible` (2.8 or higher) for running snap installs in the playbook.

```
sudo apt-add-repository -y --update ppa:ansible/ansible
sudo apt update
sudo apt install git ansible
cd $TARGET_DIRECTORY
git clone $TARGET_GIT_URL

## Intended usage of this repo

As part of a scheduled cron job this ansible can be pulled down and run on a target computer to complete basic configuration. 
