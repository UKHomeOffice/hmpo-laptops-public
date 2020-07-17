# Repository for configuring an Ubuntu laptop

This repo contains files used to configure an oem install of Ubuntu 18.04 LTS. This has been tested on Dell XPS 13 7390 hardware.


## Pre-requisites

As `git` is not installed this is a pre-requisite for using this repo. Run the following from the terminal after completing the oem install steps.

```
sudo apt update
sudo apt install git
cd /home/oem
git clone https://bitbucket.org/automationlogic/ubuntu_build.git
```

## Next steps

Once the repo has been cloned onto the target machine, (in a terminal window) `cd /home/oem/ubuntu_build` then run `bash bootstrap.sh`.

There will be some prompts related to RSA keys, accept the defaults.

This will print output to the screen to inform you of the progress. Check the output for errors and address any that you see - this might involve changes to the scripts being used to accommodate new issues but hopefully the errors are already known so the error message should indicate how to fix it.

## Work flow

Once bootstrapped, software is installed and configuration changes are made. Please check the code for details.

The config changes create a cron job that's scheduled to run ansible at regular intervals. This allows for config to be modified and confirmed by the script.

When the cron job runs it will...
1. Update the ansible repo (`git pull`) within the ansible user's home directory.
1. Execute the updated ansible task.

Changes to this repo should (according to the planned design) allow for ongoing management of laptops setup in this way. A change to the repo will be picked up by the running cron job and then that change can be implemented on the laptop.
