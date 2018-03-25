#include "Clock.h"
#include "Processor.h"
#include "OperatingSystem.h"
//#include "ComputerSystem.h"

int tics=0;

void Clock_Update() {
	
	tics++;
	
	if(Clock_GetTime()  % INTERVALBETWEENINTERRUPS == 0 && Clock_GetTime()  != 0){
		OperatingSystem_InterruptLogic(CLOCKINT_BIT);
	}
    // ComputerSystem_DebugMessage(97,CLOCK,tics);
}


int Clock_GetTime() {
	return tics;
}
