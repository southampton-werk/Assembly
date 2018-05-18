// vcvars64
// cl /c prog1.c
// link prog1.obj /defaultlib:kernel32.lib /defaultlib:ntdll.lib

#include <windows.h>

typedef struct _IO_STATUS_BLOCK {
  union {
    NTSTATUS Status;
    PVOID    Pointer;
  } DUMMYUNIONNAME;
  ULONG_PTR Information;
} IO_STATUS_BLOCK, *PIO_STATUS_BLOCK;

int main() {
  HANDLE h;
  IO_STATUS_BLOCK IoStatusBlock;
  const char msg[] = "You've been pwned\r\n";
  const msglen = sizeof(msg) - 1;
  h = GetStdHandle(STD_OUTPUT_HANDLE);
  NtWriteFile(h, NULL, NULL, NULL, &IoStatusBlock, msg, msglen, 0, NULL);
  return 0; 
}