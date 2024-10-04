# ZaP-HD EPICS Repository

New repository for EPICS installation to be used for ZaP-HD

## Docker

Given the complexity of installing EPICS, I have determined it is easier to run it in a Docker container. To do so, first start by installing docker. The best way to do this as my following the instructions on the Docker website:

[Install Docker](https://docs.docker.com/engine/install/)

In the home directory of this repo, type this to build the epics image:
`sudo docker buildx build -f 'Dockerfile' -t 'epics' .`

You can create a volume for the autosave files with:
`docker volume create autosave`

Then, to run a test version of the epics image with this volume:
`sudo docker run --network=host -v autosave:/var/autosavefiles -it --rm epics`

## Deploying Docker Container

To make a container named "zap-ioc" that runs in the background:
'sudo docker run -d --name zap-ioc --network=host -v autosave:/var/autosavefiles -it --rm epics'

This will make a docker container and automatically start the zap-ioc. If you need to attach to the container, 'sudo docker container attach zap-ioc' to detach use Ctrl-p + Ctrl-q. 

To stop the zap-ioc: 'docker stop zap-ioc' from outside the containier



## Installing EPICS

Here are the dependencies for an Ubuntu install (different for Fedora):
```
zei@pop-os:~$ sudo apt install libreadline-dev
zei@pop-os:~$ sudo apt install libnet1-dev
zei@pop-os:~$ sudo apt install libpcap-dev
zei@pop-os:~$ sudo apt install libpcre3-dev
zei@pop-os:~$ sudo apt install re2c
zei@pop-os:~$ sudo apt install make
zei@pop-os:~$ sudo apt install gcc
zei@pop-os:~$ sudo apt install g++
zei@pop-os:~$ sudo apt install libtirpc-dev
```

For fedora:
```
zei@pop-os:~$ sudo dnf install re2c
zei@pop-os:~$ sudo dnf install perl
zei@pop-os:~$ sudo dnf install rpcgen
zei@pop-os:~$ sudo dnf install grpc
zei@pop-os:~$ sudo dnf install libntirpc-devel
zei@pop-os:~$ sudo dnf install grpc-devel

```

Here is how you install epics base:
```
zei@pop-os:/usr/local$ sudo git clone --recurse-submodules https://github.com/epics-base/epics-base.git epics
zei@pop-os:/usr/local$ cd epics
zei@pop-os:/usr/local/epics$ sudo make
```

Then, you'll have to add all the support modules:
```
zei@pop-os:/usr/local/epics$ sudo mkdir support
zei@pop-os:/usr/local/epics$ cd support
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/ISISComputingGroup/EPICS-seq.git seq
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/epics-modules/calc calc
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/epics-modules/asyn asyn
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/paulscherrerinstitute/StreamDevice.git stream
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/epics-modules/modbus.git modbus
zei@pop-os:/usr/local/epics/support$ sudo git clone https://github.com/epics-modules/autosave autosave
```

