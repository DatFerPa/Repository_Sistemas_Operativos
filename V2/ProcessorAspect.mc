# 1 "Processor.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "Processor.c"
# 1 "Processor.h" 1



# 1 "MainMemory.h" 1
# 9 "MainMemory.h"
typedef struct {
    char operationCode;
    int operand1;
    int operand2;
} MEMORYCELL;


void MainMemory_readMemory();
void MainMemory_writeMemory();

int MainMemory_GetMAR();
void MainMemory_SetMAR(int);
void MainMemory_GetMBR(MEMORYCELL *);
void MainMemory_SetMBR(MEMORYCELL *);
# 5 "Processor.h" 2





enum PSW_BITS {POWEROFF_BIT=0, ZERO_BIT=1, NEGATIVE_BIT=2, OVERFLOW_BIT=3, EXECUTION_MODE_BIT=7, INTERRUPT_MASKED_BIT=15};



enum INT_BITS {SYSCALL_BIT=2, EXCEPTION_BIT=6, CLOCKINT_BIT=9};


void Processor_InitializeInterruptVectorTable();
void Processor_InstructionCycleLoop();
void Processor_CopyInSystemStack(int, int);
int Processor_CopyFromSystemStack(int);
unsigned int Processor_PSW_BitState(const unsigned int);
char * Processor_ShowPSW();




int Processor_GetMAR();
void Processor_SetMAR(int);
void Processor_GetMBR(MEMORYCELL *);
void Processor_SetMBR(MEMORYCELL *);





void Processor_SetAccumulator(int);
int Processor_GetAccumulator();



void Processor_SetPC(int);



int Processor_GetRegisterA();



void Processor_SetPSW(unsigned int);

unsigned int Processor_GetPSW();


void Processor_RaiseInterrupt(const unsigned int);

void Processor_ShowTime(char section);
# 2 "Processor.c" 2
# 1 "OperatingSystem.h" 1



# 1 "ComputerSystem.h" 1



# 1 "Simulator.h" 1
# 5 "ComputerSystem.h" 2
# 1 "ComputerSystemBase.h" 1



# 1 "ComputerSystem.h" 1
# 5 "ComputerSystemBase.h" 2


int ComputerSystem_ObtainProgramList(int , char *[]);
void ComputerSystem_DebugMessage(int, char , ...);
# 6 "ComputerSystem.h" 2


void ComputerSystem_PowerOn(int argc, char *argv[]);
void ComputerSystem_PowerOff();
void ComputerSystem_PrintProgramList();
# 34 "ComputerSystem.h"
typedef struct ProgramData {
    char *executableName;
    unsigned int arrivalTime;
    unsigned int type;
} PROGRAMS_DATA;



extern PROGRAMS_DATA *programList[20];
# 5 "OperatingSystem.h" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 374 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 1 3 4
# 385 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 386 "/usr/include/x86_64-linux-gnu/sys/cdefs.h" 2 3 4
# 375 "/usr/include/features.h" 2 3 4
# 398 "/usr/include/features.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 1 3 4
# 10 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/x86_64-linux-gnu/gnu/stubs.h" 2 3 4
# 399 "/usr/include/features.h" 2 3 4
# 28 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stddef.h" 1 3 4
# 212 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 34 "/usr/include/stdio.h" 2 3 4

# 1 "/usr/include/x86_64-linux-gnu/bits/types.h" 1 3 4
# 27 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/wordsize.h" 1 3 4
# 28 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;







typedef long int __quad_t;
typedef unsigned long int __u_quad_t;
# 121 "/usr/include/x86_64-linux-gnu/bits/types.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/typesizes.h" 1 3 4
# 122 "/usr/include/x86_64-linux-gnu/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef __quad_t *__qaddr_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;
# 36 "/usr/include/stdio.h" 2 3 4
# 44 "/usr/include/stdio.h" 3 4
struct _IO_FILE;



typedef struct _IO_FILE FILE;





# 64 "/usr/include/stdio.h" 3 4
typedef struct _IO_FILE __FILE;
# 74 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/libio.h" 1 3 4
# 31 "/usr/include/libio.h" 3 4
# 1 "/usr/include/_G_config.h" 1 3 4
# 15 "/usr/include/_G_config.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stddef.h" 1 3 4
# 16 "/usr/include/_G_config.h" 2 3 4




