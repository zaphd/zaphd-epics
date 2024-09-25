#include <stdio.h>
#include <dbDefs.h>
#include <registryFunction.h>
#include <subRecord.h>
#include <aSubRecord.h>
#include <epicsExport.h>
#include <stdlib.h>

/******************************************************************************
 * Function: zaphdMDSplusEvent
 * Inputs: *precord
 * Returns: long
 * Description: Sets an mdsplus event. One of two possible events.
 ******************************************************************************/

static long zaphdVacuumEmailAlert(subRecord *precord)
{

  int select;
  int ret = -1;

  /* Getting input a, or selection enumeration */
  select = precord->a;

  /* 
   * If select is 1, it will sent out a shot triggered
   * mdsplus event. If select is 2, it will sent out a
   * run shot maker event (python script). If select is 0
   * it will simply exit
   */
  if (select == 1) {

    printf("High Vacuum Valve Closed, executing python script\n");
    ret = system("/home/zaphd/zaphd-epics/bin/linux-arm/hvvEmailAlert.py");

    if (ret != 0) {
    printf("Error happened while trying to call hvvEmailAlert.py. Returned %d\n", ret);
    }

  }

  return 0;

}

epicsRegisterFunction(zaphdVacuumEmailAlert);
