#include "OperatingSystem.h"
#include "OperatingSystemBase.h"
#include "MMU.h"
#include "Processor.h"
#include "Buses.h"
#include "Heap.h"
#include <string.h>
#include <ctype.h>
#include <stdlib.h>
#include <time.h>

// Functions prototypes
void OperatingSystem_PrepareDaemons();
void OperatingSystem_PCBInitialization(int, int, int, int, int);
void OperatingSystem_MoveToTheREADYState(int);
void OperatingSystem_Dispatch(int);
void OperatingSystem_RestoreContext(int);
void OperatingSystem_SaveContext(int);
void OperatingSystem_TerminateProcess();
int OperatingSystem_LongTermScheduler();
void OperatingSystem_PreemptRunningProcess();
int OperatingSystem_CreateProcess(int);
int OperatingSystem_ObtainMainMemory(int, int);
int OperatingSystem_ShortTermScheduler();
int OperatingSystem_ExtractFromReadyToRun(int queue);
void OperatingSystem_HandleException();
void OperatingSystem_HandleSystemCall();
//metodo para mirar el tamaño de la particion mas grande disponible
int mainMemoryPartitionSizeAvailable();
// The process table
PCB processTable[PROCESSTABLEMAXSIZE];

// Address base for OS code in this version
int OS_address_base = PROCESSTABLEMAXSIZE * MAINMEMORYSECTIONSIZE;

// Identifier of the current executing process
int executingProcessID=NOPROCESS;

// Identifier of the System Idle Process
int sipID;

// Begin indes for daemons in programList
int baseDaemonsInProgramList; 

// Array that contains the identifiers of the READY processes
//Comentados para el ejercicio 11 de la V1
//int readyToRunQueue[PROCESSTABLEMAXSIZE];
//int numberOfReadyToRunProcesses=0;

// Variable containing the number of not terminated user processes
int numberOfNotTerminatedUserProcesses=0;



//Ejercicio 10 V1
char * statesNames [5]={"NEW","READY","EXECUTING","BLOCKED","EXIT"};

//Ejercicio 11 V!: Modificaciones de la politicia de planificacion a corto plazo
int readyToRunQueue [NUMBEROFQUEUES][PROCESSTABLEMAXSIZE];
int numberOfReadyToRunProcesses [NUMBEROFQUEUES] = {0,0};//posicion 0, numero procesos usuario, posicion 1 numero procesos daemons

//numero de interrupciones de reloj
int numberOfClockInterrupts = 0;

// In OperatingSystem.c Exercise 5-b of V2
// Heap with blocked porcesses sort by when to wakeup
int sleepingProcessesQueue[PROCESSTABLEMAXSIZE];
int numberOfSleepingProcesses=0;


//Variable donde guardamos el numero de particiones realizadas
int numberOfMemoryPartitions=0;
int numberOfFreePartitions=0;


// Initial set of tasks of the OS
void OperatingSystem_Initialize(int daemonsIndex) {
	
	int i, selectedProcess, procesosCreados;
	FILE *programFile; // For load Operating System Code

	// Obtain the memory requirements of the program
	int processSize=OperatingSystem_ObtainProgramSize(&programFile, "OperatingSystemCode");

	// Load Operating System Code
	OperatingSystem_LoadProgram(programFile, OS_address_base, processSize);
	
	// Process table initialization (all entries are free)
	for (i=0; i<PROCESSTABLEMAXSIZE;i++)
		processTable[i].busy=0;
	
	// Initialization of the interrupt vector table of the processor
	Processor_InitializeInterruptVectorTable(OS_address_base+1);
	
	//V4 ejercicio 5
	//añadimos esta asignacion a la variable para guardar el numero de particiones realizadas
	numberOfMemoryPartitions = OperatingSystem_InitializePartitionTable();
	numberOfFreePartitions = numberOfMemoryPartitions;
	
	// Create all system daemon processes
	
	OperatingSystem_PrepareDaemons(daemonsIndex);
	
	//V3 ejercicio 0-c
	ComputerSystem_FillInArrivalTimeQueue();
	//V3 ejercicio 0-d
	OperatingSystem_PrintStatus();
	
	
	// Create all user processes from the information given in the command line
	procesosCreados = OperatingSystem_LongTermScheduler();
	if(procesosCreados <= 1 && OperatingSystem_IsThereANewProgram() == -1){		
		OperatingSystem_ReadyToShutdown();
	}else{
		OperatingSystem_PrintStatus();
	}
	
	if(strcmp(programList[processTable[sipID].programListIndex]->executableName,"SystemIdleProcess")) {
		// Show message "ERROR: Missing SIP program!\n"
		OperatingSystem_ShowTime(SHUTDOWN);
		ComputerSystem_DebugMessage(21,SHUTDOWN);
		exit(1);		
	}

	// At least, one user process has been created
	// Select the first process that is going to use the processor
	selectedProcess=OperatingSystem_ShortTermScheduler();

	// Assign the processor to the selected process
	OperatingSystem_Dispatch(selectedProcess);

	// Initial operation for Operating System
	Processor_SetPC(OS_address_base);
}