# 1 "/usr/include/wchar.h" 1 3 4
# 82 "/usr/include/wchar.h" 3 4
typedef struct
{
  int __count;
  union
  {

    unsigned int __wch;



    char __wchb[4];
  } __value;
} __mbstate_t;
# 21 "/usr/include/_G_config.h" 2 3 4
typedef struct
{
  __off_t __pos;
  __mbstate_t __state;
} _G_fpos_t;
typedef struct
{
  __off64_t __pos;
  __mbstate_t __state;
} _G_fpos64_t;
# 32 "/usr/include/libio.h" 2 3 4
# 49 "/usr/include/libio.h" 3 4
# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 50 "/usr/include/libio.h" 2 3 4
# 144 "/usr/include/libio.h" 3 4
struct _IO_jump_t; struct _IO_FILE;
# 154 "/usr/include/libio.h" 3 4
typedef void _IO_lock_t;





struct _IO_marker {
  struct _IO_marker *_next;
  struct _IO_FILE *_sbuf;



  int _pos;
# 177 "/usr/include/libio.h" 3 4
};


enum __codecvt_result
{
  __codecvt_ok,
  __codecvt_partial,
  __codecvt_error,
  __codecvt_noconv
};
# 245 "/usr/include/libio.h" 3 4
struct _IO_FILE {
  int _flags;




  char* _IO_read_ptr;
  char* _IO_read_end;
  char* _IO_read_base;
  char* _IO_write_base;
  char* _IO_write_ptr;
  char* _IO_write_end;
  char* _IO_buf_base;
  char* _IO_buf_end;

  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;



  int _flags2;

  __off_t _old_offset;



  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];



  _IO_lock_t *_lock;
# 293 "/usr/include/libio.h" 3 4
  __off64_t _offset;
# 302 "/usr/include/libio.h" 3 4
  void *__pad1;
  void *__pad2;
  void *__pad3;
  void *__pad4;
  size_t __pad5;

  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];

};


typedef struct _IO_FILE _IO_FILE;


struct _IO_FILE_plus;

extern struct _IO_FILE_plus _IO_2_1_stdin_;
extern struct _IO_FILE_plus _IO_2_1_stdout_;
extern struct _IO_FILE_plus _IO_2_1_stderr_;
# 338 "/usr/include/libio.h" 3 4
typedef __ssize_t __io_read_fn (void *__cookie, char *__buf, size_t __nbytes);







typedef __ssize_t __io_write_fn (void *__cookie, const char *__buf,
     size_t __n);







typedef int __io_seek_fn (void *__cookie, __off64_t *__pos, int __w);


typedef int __io_close_fn (void *__cookie);
# 390 "/usr/include/libio.h" 3 4
extern int __underflow (_IO_FILE *);
extern int __uflow (_IO_FILE *);
extern int __overflow (_IO_FILE *, int);
# 434 "/usr/include/libio.h" 3 4
extern int _IO_getc (_IO_FILE *__fp);
extern int _IO_putc (int __c, _IO_FILE *__fp);
extern int _IO_feof (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ferror (_IO_FILE *__fp) __attribute__ ((__nothrow__ , __leaf__));

extern int _IO_peekc_locked (_IO_FILE *__fp);





extern void _IO_flockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern void _IO_funlockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
extern int _IO_ftrylockfile (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
# 464 "/usr/include/libio.h" 3 4
extern int _IO_vfscanf (_IO_FILE * __restrict, const char * __restrict,
   __gnuc_va_list, int *__restrict);
extern int _IO_vfprintf (_IO_FILE *__restrict, const char *__restrict,
    __gnuc_va_list);
extern __ssize_t _IO_padn (_IO_FILE *, int, __ssize_t);
extern size_t _IO_sgetn (_IO_FILE *, void *, size_t);

extern __off64_t _IO_seekoff (_IO_FILE *, __off64_t, int, int);
extern __off64_t _IO_seekpos (_IO_FILE *, __off64_t, int);

extern void _IO_free_backup_area (_IO_FILE *) __attribute__ ((__nothrow__ , __leaf__));
# 75 "/usr/include/stdio.h" 2 3 4




typedef __gnuc_va_list va_list;
# 90 "/usr/include/stdio.h" 3 4
typedef __off_t off_t;
# 102 "/usr/include/stdio.h" 3 4
typedef __ssize_t ssize_t;







typedef _G_fpos_t fpos_t;




# 164 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/x86_64-linux-gnu/bits/stdio_lim.h" 1 3 4
# 165 "/usr/include/stdio.h" 2 3 4



extern struct _IO_FILE *stdin;
extern struct _IO_FILE *stdout;
extern struct _IO_FILE *stderr;







extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));




extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));








extern FILE *tmpfile (void) ;
# 209 "/usr/include/stdio.h" 3 4
extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;





extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 227 "/usr/include/stdio.h" 3 4
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;








extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);

# 252 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 266 "/usr/include/stdio.h" 3 4






extern FILE *fopen (const char *__restrict __filename,
      const char *__restrict __modes) ;




extern FILE *freopen (const char *__restrict __filename,
        const char *__restrict __modes,
        FILE *__restrict __stream) ;
# 295 "/usr/include/stdio.h" 3 4

# 306 "/usr/include/stdio.h" 3 4
extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;
# 319 "/usr/include/stdio.h" 3 4
extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;






extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));





extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));








extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);




extern int printf (const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));





extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));

# 412 "/usr/include/stdio.h" 3 4
extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));








extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;




extern int scanf (const char *__restrict __format, ...) ;

extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));
# 443 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 463 "/usr/include/stdio.h" 3 4








extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));
# 494 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 522 "/usr/include/stdio.h" 3 4









extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);

# 550 "/usr/include/stdio.h" 3 4
extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 561 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);











extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);

# 594 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);








extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     ;
# 638 "/usr/include/stdio.h" 3 4
extern char *gets (char *__s) __attribute__ ((__deprecated__));


# 665 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
          size_t *__restrict __n, int __delimiter,
          FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
        size_t *__restrict __n, int __delimiter,
        FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
       size_t *__restrict __n,
       FILE *__restrict __stream) ;








extern int fputs (const char *__restrict __s, FILE *__restrict __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);

# 737 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);








extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);

# 773 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off_t __off, int __whence);




extern __off_t ftello (FILE *__stream) ;
# 792 "/usr/include/stdio.h" 3 4






extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos);




extern int fsetpos (FILE *__stream, const fpos_t *__pos);
# 815 "/usr/include/stdio.h" 3 4

# 824 "/usr/include/stdio.h" 3 4


extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;








extern void perror (const char *__s);






# 1 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h" 1 3 4
# 26 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h" 3 4
extern int sys_nerr;
extern const char *const sys_errlist[];
# 854 "/usr/include/stdio.h" 2 3 4




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 873 "/usr/include/stdio.h" 3 4
extern FILE *popen (const char *__command, const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));
# 913 "/usr/include/stdio.h" 3 4
extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 943 "/usr/include/stdio.h" 3 4

# 6 "OperatingSystem.h" 2
# 39 "OperatingSystem.h"
enum ProcessStates { NEW, READY, EXECUTING, BLOCKED, EXIT};


enum SystemCallIdentifiers { SYSCALL_END=3, SYSCALL_YIELD=4, SYSCALL_PRINTEXECPID=5, SYSCALL_SLEEP=7};


typedef struct {
 int busy;
 int initialPhysicalAddress;
 int processSize;
 int state;
 int priority;
 int copyOfPCRegister;
 unsigned int copyOfPSWRegister;
 int copyOfAcumulator;
 int programListIndex;
 int queueID;
 int whenToWakeUp;
} PCB;



extern PCB processTable[4];
extern int OS_address_base;
extern int sipID;


void OperatingSystem_Initialize();
void OperatingSystem_InterruptLogic(int);
void OperatingSystem_PrintReadyToRunQueue();
void OperatingSystem_HandleClockInterrupt();
void OperatingSystem_SendToBlockedState(int);
void OperatingSystem_BlockTheActualProcess();
# 3 "Processor.c" 2
# 1 "Buses.h" 1



