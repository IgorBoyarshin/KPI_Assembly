.586
.model flat, stdcall
option casemap :none
.stack 4096

include D:\dev\LibsAndPrograms\masm32\include\windows.inc
include D:\dev\LibsAndPrograms\masm32\include\user32.inc
include D:\dev\LibsAndPrograms\masm32\include\kernel32.inc
include D:\dev\LibsAndPrograms\masm32\include\gdi32.inc

includelib D:\dev\LibsAndPrograms\masm32\lib\user32.lib
includelib D:\dev\LibsAndPrograms\masm32\lib\kernel32.lib
includelib D:\dev\LibsAndPrograms\masm32\lib\gdi32.lib

.data
  
  MainBoxHeader db "Lab02", 0
  BoxHeader00 db "EAX=0h", 0
  BoxHeader01 db "EAX=1h", 0
  BoxHeader02 db "EAX=2h", 0
  BoxHeader10 db "EAX=80000000h", 0
  BoxHeader11 db "EAX=80000001h", 0
  BoxHeader1234 db "EAX=80000002h - 80000004h", 0  
  BoxHeader15 db "EAX=80000005h", 0
  BoxHeader18 db "EAX=80000008h", 0

  MainText db "This program displays results of calling CPUID with different arguments.", 13, 10,
              "Made by Boyarshin Igor, IO-52 [5207]", 0

  Result00 db "EAX == ********", 13, 10, ; 17 chars
              "EBX+EDX+ECX == ************", 0 ; 15+ chars

  Result01 db "EAX == ********", 13, 10, ; 17 chars
              "EBX == ********", 13, 10, ; 17 chars
              "ECX == ********", 13, 10, ; 17 chars
              "EDX == ********", 13, 10, 0 ; 18 chars

  Result02 db "EAX == ********", 13, 10, ; 17 chars
              "EBX == ********", 13, 10, ; 17 chars
              "ECX == ********", 13, 10, ; 17 chars
              "EDX == ********", 13, 10, 0 ; 18 chars



  Result10 db "EAX == ********", 13, 10, 0 ; 17 chars

  Result11 db "EAX == ********", 13, 10, ; 17 chars
              "EBX == ********", 13, 10, ; 17 chars RESERVED
              "ECX == ********", 13, 10, ; 17 chars
              "EDX == ********", 13, 10, 0 ; 18 chars

  Result1234 db "Result of 80000002h - 80000004h:", 13, 10, ; 32 + 2 chars
                48 dup(0), 13, 10, 0; 16*3 + 2 + 1 chars       

  Result15 db "EAX == ********", 13, 10, ; 17 chars RES
              "EBX == ********", 13, 10, ; 17 chars RES 
              "ECX == ********", 13, 10, ; 17 chars RES 
              "EDX == ********", 13, 10, 0 ; 18 chars RES      

  Result18 db "EAX == ********", 13, 10, 0 ; 17 chars                    

.code
start:

  ; ******** EAX == 0h ********
  mov eax, 0h
  cpuid

  mov dword ptr [Result00 + 17 + 15 + 0], ebx
  mov dword ptr [Result00 + 17 + 15 + 4], edx
  mov dword ptr [Result00 + 17 + 15 + 8], ecx

  push eax
  push offset [Result00 + 7]
  call DwordToStrHex     

  ; ******** EAX == 1h ********

  mov eax, 1h
  cpuid

  push offset [Result01]
  call FillResultText  

  ; ******** EAX == 2h ********

  mov eax, 2h
  cpuid

  push offset [Result02]
  call FillResultText

  ; ******** EAX == 80000000h ********

  mov eax, 80000000h
  cpuid

  push eax
  push offset [Result10 + 7]
  call DwordToStrHex  

  ; ******** EAX == 80000001h ********

  mov eax, 80000001h
  cpuid

  push offset [Result11]
  call FillResultText

  ; ******** EAX == 80000002h ********

  mov eax, 80000002h
  cpuid

  mov dword ptr [Result1234 + 34 + 0 * 16 + 0], eax
  mov dword ptr [Result1234 + 34 + 0 * 16 + 4], ebx
  mov dword ptr [Result1234 + 34 + 0 * 16 + 8], ecx
  mov dword ptr [Result1234 + 34 + 0 * 16 + 12], edx

  ;push offset [Result12]
  ;call FillResultText

  ; ******** EAX == 80000003h ********

  mov eax, 80000003h
  cpuid

  ;push offset [Result13]
  ;call FillResultText

  mov dword ptr [Result1234 + 34 + 1 * 16 + 0], eax
  mov dword ptr [Result1234 + 34 + 1 * 16 + 4], ebx
  mov dword ptr [Result1234 + 34 + 1 * 16 + 8], ecx
  mov dword ptr [Result1234 + 34 + 1 * 16 + 12], edx

  ; ******** EAX == 80000004h ********

  mov eax, 80000004h
  cpuid

  ;push offset [Result14]
  ;call FillResultText

  mov dword ptr [Result1234 + 34 + 2 * 16 + 0], eax
  mov dword ptr [Result1234 + 34 + 2 * 16 + 4], ebx
  mov dword ptr [Result1234 + 34 + 2 * 16 + 8], ecx
  mov dword ptr [Result1234 + 34 + 2 * 16 + 12], edx

  ; ******** EAX == 80000005h ********

  mov eax, 80000005h
  cpuid

  push offset [Result15]
  call FillResultText

  ; ******** EAX == 80000008h ********

  mov eax, 80000008h
  cpuid

  push eax
  push offset [Result18 + 7]
  call DwordToStrHex


  invoke MessageBoxA, 0, addr MainText, addr MainBoxHeader, 0

  invoke MessageBoxA, 0, addr Result00, addr BoxHeader00, 0  
  invoke MessageBoxA, 0, addr Result01, addr BoxHeader01, 0 
  invoke MessageBoxA, 0, addr Result02, addr BoxHeader02, 0 
  
  invoke MessageBoxA, 0, addr Result10, addr BoxHeader10, 0 
  invoke MessageBoxA, 0, addr Result11, addr BoxHeader11, 0 
  invoke MessageBoxA, 0, addr Result1234, addr BoxHeader1234, 0   
  invoke MessageBoxA, 0, addr Result15, addr BoxHeader15, 0 
  invoke MessageBoxA, 0, addr Result18, addr BoxHeader18, 0   

  invoke ExitProcess, 0


  ; PROCEDURE
  DwordToStrHex proc
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    mov edx, [ebp + 12]
    xor eax, eax
    mov edi, 7
  @next:
    mov al, dl
    and al, 0Fh
    add ax, 48
    cmp ax, 58
    jl @store
    add ax, 7
  @store:
    mov [ebx + edi], al
    shr edx, 4
    dec edi
    cmp edi, 0
    jge @next
    pop ebp
    ret 8
  DwordToStrHex endp


  ; PROCEDURE
  FillResultText proc    

    push edx
    push ecx
    push ebx
    push eax

    ; arg === offset for text
    mov ecx, [esp + 4 * 4 + 4] ; skip 4 registers & return address


    add ecx, 7
    
    add ecx, 0    
    ; the EAX register is already in the stack    
    push ecx
    call DwordToStrHex
    
    add ecx, 17    
    ; the EBX register is already in the stack
    push ecx
    call DwordToStrHex
    
    add ecx, 17
    ; the ECX register is already in the stack
    push ecx
    call DwordToStrHex

    add ecx, 17
    ; the EDX register is already in the stack
    push ecx
    call DwordToStrHex
    
    pop ecx ;; return address
    add esp, 4
    push ecx    
    ret

  FillResultText endp

end start