// Daemon processes are system processes, that is, they work together with the OS.
// The System Idle Process uses the CPU whenever a user process is able to use it
void OperatingSystem_PrepareDaemons(int programListDaemonsBase) {
  
	// Include a entry for SystemIdleProcess at 0 position
	programList[0]=(PROGRAMS_DATA *) malloc(sizeof(PROGRAMS_DATA));

	programList[0]->executableName="SystemIdleProcess";
	programList[0]->arrivalTime=0;
	programList[0]->type=DAEMONPROGRAM; // daemon program
	sipID=INITIALPID%PROCESSTABLEMAXSIZE; // first PID for sipID

	// Prepare aditionals daemons here
	// index for aditionals daemons program in programList
	baseDaemonsInProgramList=programListDaemonsBase;

}


// The LTS is responsible of the admission of new processes in the system.
// Initially, it creates a process from each program specified in the 
// 			command lineand daemons programs
int OperatingSystem_LongTermScheduler() {
	int PID,
		numberOfSuccessfullyCreatedProcesses=0;
		
	//hacemos la comprovación del numero de procesos con isThereANewprogram
	//V3 ejercicio 2	
	while(OperatingSystem_IsThereANewProgram() == 1){
		int pidAux = Heap_poll(arrivalTimeQueue,QUEUE_ARRIVAL,&numberOfProgramsInArrivalTimeQueue);
		
		PID = OperatingSystem_CreateProcess(pidAux);
		if(PID < 0){
			PROGRAMS_DATA *progamaFallido=programList[pidAux];
			if(PID == NOFREEENTRY){	
				OperatingSystem_ShowTime(ERROR);
				ComputerSystem_DebugMessage(103,ERROR,progamaFallido->executableName);
			}
			if(PID == PROGRAMDOESNOTEXIST){
				OperatingSystem_ShowTime(ERROR);
				ComputerSystem_DebugMessage(104,ERROR,progamaFallido->executableName,"it does not exist");
			}
			if(PID == PROGRAMNOTVALID){
				OperatingSystem_ShowTime(ERROR);
				ComputerSystem_DebugMessage(104,ERROR,progamaFallido->executableName,"invalid priority or size");
			}
			if(PID == TOOBIGPROCESS){
				OperatingSystem_ShowTime(ERROR);
				ComputerSystem_DebugMessage(105,ERROR,progamaFallido->executableName);
			}
			if(PID == MEMORYFULL){
				OperatingSystem_ShowTime(ERROR);
				ComputerSystem_DebugMessage(144,ERROR,progamaFallido->executableName);
			}
		}else{
			numberOfSuccessfullyCreatedProcesses++;
			if (programList[pidAux]->type==USERPROGRAM)
				numberOfNotTerminatedUserProcesses++;
			// Move process to the ready state			
			OperatingSystem_MoveToTheREADYState(PID);			
		}
	}
	// Return the number of succesfully created processes
	return numberOfSuccessfullyCreatedProcesses;
}


