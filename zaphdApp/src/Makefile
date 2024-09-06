TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# xxxRecord.h will be created from xxxRecord.dbd
#DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
#DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += zaphdSupport

# Compile and add the code to the support library
zaphdSupport_SRCS += dbSubVacuumEmailAlert.c


# Link locally-provided code into the support library,
# rather than directly into the IOC application.
# This is required for Windows DLL builds.
zaphdSupport_SRCS += initTrace.c

zaphdSupport_LIBS += $(EPICS_BASE_IOC_LIBS)


# Build the IOC application
PROD_IOC = zaphd

# zaphd.dbd will be created and installed
DBD += zaphd.dbd

# zaphd.dbd will include these files:
zaphd_DBD += base.dbd
zaphd_DBD += asyn.dbd
zaphd_DBD += calcSupport.dbd
zaphd_DBD += modbusSupport.dbd
zaphd_DBD += devGpib.dbd
zaphd_DBD += drvVxi11.dbd
zaphd_DBD += devAsynOctet.dbd
zaphd_DBD += devAsynUInt64Digital.dbd
zaphd_DBD += devAsynInt32.dbd
zaphd_DBD += devEpics.dbd
zaphd_DBD += devAsynInt32Array.dbd
zaphd_DBD += devAsynRecord.dbd
zaphd_DBD += drvAsynSerialPort.dbd
zaphd_DBD += drvAsynIPPort.dbd
zaphd_DBD += stream.dbd
zaphd_DBD += asSupport.dbd
zaphd_DBD += initTrace.dbd
vacuum_DBD += dbSubEmailAlert.dbd

# zaphd_registerRecordDeviceDriver.cpp derives from zaphd.dbd
zaphd_SRCS += zaphd_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
zaphd_SRCS_DEFAULT += zaphdMain.cpp
zaphd_SRCS_vxWorks += -nil-

# Link in the code from our support library
zaphd_LIBS += zaphdSupport
zaphd_LIBS += asyn calc modbus stream autosave

#Documentation
DOCS += documentation.md

# Scripts
SCRIPTS += hvvVacuumEmailAlert.py

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)

    # Libraries to do what??
    zaphdSupport_LIBS += seq pv
    zaphd_LIBS += seq pv

    # This state machine for the control program
    sncZaPHD_SNCFLAGS += +r
    zaphd_DBD += sncZaPHD.dbd
    zaphdSupport_SRCS += sncZaPHD.stt

endif

# Finally link IOC to the EPICS Base libraries
zaphd_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

