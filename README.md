# The Spark dev environment

## Overview
This project serves as a good starting point to get ramped up and start learning spark.
The project leverages devcontainers which have spark and all toolings built in so that you can get kickstarted easily.

More details on that [here](.devcontainer/README.md)

## How to get started ?

### Microsoft Linux Devbox

Follow [this](https://eng.ms/docs/cloud-ai-platform/azure-edge-platform-aep/aep-engineering-systems/productivity-and-experiences/developer-productivity/wave-for-windows-azure/linux/install) to get a fresh, powerful Dev machine in seconds. At the time of writing, this repo's toolling is aligned to work on Ubuntu hosts.

Once you're ssh-ed in via Visual Studio Code, the only pre-req is Docker:

```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm -f get-docker.sh
sudo chmod 666 /var/run/docker.sock

docker container ls
```

### Clone Repository

Git clone this repo in the the linux devbox and get started by launching the devcontainer.

### Launch devcontainer

- Login
    `az login --use-device`
    `az acr login --name sparkdevcontainer`
- Open the devcontainer using `ctrl+shift+p` and then selecting `Dev Containers: Rebuild Without Cache and Reopen in Container`