enum BusConnection { MAINMEMORY, MMU, CPU, INPUTDEVICE, OUTPUTDEVICE };





int Buses_write_AddressBus_From_To(int, int);
int Buses_write_DataBus_From_To(int, int);
# 4 "Processor.c" 2
# 1 "MMU.h" 1







int MMU_readMemory();
int MMU_writeMemory();

int MMU_GetMAR();
void MMU_SetMAR(int);
void MMU_SetBase(int);
void MMU_SetLimit(int);


int MMU_GetBase();
int MMU_GetLimit();
# 5 "Processor.c" 2
# 1 "Clock.h" 1





void Clock_Update();
int Clock_GetTime();
# 6 "Processor.c" 2

# 1 "/usr/include/string.h" 1 3 4
# 27 "/usr/include/string.h" 3 4





# 1 "/usr/lib/gcc/x86_64-linux-gnu/4.9/include/stddef.h" 1 3 4
# 33 "/usr/include/string.h" 2 3 4
# 44 "/usr/include/string.h" 3 4


extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
       size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void *memmove (void *__dest, const void *__src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));






extern void *memccpy (void *__restrict __dest, const void *__restrict __src,
        int __c, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int memcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 96 "/usr/include/string.h" 3 4
extern void *memchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 127 "/usr/include/string.h" 3 4


extern char *strcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strcat (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncat (char *__restrict __dest, const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern int strncmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcoll (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern size_t strxfrm (char *__restrict __dest,
         const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));






# 1 "/usr/include/xlocale.h" 1 3 4
# 27 "/usr/include/xlocale.h" 3 4
typedef struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
} *__locale_t;


typedef __locale_t locale_t;
# 164 "/usr/include/string.h" 2 3 4


extern int strcoll_l (const char *__s1, const char *__s2, __locale_t __l)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));

extern size_t strxfrm_l (char *__dest, const char *__src, size_t __n,
    __locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));





extern char *strdup (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (const char *__string, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 211 "/usr/include/string.h" 3 4

# 236 "/usr/include/string.h" 3 4
extern char *strchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 263 "/usr/include/string.h" 3 4
extern char *strrchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));


# 282 "/usr/include/string.h" 3 4



