#!../../bin/linux-x86_64/zaphd

## You may have to change zaphd to something else
## everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/zaphd.dbd"
zaphd_registerRecordDeviceDriver pdbbase




########################### ZaP-HD Control System ########################################

drvAsynIPPortConfigure("ControlPLC","10.10.10.110:502",0,0,1)
modbusInterposeConfig("ControlPLC", 0, 1000, 0)

drvModbusAsynConfigure("Read_Vmem1", "ControlPLC",0,3,02020,8,2,100,"DirectLOGIC")
drvModbusAsynConfigure("Write_Vmem1", "ControlPLC",0,6,1048,8,2,100,"DirectLOGIC")
drvModbusAsynConfigure("Out_Word", "ControlPLC", 0, 15, 3200, 32, 0, 100, "DirectLOGIC")
drvModbusAsynConfigure("In_Coil1", "ControlPLC", 0, 1, 2048, 64, 0, 100, "DirectLOGIC")
drvModbusAsynConfigure("In_Coil2", "ControlPLC", 0, 1, 3136, 32, 0, 100, "DirectLOGIC")
drvModbusAsynConfigure("In_Coil3", "ControlPLC", 0, 2, 2048, 64, 0, 100, "DirectLOGIC")

#Load Templates 
dbLoadTemplate("db/forceCoilsAliasControl.substitutions")
dbLoadTemplate("db/read64OutputsControl.substitutions")
dbLoadTemplate("db/read16ControlRelaysControl.substitutions")
dbLoadTemplate("db/read64InputsControl.substitutions")
dbLoadTemplate("db/plcHoldingRegisterReadControl.substitutions")


# Load Records
dbLoadRecords("db/dlCalcOutputsControl.db")
dbLoadRecords("db/analogReadWriteControl.db", "SubSys=ZaPHD:ControlPLC")
dbLoadRecords("db/userControlControl.db", "SubSys=ZaPHD:ControlPLC")
dbLoadRecords("db/turnOnHVPSControl.db", "SubSys=ZaPHD:ControlPLC")
dbLoadRecords("db/triggerExperiment.db", "SubSys=ZaPHD:ControlPLC")
dbLoadRecords("db/iocHeartbeatControl.db", "SubSys=ZaPHD:ControlPLC")





########################### ZaP-HD Vacuum System ###########################################

drvAsynIPPortConfigure("VacuumPLC","10.10.10.116:502",0,0,1)
modbusInterposeConfig("VacuumPLC", 0, 1000, 0)

drvModbusAsynConfigure("Press_Vmem1", "VacuumPLC",0,3,03310,10,2,100,"DirectLOGIC")
drvModbusAsynConfigure("Press_Vmem2", "VacuumPLC",0,3,01400,12,2,100,"DirectLOGIC")
drvModbusAsynConfigure("Press_Vmem4", "VacuumPLC",0,3,02040,2,2,100,"DirectLOGIC")
drvModbusAsynConfigure("Vac_Out_Word", "VacuumPLC", 0, 15, 3200, 32, 0, 100, "DirectLOGIC")
drvModbusAsynConfigure("Vac_In_Coil1", "VacuumPLC", 0, 1, 2048, 64, 0, 100, "DirectLOGIC")
drvModbusAsynConfigure("Vac_In_Coil2", "VacuumPLC", 0, 1, 3136, 16, 0, 100, "DirectLOGIC")

#Load Templates 
dbLoadTemplate("db/ForceCoilsAliasVacuum.substitutions")
dbLoadTemplate("db/read64outputsVacuum.substitutions")
dbLoadTemplate("db/read16controlrelaysVacuum.substitutions")
dbLoadTemplate("db/plcHoldingRegisterReadVacuum.substitutions")

# Load records
dbLoadRecords("db/dlCalcOutputsVacuum.db")
dbLoadRecords("db/pressureReadVacuum.db", "SubSys=ZaPHD:VacuumPLC")
dbLoadRecords("db/buttonPressesVacuum.db", "SubSys=ZaPHD:VacuumPLC")
dbLoadRecords("db/dbSubEmailAlertVacuum.db", "SubSys=ZaPHD:VacuumPLC")
dbLoadRecords("db/IocHeartbeatVacuum.db", "SubSys=ZaPHD:VacuumPLC")





# Files restored after record initilization
set_requestfile_path("$(TOP)/iocBoot/$(IOC)", "autosaverequests")
set_pass1_restoreFile(zaphd_autosave.sav)

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
seq sncZaPHD

# save positions every 10 minutes
set_savefile_path("/var/autosavefiles")
create_monitor_set("zaphd_autosave.req", 600)
