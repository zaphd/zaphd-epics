TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Install databases, templates & substitutions like this
DB += read16ControlRelaysControl.substitutions
DB += read64OutputsControl.substitutions
DB += read64InputsControl.substitutions
DB += forceCoilsAliasControl.substitutions
DB += dlCalcOutputsControl.db
DB += userControlControl.db
DB += analogReadWriteControl.db
DB += turnOnHVPSControl.db
DB += iocHeartbeatControl.db
DB += triggerExperiment.db
DB += plcHoldingRegisterReadControl.substitutions
DB += buttonPressesVacuum.db
DB += dlCalcOutputsVacuum.db
DB += pressureReadVacuum.db
DB += IocHeartbeatVacuum.db
DB += dbSubEmailAlertVacuum.db
DB += read16controlrelaysVacuum.substitutions
DB += read64outputsVacuum.substitutions
DB += ForceCoilsAliasVacuum.substitutions
DB += plcHoldingRegisterReadVacuum.substitutions



# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_TEMPLATE = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