// This function creates a process from an executable program
int OperatingSystem_CreateProcess(int indexOfExecutableProgram) {
  
	int PID;
	int processSize;
	int loadingPhysicalAddress;
	int priority;
	FILE *programFile;
	PROGRAMS_DATA *executableProgram=programList[indexOfExecutableProgram];

	// Obtain a process ID
	PID=OperatingSystem_ObtainAnEntryInTheProcessTable();
	
	if(PID == NOFREEENTRY){
		return NOFREEENTRY;
	}	
	
	// Obtain the memory requirements of the program
	processSize=OperatingSystem_ObtainProgramSize(&programFile, executableProgram->executableName);	
	
	if(processSize == PROGRAMDOESNOTEXIST){
		return PROGRAMDOESNOTEXIST;
	}
	if(processSize == PROGRAMNOTVALID){
		return PROGRAMNOTVALID;
	}

	// Obtain the priority for the process
	priority=OperatingSystem_ObtainPriority(programFile);
	if(priority == PROGRAMNOTVALID){
		return PROGRAMNOTVALID;
	}
	// Obtain enough memory space
	
	OperatingSystem_ShowTime(SYSMEM);
	ComputerSystem_DebugMessage(142,SYSMEM,PID,executableProgram->executableName,processSize);
	
 	loadingPhysicalAddress=OperatingSystem_ObtainMainMemory(processSize, PID);
	if(loadingPhysicalAddress == TOOBIGPROCESS){
		return TOOBIGPROCESS;
	}
	
	if(loadingPhysicalAddress == MEMORYFULL){
		return MEMORYFULL;
	}
	int exitoTam = SUCCESS;
	// Load program in the allocated memory
	exitoTam =  OperatingSystem_LoadProgram(programFile, partitionsTable[loadingPhysicalAddress].initAddress, processSize);
	if(exitoTam != SUCCESS){
		return TOOBIGPROCESS;
	}
	
	///Cosas para asignar memoria
	//carga de programa correcta
	//vamos a asignar la memoria al proceso/programa
	OperatingSystem_ShowTime(SYSMEM);
	ComputerSystem_DebugMessage(143,SYSMEM,loadingPhysicalAddress,partitionsTable[loadingPhysicalAddress].initAddress,partitionsTable[loadingPhysicalAddress].size,PID,executableProgram->executableName);
	numberOfFreePartitions--;//vamos a tener un particion menos disponible
	partitionsTable[loadingPhysicalAddress].PID = PID;
	partitionsTable[loadingPhysicalAddress].occupied = 1;
	
	
	
	// PCB initialization
	OperatingSystem_PCBInitialization(PID, loadingPhysicalAddress, processSize, priority, indexOfExecutableProgram);
	// Sohw message "New Process [] moving to the [NEW] state"
	OperatingSystem_ShowTime(SYSPROC);
	ComputerSystem_DebugMessage(111,SYSPROC,PID,statesNames[0]);
	// Show message "Process [PID] created from program [executableName]\n"
	OperatingSystem_ShowTime(INIT);
	ComputerSystem_DebugMessage(22,INIT,PID,executableProgram->executableName);
	
	
	return PID;
}

int mainMemoryPartitionSizeAvailable(){
	int i;
	int maxSize = 0;
	for(i = 0; i < numberOfMemoryPartitions; i++){
		if(partitionsTable[i].size > maxSize && partitionsTable[i].occupied == 0){
			maxSize = partitionsTable[i].size;
		}
	}
	return maxSize;
}


// Main memory is assigned in chunks. All chunks are the same size. A process
// always obtains the chunk whose position in memory is equal to the processor identifier
int OperatingSystem_ObtainMainMemory(int processSize, int PID) {
	
	//definimos el indice de la particion adecuada
	int PartitionIndex = MEMORYFULL;
	//mejor ajuste
	int mejorAjuste;
	
	//añadimos flag de control para que el caso primero sea siempre valido	
	int flag =0;
	/*
	if (processSize>MAINMEMORYSECTIONSIZE)
		return TOOBIGPROCESS;
	*/
	
	if(processSize > mainMemoryPartitionSizeAvailable()){
		return TOOBIGPROCESS;		
	}
	
	
	if(numberOfFreePartitions == 0){
		return MEMORYFULL;
	}
	int i;
	for(i = 0; i< numberOfMemoryPartitions;i++){
		//primero vamos a mirar que el tamaño del proceso sea menor o igual que el de la particion
		if(processSize <= partitionsTable[i].size && partitionsTable[i].occupied == 0){
			//Sacamos la diferencia para el ajuste (tiene que ser positiva o 0)
			int ajuste = partitionsTable[i].size - processSize;
			//Porblema aqui porque vamos a empezar con 0
			if(ajuste < mejorAjuste || flag == 0){
				mejorAjuste = ajuste;
				PartitionIndex = i;
				flag = 1;
			}
			if(ajuste == mejorAjuste){
				if(partitionsTable[i].initAddress < partitionsTable[PartitionIndex].initAddress){
					//En caso de que tengan el mismo ajuste, seleccionamos la que tiene una direccion inicial menor
					PartitionIndex = i;
				}
				
			}
			
		}
	}
 	return PartitionIndex;
}




