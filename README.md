# Repository for configuring an Ubuntu laptop

This repo contains files used to configure an oem install of Ubuntu 18.04 LTS. This has been tested on Dell XPS 13 7390 hardware.


## Pre-requisites

After booting the laptop off an Ubuntu 18.04 LTS USB key and choosing the oem install you will then be prompted to remove the USB key and reboot.

On logging in, connect to WiFi, browse to https://bitbucket.org/automationlogic/ubuntu_build to confirm connectivity.

As `git` is not installed this is a pre-requisite for using this repo. Run the following from the terminal (`Ctrl+Alt+T`) after completing the oem install steps.

```
sudo apt update
sudo apt install git
cd /home/oem
git clone https://bitbucket.org/automationlogic/ubuntu_build.git
```

[PLEASE NOTE: If the "Software Updater" pops up saying there are new updates, then apply these updates.]

## Next steps

Using the same terminal window...

```
cd ubuntu_build
bash bootstrap.sh
```

This will print output to the screen to inform you of the progress. Check the output for errors and address any that you see - this might involve changes to the scripts being used to accommodate new issues but hopefully the errors are already known so the error message should indicate how to fix it.

Following the ansible changes the laptop should be ready for the final steps.

First of all remove the wifi credentials then follow the guidance given on internal docs to harden the laptop prior to handing to the user..

## Work flow

Once bootstrapped, software is installed and configuration changes are made. Please check the code for details.

The config changes create a cron job that's scheduled to run ansible at regular intervals. This allows for config to be modified and confirmed by the script.

When the cron job runs it will...

1. Update the ansible repo (`git pull`) within the ansible user's home directory.
1. Execute the updated ansible task.

Changes to this repo should (according to the planned design) allow for ongoing management of laptops setup in this way. A change to the repo will be picked up by the running cron job and then that change can be implemented on the laptop.

## Manual checks

To confirm things are working as expected you can:

1. Check the crontab for the ansible user, `sudo crontab -l -u ansible`
1. Check for the existence of this repo, `ls /home/ansible/ && echo -e "$(tput setaf 2 && tput bold)\n\nIT'S FINE :-)\n\n"` (i.e. does the folder location exist, `git pull` in this folder should also work)
1. Check the logs for ansible. These are in the ansible home directory `ansible.log` and `ansible_err.log`.
1. Run the `bootstrap.sh` again... `bash bootstrap.sh` - this will reapply the correct config and ensure everything is setup correctly.
1. Run the playbook... `ansible-playbook main.yml` - use the crontab command if having trouble..
