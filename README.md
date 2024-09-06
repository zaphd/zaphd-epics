# ZaP-HD EPICS Repository

New repository for EPICS installation to be used for ZaP-HD

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

