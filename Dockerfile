FROM ubuntu:latest

## Updating repository

RUN apt-get update && apt-get install -y libreadline-dev libnet1-dev libpcap-dev libpcre3-dev re2c make gcc g++ libtirpc-dev git


## Installing EPICS

WORKDIR /usr/local
RUN git clone --recurse-submodules https://github.com/epics-base/epics-base.git epics
WORKDIR /usr/local/epics
RUN make


## Installing EPICS support modules

WORKDIR /usr/local/epics/support
RUN git clone https://github.com/ISISComputingGroup/EPICS-seq.git seq
WORKDIR seq
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/-include $(TOP)\/..\/..\/..\/ISIS_CONFIG/#/g' configure/RELEASE
RUN sed -i -e 's/include $(TOP)\/..\/..\/..\/ISIS_CONFIG/#/g' configure/RELEASE
RUN make
WORKDIR /usr/local/epics/support
RUN git clone https://github.com/epics-modules/calc calc
WORKDIR /usr/local/epics/support/calc
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/SUPPORT=.*/SUPPORT=\/usr\/local\/epics\/support/g' configure/RELEASE
RUN sed -i -e 's/SSCAN=.*/#SSCAN=/g' configure/RELEASE
RUN make
WORKDIR /usr/local/epics/support
RUN git clone https://github.com/epics-modules/asyn asyn
WORKDIR /usr/local/epics/support/asyn
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/SUPPORT=.*/SUPPORT=\/usr\/local\/epics\/support/g' configure/RELEASE
RUN sed -i -e 's/# TIRPC=YES/TIRPC=YES/g' configure/CONFIG_SITE
RUN make
WORKDIR /usr/local/epics/support
RUN git clone https://github.com/paulscherrerinstitute/StreamDevice.git stream
WORKDIR /usr/local/epics/support/stream
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/SUPPORT=.*/SUPPORT=\/usr\/local\/epics\/support/g' configure/RELEASE
RUN sed -i -e 's/PCRE=/#PCRE=/g' configure/RELEASE
RUN sed -i -e 's/ASYN=.*/ASYN=$\(SUPPORT\)\/asyn/g' configure/RELEASE
RUN sed -i -e 's/CALC=.*/#CALC=$\(SUPPORT\)\/calc/g' configure/RELEASE
RUN make
WORKDIR /usr/local/epics/support
RUN git clone https://github.com/epics-modules/modbus.git modbus
WORKDIR /usr/local/epics/support/modbus
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/SUPPORT=.*/SUPPORT=\/usr\/local\/epics\/support/g' configure/RELEASE
RUN sed -i -e 's/ASYN=.*/ASYN=$\(SUPPORT\)\/asyn/g' configure/RELEASE
RUN make
WORKDIR /usr/local/epics/support
RUN git clone https://github.com/epics-modules/autosave autosave
WORKDIR /usr/local/epics/support/autosave
RUN sed -i -e 's/EPICS_BASE=.*/EPICS_BASE=\/usr\/local\/epics/g' configure/RELEASE
RUN sed -i -e 's/SUPPORT=.*/SUPPORT=\/usr\/local\/epics\/support/g' configure/RELEASE
RUN make


## Copying and building EPICS app

WORKDIR /home/zaphd/zaphd-epics
COPY . .
RUN make

#ENTRYPOINT ["/home/zaphd/zaphd-epics/iocBoot/ioczaphd/st.cmd"]