// Assign initial values to all fields inside the PCB
void OperatingSystem_PCBInitialization(int PID, int initialPhysicalAddress, int processSize, int priority, int processPLIndex) {

	processTable[PID].busy=1;
	processTable[PID].initialPhysicalAddress=initialPhysicalAddress;
	processTable[PID].processSize=processSize;
	processTable[PID].state=NEW;
	processTable[PID].priority=priority;
	processTable[PID].programListIndex=processPLIndex;
	
	// Daemons run in protected mode and MMU use real address
	if (programList[processPLIndex]->type == DAEMONPROGRAM) {
		processTable[PID].copyOfPCRegister=initialPhysicalAddress;
		processTable[PID].copyOfPSWRegister= ((unsigned int) 1) << EXECUTION_MODE_BIT;
		processTable[PID].queueID=DAEMONSQUEUE;
	} 
	else {
		processTable[PID].copyOfPCRegister=0;
		processTable[PID].copyOfPSWRegister=0;
		processTable[PID].copyOfAcumulator = 0;//no importa mucho
		processTable[PID].queueID=USERPROCESSQUEUE;
	}

}

// Move a process to the READY state: it will be inserted, depending on its priority, in
// a queue of identifiers of READY processes
void OperatingSystem_MoveToTheREADYState(int PID) {
	
	if (Heap_add(PID, readyToRunQueue[processTable[PID].queueID],QUEUE_PRIORITY ,&numberOfReadyToRunProcesses[processTable[PID].queueID] ,PROCESSTABLEMAXSIZE)>=0) {		
		OperatingSystem_ShowTime(SYSPROC);
		ComputerSystem_DebugMessage(110,SYSPROC,PID,statesNames[processTable[PID].state],statesNames[1]);
		processTable[PID].state=READY;
	}	
	//ejercicio 9 V1
	//OperatingSystem_PrintReadyToRunQueue();	
}


// The STS is responsible of deciding which process to execute when specific events occur.
// It uses processes priorities to make the decission. Given that the READY queue is ordered
// depending on processes priority, the STS just selects the process in front of the READY queue
int OperatingSystem_ShortTermScheduler() {
	
	int selectedProcess;
	
	selectedProcess=OperatingSystem_ExtractFromReadyToRun(USERPROCESSQUEUE);
	if(selectedProcess == NOPROCESS){
		selectedProcess=OperatingSystem_ExtractFromReadyToRun(DAEMONSQUEUE);
	}
	return selectedProcess;
}


// Return PID of more priority process in the READY queue
int OperatingSystem_ExtractFromReadyToRun(int queue) {
	
	int selectedProcess=NOPROCESS;
	//miramos si tenemos algun proceso en la pila de procesos de usuario
	selectedProcess=Heap_poll(readyToRunQueue[queue],QUEUE_PRIORITY ,&numberOfReadyToRunProcesses[queue]);
	// Return most priority process or NOPROCESS if empty queue
	return selectedProcess; 
}


// Function that assigns the processor to a process
void OperatingSystem_Dispatch(int PID) {
	// The process identified by PID becomes the current executing process
	executingProcessID=PID;	
	OperatingSystem_ShowTime(SYSPROC);
	ComputerSystem_DebugMessage(110,SYSPROC,executingProcessID,statesNames[processTable[executingProcessID].state],statesNames[2]);
	// Change the process' state
	processTable[PID].state=EXECUTING;
	// Modify hardware registers with appropriate values for the process identified by PID
	OperatingSystem_RestoreContext(PID);
	
}


// Modify hardware registers with appropriate values for the process identified by PID
void OperatingSystem_RestoreContext(int PID) {
  
	// New values for the CPU registers are obtained from the PCB
	Processor_CopyInSystemStack(MAINMEMORYSIZE-1,processTable[PID].copyOfPCRegister);
	Processor_CopyInSystemStack(MAINMEMORYSIZE-2,processTable[PID].copyOfPSWRegister);
	//resatauramos el acumulador
	Processor_SetAccumulator(processTable[PID].copyOfAcumulator);
	
	// Same thing for the MMU registers
	MMU_SetBase(processTable[PID].initialPhysicalAddress);
	MMU_SetLimit(processTable[PID].processSize);
}