extern size_t strcspn (const char *__s, const char *__reject)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 315 "/usr/include/string.h" 3 4
extern char *strpbrk (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 342 "/usr/include/string.h" 3 4
extern char *strstr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strtok (char *__restrict __s, const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern char *__strtok_r (char *__restrict __s,
    const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));

extern char *strtok_r (char *__restrict __s, const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 397 "/usr/include/string.h" 3 4


extern size_t strlen (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strnlen (const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__));

# 427 "/usr/include/string.h" 3 4
extern int strerror_r (int __errnum, char *__buf, size_t __buflen) __asm__ ("" "__xpg_strerror_r") __attribute__ ((__nothrow__ , __leaf__))

                        __attribute__ ((__nonnull__ (2)));
# 445 "/usr/include/string.h" 3 4
extern char *strerror_l (int __errnum, __locale_t __l) __attribute__ ((__nothrow__ , __leaf__));





extern void __bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern void bcopy (const void *__src, void *__dest, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int bcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 489 "/usr/include/string.h" 3 4
extern char *index (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 517 "/usr/include/string.h" 3 4
extern char *rindex (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern int ffs (int __i) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
# 534 "/usr/include/string.h" 3 4
extern int strcasecmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 557 "/usr/include/string.h" 3 4
extern char *strsep (char **__restrict __stringp,
       const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__));


extern char *__stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern char *__stpncpy (char *__restrict __dest,
   const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
# 644 "/usr/include/string.h" 3 4

# 8 "Processor.c" 2





void Processor_FetchInstruction();
void Processor_DecodeAndExecuteInstruction();
void Processor_ManageInterrupts();
void Processor_ACKInterrupt(const unsigned int);
unsigned int Processor_GetInterruptLineStatus(const unsigned int);
void Processor_ActivatePSW_Bit(const unsigned int);
void Processor_DeactivatePSW_Bit(const unsigned int);
void Processor_UpdatePSW();
void Processor_CheckOverflow(int,int);
void Processor_SetAccumulator(int);
int Processor_GetAccumulator();




int registerPC_CPU;
int registerAccumulator_CPU;
MEMORYCELL registerIR_CPU;
unsigned int registerPSW_CPU = 128;
int registerMAR_CPU;
MEMORYCELL registerMBR_CPU;

int registerA_CPU;

int interruptLines_CPU;


int interruptVectorTable[10];


char pswmask []="----------------";


void Processor_InitializeInterruptVectorTable(int interruptVectorInitialAddress) {
 int i;
 for (i=0; i< 10;i++)
  interruptVectorTable[i]=interruptVectorInitialAddress-1;

 interruptVectorTable[SYSCALL_BIT]=interruptVectorInitialAddress;
 interruptVectorTable[EXCEPTION_BIT]=interruptVectorInitialAddress+2;
 interruptVectorTable[CLOCKINT_BIT]=interruptVectorInitialAddress+4;
}





void Processor_InstructionCycleLoop() {

 while (!Processor_PSW_BitState(POWEROFF_BIT)) {
  Processor_FetchInstruction();
  Processor_DecodeAndExecuteInstruction();
  if (interruptLines_CPU && !Processor_PSW_BitState(INTERRUPT_MASKED_BIT))
   Processor_ManageInterrupts();
 }
}


void Processor_FetchInstruction() {


 registerMAR_CPU=registerPC_CPU;

 Buses_write_AddressBus_From_To(CPU, MMU);

 if (MMU_readMemory()==1) {


   memcpy((void *) (&registerIR_CPU), (void *) (&registerMBR_CPU), sizeof(MEMORYCELL));

 Processor_ShowTime('h');



  ComputerSystem_DebugMessage(1, 'h', registerIR_CPU.operationCode, registerIR_CPU.operand1, registerIR_CPU.operand2);
 }
 else

   ComputerSystem_DebugMessage(2,'h');
}



void Processor_DecodeAndExecuteInstruction() {
 int tempAcc;

 Processor_DeactivatePSW_Bit(OVERFLOW_BIT);

 switch (registerIR_CPU.operationCode) {


  case 'a':
   registerAccumulator_CPU= registerIR_CPU.operand1 + registerIR_CPU.operand2;
   Processor_CheckOverflow(registerIR_CPU.operand1,registerIR_CPU.operand2);
   registerPC_CPU++;
   break;


  case 's':
   registerAccumulator_CPU= registerIR_CPU.operand1 - registerIR_CPU.operand2;
   Processor_CheckOverflow(registerIR_CPU.operand1,-registerIR_CPU.operand2);
   registerPC_CPU++;
   break;


  case 'd':
   if (registerIR_CPU.operand2 == 0)
    Processor_RaiseInterrupt(EXCEPTION_BIT);
   else {
    registerAccumulator_CPU=registerIR_CPU.operand1 / registerIR_CPU.operand2;
    registerPC_CPU++;
   }
   break;


  case 't':
   Processor_RaiseInterrupt(SYSCALL_BIT);
   registerA_CPU=registerIR_CPU.operand1;
   registerPC_CPU++;
   break;


  case 'n':
   registerPC_CPU++;
   break;


  case 'j':
   registerPC_CPU+= registerIR_CPU.operand1;
   break;


  case 'z':
   if (Processor_PSW_BitState(ZERO_BIT))
    registerPC_CPU+= registerIR_CPU.operand1;
   else
    registerPC_CPU++;
   break;

  case 'm':

   registerMAR_CPU=registerIR_CPU.operand2;
   Buses_write_AddressBus_From_To(CPU,MMU);

   MMU_readMemory();

   registerAccumulator_CPU = registerMBR_CPU.operand1 + registerIR_CPU.operand1;
   Processor_CheckOverflow(registerMBR_CPU.operand1,registerIR_CPU.operand1);
   registerPC_CPU++;
   break;

  case 'w':
   registerMBR_CPU.operationCode= registerMBR_CPU.operand1= registerMBR_CPU.operand2= registerAccumulator_CPU;
   registerMAR_CPU=registerIR_CPU.operand1;

   Buses_write_DataBus_From_To(CPU, MAINMEMORY);

   Buses_write_AddressBus_From_To(CPU, MMU);

   MMU_writeMemory();
   registerPC_CPU++;
   break;


  case 'r':
   registerMAR_CPU=registerIR_CPU.operand1;

   Buses_write_AddressBus_From_To(CPU, MMU);

   MMU_readMemory();

   registerAccumulator_CPU= registerMBR_CPU.operand1;
   registerPC_CPU++;
   break;


  case 'i':
   tempAcc=registerAccumulator_CPU;
   registerAccumulator_CPU+= registerIR_CPU.operand1;
   Processor_CheckOverflow(tempAcc,registerIR_CPU.operand1);
   registerPC_CPU++;
   break;


  case 'h':

   if(Processor_PSW_BitState(EXECUTION_MODE_BIT)){
    Processor_ActivatePSW_Bit(POWEROFF_BIT);
   }else{

    Processor_RaiseInterrupt(EXCEPTION_BIT);
   }
   break;

  case 'o':
   if(Processor_PSW_BitState(EXECUTION_MODE_BIT)){


    ComputerSystem_DebugMessage(3, 'h',registerPC_CPU,registerAccumulator_CPU,registerPSW_CPU,Processor_ShowPSW());

    OperatingSystem_InterruptLogic(registerIR_CPU.operand1);
    registerPC_CPU++;

    Processor_UpdatePSW();
    return;
   }else{
    Processor_RaiseInterrupt(EXCEPTION_BIT);
   }

  case 'y':
   if(Processor_PSW_BitState(EXECUTION_MODE_BIT)){
    registerPC_CPU=Processor_CopyFromSystemStack(300 -1);
    registerPSW_CPU=Processor_CopyFromSystemStack(300 -2);
   }else{
    Processor_RaiseInterrupt(EXCEPTION_BIT);
   }
   break;


  default :
   registerPC_CPU++;
   break;
 }


 Processor_UpdatePSW();



 ComputerSystem_DebugMessage(3, 'h',registerPC_CPU,registerAccumulator_CPU,registerPSW_CPU,Processor_ShowPSW());



}



void Processor_ManageInterrupts() {

 int i;

  for (i=0;i<10;i++)

   if (Processor_GetInterruptLineStatus(i)) {

    Processor_ACKInterrupt(i);

    Processor_CopyInSystemStack(300 -1, registerPC_CPU);
    Processor_CopyInSystemStack(300 -2, registerPSW_CPU);

    Processor_ActivatePSW_Bit(INTERRUPT_MASKED_BIT);

    Processor_ActivatePSW_Bit(EXECUTION_MODE_BIT);

    registerPC_CPU=interruptVectorTable[i];
    break;
   }
}


void Processor_UpdatePSW(){

 if (registerAccumulator_CPU==0){
  if (!Processor_PSW_BitState(ZERO_BIT))
   Processor_ActivatePSW_Bit(ZERO_BIT);
 }
 else {
  if (Processor_PSW_BitState(ZERO_BIT))
   Processor_DeactivatePSW_Bit(ZERO_BIT);
 }


 if (registerAccumulator_CPU<0) {
  if (!Processor_PSW_BitState(NEGATIVE_BIT))
   Processor_ActivatePSW_Bit(NEGATIVE_BIT);
 }
 else {
  if (Processor_PSW_BitState(NEGATIVE_BIT))
   Processor_DeactivatePSW_Bit(NEGATIVE_BIT);
 }

}


void Processor_CheckOverflow(int op1, int op2) {
   if ((op1>0 && op2>0 && registerAccumulator_CPU<0)
    || (op1<0 && op2<0 && registerAccumulator_CPU>0))
    Processor_ActivatePSW_Bit(OVERFLOW_BIT);
}


void Processor_CopyInSystemStack(int physicalMemoryAddress, int data) {

 registerMBR_CPU.operationCode=registerMBR_CPU.operand1=registerMBR_CPU.operand2=data;
 registerMAR_CPU=physicalMemoryAddress;
 Buses_write_AddressBus_From_To(CPU, MAINMEMORY);
 Buses_write_DataBus_From_To(CPU, MAINMEMORY);
 MainMemory_writeMemory();
}


int Processor_CopyFromSystemStack(int physicalMemoryAddress) {

 registerMAR_CPU=physicalMemoryAddress;
 Buses_write_AddressBus_From_To(CPU, MAINMEMORY);
 MainMemory_readMemory();
 return registerMBR_CPU.operand1;
}



void Processor_RaiseInterrupt(const unsigned int interruptNumber) {
 unsigned int mask = 1;

 mask = mask << interruptNumber;
 interruptLines_CPU = interruptLines_CPU | mask;
}


void Processor_ACKInterrupt(const unsigned int interruptNumber) {
 unsigned int mask = 1;

 mask = mask << interruptNumber;
 mask = ~mask;

 interruptLines_CPU = interruptLines_CPU & mask;
}


unsigned int Processor_GetInterruptLineStatus(const unsigned int interruptNumber) {
 unsigned int mask = 1;

 mask = mask << interruptNumber;
 return (interruptLines_CPU & mask) >> interruptNumber;
}


void Processor_ActivatePSW_Bit(const unsigned int nbit) {
 unsigned int mask = 1;

 mask = mask << nbit;

 registerPSW_CPU = registerPSW_CPU | mask;
}


void Processor_DeactivatePSW_Bit(const unsigned int nbit) {
 unsigned int mask = 1;

 mask = mask << nbit;
 mask = ~mask;

 registerPSW_CPU = registerPSW_CPU & mask;
}


unsigned int Processor_PSW_BitState(const unsigned int nbit) {
 unsigned int mask = 1;

 mask = mask << nbit;
 return (registerPSW_CPU & mask) >> nbit;
}


int Processor_GetMAR() {
  return registerMAR_CPU;
}


void Processor_SetMAR(int data) {
  registerMAR_CPU=data;
}


void Processor_GetMBR(MEMORYCELL *toRegister) {
  memcpy((void*) toRegister, (void *) (&registerMBR_CPU), sizeof(MEMORYCELL));
}


void Processor_SetMBR(MEMORYCELL *fromRegister) {
  memcpy((void*) (&registerMBR_CPU), (void *) fromRegister, sizeof(MEMORYCELL));
}


int Processor_GetMBR_Value(){
  return registerMBR_CPU.operationCode;
}


 void Processor_SetAccumulator(int acc){
   registerAccumulator_CPU=acc;
 }


void Processor_SetPC(int pc){
  registerPC_CPU= pc;
}







 int Processor_GetAccumulator() {
   return registerAccumulator_CPU;
 }





int Processor_GetRegisterA() {
  return registerA_CPU;
}


void Processor_SetPSW(unsigned int psw){
 registerPSW_CPU=psw;
}


unsigned int Processor_GetPSW(){
 return registerPSW_CPU;
}

char * Processor_ShowPSW(){
 strcpy(pswmask,"----------------");
 int tam=strlen(pswmask)-1;
 if (Processor_PSW_BitState(EXECUTION_MODE_BIT))
  pswmask[tam-EXECUTION_MODE_BIT]='X';
 if (Processor_PSW_BitState(OVERFLOW_BIT))
  pswmask[tam-OVERFLOW_BIT]='F';
 if (Processor_PSW_BitState(NEGATIVE_BIT))
  pswmask[tam-NEGATIVE_BIT]='N';
 if (Processor_PSW_BitState(ZERO_BIT))
  pswmask[tam-ZERO_BIT]='Z';
 if (Processor_PSW_BitState(POWEROFF_BIT))
  pswmask[tam-POWEROFF_BIT]='S';
 if (Processor_PSW_BitState(INTERRUPT_MASKED_BIT))
  pswmask[tam-INTERRUPT_MASKED_BIT]='M';
 return pswmask;
}






void Processor_ShowTime(char section){
 ComputerSystem_DebugMessage(Processor_PSW_BitState(EXECUTION_MODE_BIT)?5:4,section,Clock_GetTime());

}
