# Configure docker container with ansible

## Scenario

Often you want to make some changes on a virtual machine or remote machine from a pipeline script; a very useful tool to do something like this is `Ansible`

Assuming that you have a main script that prepares a docker container to do the workload, how do you configure ansible in the docker container?

Note: ansible needs SSH access to the target machine. You can find out how to configure SSH access in the docker container at [https://github.com/Frunza/configure-docker-container-with-ssh-access](https://github.com/Frunza/configure-docker-container-with-ssh-access)

## Prerequisites

A Linux or MacOS machine for local development. If you are running Windows, you first need to set up the *Windows Subsystem for Linux (WSL)* environment.

You need `docker cli` and `docker-compose` on your machine for testing purposes, and/or on the machines that run your pipeline.
You can check both of these by running the following commands:
```sh
docker --version
docker-compose --version
```

Make sure that you already have a docker container with SSH access.

## Implementation

When building the docker image, install ansible; it is a good practice to install a specific version declared in code; you can do that as shown below:
```sh
RUN apk --no-cache add ansible=7.5.0-r0
```

In the docker-compose file you must provide an environment variable with the location of the ansible config file; for example:
```sh
ANSIBLE_CONFIG=/app/ansible/ansible.cfg
```

## Usage

Navigate to the root of the git repository and run the following commands:
```sh
sh run.sh 
```

The following happens:
1) the first command builds the docker image, passing the private key value as an argument and tagging it as *sshaccess*
2) the docker image sets up the SSH access by copying the value of the `SSH_PRIVATE_KEY` argument to the standard location for SSH keys
3) the second command uses docker-compose to create and run the container. The container runs the `master.yml` ansible playbook, which only echoes some text.

Note: if you want to test this, consider changing the target machine IP with your own in this file: `ansible/production.ini`