// Function invoked when the executing process leaves the CPU 
void OperatingSystem_PreemptRunningProcess() {

	// Save in the process' PCB essential values stored in hardware registers and the system stack
	OperatingSystem_SaveContext(executingProcessID);
	// Change the process' state
	OperatingSystem_MoveToTheREADYState(executingProcessID);
	// The processor is not assigned until the OS selects another process
	executingProcessID=NOPROCESS;
}

// Save in the process' PCB essential values stored in hardware registers and the system stack
void OperatingSystem_SaveContext(int PID) {
	
	// Load PC saved for interrupt manager
	processTable[PID].copyOfPCRegister=Processor_CopyFromSystemStack(MAINMEMORYSIZE-1);
	
	// Load PSW saved for interrupt manager
	processTable[PID].copyOfPSWRegister=Processor_CopyFromSystemStack(MAINMEMORYSIZE-2);
	
	//Guardamos el valor del acumulador
	processTable[PID].copyOfAcumulator = Processor_GetAccumulator();
	
}

// Exception management routine
void OperatingSystem_HandleException() {
  
	// Show message "Process [executingProcessID] has generated an exception and is terminating\n"
	OperatingSystem_ShowTime(INTERRUPT);
	//ComputerSystem_DebugMessage(23,SYSPROC,executingProcessID);
	PROGRAMS_DATA *executableProgram=programList[executingProcessID];
	//registerB_CPU
	
	switch (Processor_GetRegisterB()){
		case DIVISIONBYZERO: 
			ComputerSystem_DebugMessage(140,INTERRUPT,executingProcessID,executableProgram->executableName,"division by zero");
		case INVALIDPROCESSORMODE:
			ComputerSystem_DebugMessage(140,INTERRUPT,executingProcessID,executableProgram->executableName,"invalid processor mode");
		case INVALIDADDRESS:
			ComputerSystem_DebugMessage(140,INTERRUPT,executingProcessID,executableProgram->executableName,"invalid address");
		case INVALIDINSTRUCTION:
			ComputerSystem_DebugMessage(140,INTERRUPT,executingProcessID,executableProgram->executableName,"invalid instruction");
	}
	
	OperatingSystem_TerminateProcess();
	
	//print status despues del manejador de instrucciones
	OperatingSystem_PrintStatus();
}

// All tasks regarding the removal of the process
void OperatingSystem_TerminateProcess() {
	
	int selectedProcess;
  	
	OperatingSystem_ShowTime(SYSPROC);
	ComputerSystem_DebugMessage(110,SYSPROC,executingProcessID,statesNames[processTable[executingProcessID].state],statesNames[4]);
	
	processTable[executingProcessID].state=EXIT;
	
	// One more process that has terminated
	numberOfNotTerminatedUserProcesses--;
	if (numberOfNotTerminatedUserProcesses<=0 && OperatingSystem_IsThereANewProgram() == -1) {
		// Simulation must finish 
		OperatingSystem_ReadyToShutdown();
	}
	
	processTable[executingProcessID].busy = 0;
	// Select the next process to execute (sipID if no more user processes)
	selectedProcess=OperatingSystem_ShortTermScheduler();
	// Assign the processor to that process
	OperatingSystem_Dispatch(selectedProcess);
}

