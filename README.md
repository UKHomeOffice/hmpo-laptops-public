# Repository for configuring an Ubuntu laptop

This repo contains files used to configure an oem install of Ubuntu 18.04 LTS. This has been tested on Dell XPS 13 7390 hardware.


## Pre-requisites for using this repo

* An oem install of Ubuntu 18.04 LTS - installed from a USB key by choosing the "OEM Install (for manufacturers)" option.

* A WiFi connection/Network connection. Try browsing to https://bitbucket.org/automationlogic/ubuntu_build in a browser to confirm connectivity.

* Git needs to be installed so run the following from the terminal (`Ctrl+Alt+T`), or skip this and head to "Alternative steps".. [Hint: Ctrl+Shift+v will paste into the ubuntu terminal, Ctrl+c to copy from the browser]

```
sudo apt update
sudo apt install git
cd /home/oem
git clone https://bitbucket.org/automationlogic/ubuntu_build.git
```

[PLEASE NOTE: If the "Software Updater" pops up saying there are new updates, then apply these updates. As this uses the same package manager. i.e. apt, you can't do updates from the command line and through the UI at the same time]

## Alternative steps

Helper scripts have been written and put onto a USB key to avoid having to read any further here. Simply put the USB key into the OEM install, and from a terminal window run `bash /media/oem/USB/laptop_post_install.sh`. Doing this will guide you through what's necessary.

## Next steps (if not using the alternative)

Using the same terminal...

```
cd ubuntu_build
bash bootstrap.sh
```

This will print output to the screen to inform you of the progress. Check the output for errors and address any that you see - this might involve changes to the scripts being used to accommodate new issues but hopefully the errors are already known so the error message should indicate how to fix it.

After the ansible configuration the laptop is ready for QA. Head back to the internal documentation for more details.

## Work flow

Once bootstrapped, software is installed and configuration changes are made. Please check the code for specific details.

The config changes create a cron job that's scheduled to run ansible at regular intervals. This allows for config to be modified and confirmed by the script.

When the cron job runs it will...

1. Update the ansible repo (`git pull`) within the ansible user's home directory.
1. Execute the updated ansible task.

Changes to this repo should (according to the planned design) allow for ongoing management of laptops setup in this way. A change to the repo will be picked up by the running cron job and then that change can be implemented on the laptop.

## Manual checks if you need to troubleshoot

To confirm things are working as expected you can:

1. Check the crontab for the ansible user, `sudo crontab -l -u ansible`
1. Check for the existence of this repo, `ls /home/ansible/ && echo -e "$(tput setaf 2 && tput bold)\n\nIT'S FINE :-)\n\n"` (i.e. does the folder location exist, `git pull` in this folder should also work)
1. Check the logs for ansible. These are in the ansible home directory `ansible.log` and `ansible_err.log`.
1. Run the `bootstrap.sh` again... `bash bootstrap.sh` - this will reapply the correct config and ensure everything is setup correctly.
1. Run the playbook... `ansible-playbook main.yml` - use the crontab command if having trouble..
