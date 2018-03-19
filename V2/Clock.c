#include "Clock.h"
#include "Processor.h"
//#include "ComputerSystem.h"

int tics=0;

void Clock_Update() {

	tics++;
	
	if(ticks % INTERVALBETWEENINTERRUPTS == 0){
		Processor_RaiseInterrupt(CLOCKINT_BIT);
	}	
    // ComputerSystem_DebugMessage(97,CLOCK,tics);
}


int Clock_GetTime() {

	return tics;
}