// System call management routine
void OperatingSystem_HandleSystemCall() {
  
	int systemCallID;
	int idAntiguo;
	int idProcesoCandidato;

	// Register A contains the identifier of the issued system call
	systemCallID=Processor_GetRegisterA();
	
	switch (systemCallID) {
		case SYSCALL_PRINTEXECPID:
			// Show message: "Process [executingProcessID] has the processor assigned\n"
			OperatingSystem_ShowTime(SYSPROC);
			ComputerSystem_DebugMessage(24,SYSPROC,executingProcessID);
			break;
		case SYSCALL_END:
			// Show message: "Process [executingProcessID] has requested to terminate\n"
			OperatingSystem_ShowTime(SYSPROC);
			ComputerSystem_DebugMessage(25,SYSPROC,executingProcessID);
			OperatingSystem_TerminateProcess();
			OperatingSystem_PrintStatus();
			break;
		case SYSCALL_YIELD:
			//cambio de proceso
			idAntiguo = executingProcessID;
			idProcesoCandidato = NOPROCESS;
			idProcesoCandidato = Heap_getFirst(readyToRunQueue[processTable[executingProcessID].queueID],numberOfReadyToRunProcesses[processTable[executingProcessID].queueID]);
			if(processTable[idProcesoCandidato].priority == processTable[executingProcessID].priority){
				OperatingSystem_ShowTime(SHORTTERMSCHEDULE);
				ComputerSystem_DebugMessage(118,SHORTTERMSCHEDULE,idAntiguo,idProcesoCandidato);
				//pasamos el proceso candidato al estado EXECUTE
				//readyToRunQueue[tipoPila],QUEUE_PRIORITY ,&numberOfReadyToRunProcesses[tipoPila]
				//OperatingSystem_Dispatch(Heap_poll(readyToRunQueue[processTable[idAntiguo].queueID],QUEUE_PRIORITY,&numberOfReadyToRunProcesses[processTable[idAntiguo].queueID]));
				//OperatingSystem_MoveToTheREADYState(idAntiguo);
				//metodo para sacar el proceso actual del procesador y toda la gestion de cosas
				OperatingSystem_PreemptRunningProcess();
				OperatingSystem_Dispatch(OperatingSystem_ShortTermScheduler());	
				OperatingSystem_PrintStatus();
			}
			break;
		case SYSCALL_SLEEP:
			OperatingSystem_BlockTheActualProcess();
			executingProcessID= OperatingSystem_ShortTermScheduler();
			OperatingSystem_Dispatch(executingProcessID);
			OperatingSystem_PrintStatus();
			break;
			
		default:
			OperatingSystem_ShowTime(INTERRUPT);
			PROGRAMS_DATA *executableProgram=programList[executingProcessID];
			ComputerSystem_DebugMessage(140,INTERRUPT,executingProcessID,executableProgram->executableName,systemCallID);
			OperatingSystem_TerminateProcess();
			OperatingSystem_PrintStatus();
			break;
	}
}

//	Implement interrupt logic calling appropriate interrupt handle
void OperatingSystem_InterruptLogic(int entryPoint){
	switch (entryPoint){
		case SYSCALL_BIT: // SYSCALL_BIT=2
			OperatingSystem_HandleSystemCall();
			break;
		case EXCEPTION_BIT: // EXCEPTION_BIT=6
			OperatingSystem_HandleException();
			break;
		case CLOCKINT_BIT: //COLCKINT_BIT=9 interrupcion de reloj
			OperatingSystem_HandleClockInterrupt();
			break;
	}

}

//Ejercicio 9 V1
void OperatingSystem_PrintReadyToRunQueue(){	
	OperatingSystem_ShowTime(SHORTTERMSCHEDULE);
	ComputerSystem_DebugMessage(112,SHORTTERMSCHEDULE);
	//imprimimos los procesos de usuario
	int i;
	ComputerSystem_DebugMessage(113,SHORTTERMSCHEDULE);
	if(numberOfReadyToRunProcesses[USERPROCESSQUEUE] == 0){
		ComputerSystem_DebugMessage(117,SHORTTERMSCHEDULE);
	}else{		
		for(i = 0; i< numberOfReadyToRunProcesses[USERPROCESSQUEUE];i++){
			PCB procesoUser = processTable[readyToRunQueue[USERPROCESSQUEUE][i]];
			if(i == numberOfReadyToRunProcesses[USERPROCESSQUEUE]-1){
				ComputerSystem_DebugMessage(116,SHORTTERMSCHEDULE,readyToRunQueue[USERPROCESSQUEUE][i],procesoUser.priority);
			}else{
				ComputerSystem_DebugMessage(115,SHORTTERMSCHEDULE,readyToRunQueue[USERPROCESSQUEUE][i],procesoUser.priority);
			}
		}
	}
	ComputerSystem_DebugMessage(114,SHORTTERMSCHEDULE);
	if(numberOfReadyToRunProcesses[DAEMONSQUEUE] == 0){	
		ComputerSystem_DebugMessage(117,SHORTTERMSCHEDULE);
	}else{
		for(i = 0; i < numberOfReadyToRunProcesses[DAEMONSQUEUE];i++){
			PCB procesoDaemon = processTable[readyToRunQueue[DAEMONSQUEUE][i]];
			if(i == numberOfReadyToRunProcesses[DAEMONSQUEUE]-1){
				ComputerSystem_DebugMessage(116,SHORTTERMSCHEDULE,readyToRunQueue[DAEMONSQUEUE][i],procesoDaemon.priority);
			}else{
				ComputerSystem_DebugMessage(115,SHORTTERMSCHEDULE,readyToRunQueue[DAEMONSQUEUE][i],procesoDaemon.priority);
			}
		}
	}
}

// In OperatingSystem.c Exercise 2-b of V2 
void OperatingSystem_HandleClockInterrupt(){
	numberOfClockInterrupts++;
	/*
		int sleepingProcessesQueue[PROCESSTABLEMAXSIZE];
		int numberOfSleepingProcesses=0;
	*/
	OperatingSystem_ShowTime(INTERRUPT);
	ComputerSystem_DebugMessage(120,INTERRUPT,numberOfClockInterrupts);
	int numProcSacados = 0;
	int exit = 0;
	while(exit==0){
		//sacamos el proceso de la cola de dormidos
		int idQueue = Heap_getFirst(sleepingProcessesQueue,numberOfSleepingProcesses);
		if(processTable[idQueue].whenToWakeUp <= numberOfClockInterrupts && idQueue != NOPROCESS){
			idQueue = Heap_poll(sleepingProcessesQueue,QUEUE_WAKEUP, &numberOfSleepingProcesses);
			OperatingSystem_MoveToTheREADYState(idQueue);
			OperatingSystem_PrintStatus();
			numProcSacados++;
		}else{
			//hacemos esto cuando el proceso que s eha sacado no tiene un tiempo menor que el numero
			// de interrupciones de roloj
			exit = 1;
		}
	}
	
	int numCreados = OperatingSystem_LongTermScheduler();
	if(numCreados <= 1 && OperatingSystem_IsThereANewProgram() == -1){		
		OperatingSystem_ReadyToShutdown();
	}else{
		OperatingSystem_PrintStatus();
	}	
	
	if(numProcSacados != 0 || numCreados > 0){
		//mirar si el proceso que se encuentra ejecutndose tiene menos prioridad que el
		//primero de la cola de listos
		int candidato = OperatingSystem_ShortTermScheduler();
		if(processTable[candidato].priority < processTable[executingProcessID].priority){
			int antiguo = executingProcessID;
			OperatingSystem_ShowTime(SHORTTERMSCHEDULE);
			ComputerSystem_DebugMessage(121,SHORTTERMSCHEDULE,antiguo,candidato);
			OperatingSystem_PreemptRunningProcess();
			OperatingSystem_Dispatch(candidato);
			OperatingSystem_PrintStatus();
		}else{
			//lo volvemos a colocar en su pila
			Heap_add(candidato, readyToRunQueue[processTable[candidato].queueID],QUEUE_PRIORITY ,&numberOfReadyToRunProcesses[processTable[candidato].queueID] ,PROCESSTABLEMAXSIZE);
		}
	}
}

void OperatingSystem_SendToBlockedState(int PID){
	char * estadoActual = statesNames[processTable[PID].state];
	int absAcumulator = processTable[PID].copyOfAcumulator;
	if(absAcumulator <0){
		absAcumulator = absAcumulator * -1;
	}
	processTable[PID].whenToWakeUp = numberOfClockInterrupts + absAcumulator  + 1;
	
	if(Heap_add(PID,sleepingProcessesQueue,processTable[PID].whenToWakeUp,&numberOfSleepingProcesses,PROCESSTABLEMAXSIZE)>=0){
		OperatingSystem_ShowTime(SYSPROC);
		ComputerSystem_DebugMessage(110,SYSPROC,executingProcessID,estadoActual,statesNames[3]);
		processTable[PID].state=BLOCKED;
	}
}

void OperatingSystem_BlockTheActualProcess(){
	//salvamos el contexto pra cuando vallamos a despertar al proceso
	OperatingSystem_SaveContext(executingProcessID);
	
	OperatingSystem_SendToBlockedState(executingProcessID);
}	

//V3 ejercicio 1
int OperatingSystem_GetExecutingProcessID(){
	return executingProcessID;
}
