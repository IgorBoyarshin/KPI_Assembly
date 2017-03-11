.386
.model flat, stdcall
option casemap :none

;include D:\dev\LibsAndPrograms\masm32\include\windows.inc
include D:\dev\LibsAndPrograms\masm32\include\user32.inc
include D:\dev\LibsAndPrograms\masm32\include\kernel32.inc
;include D:\dev\LibsAndPrograms\masm32\include\gdi32.inc

includelib D:\dev\LibsAndPrograms\masm32\lib\user32.lib
includelib D:\dev\LibsAndPrograms\masm32\lib\kernel32.lib
;includelib D:\dev\LibsAndPrograms\masm32\lib\gdi32.lib

.data
BoxHeader db "Lab 01", 0
Text db "Hey there!", 13, 10, "This program is made by:", 13, 10, "Boyarshin Igor Ivanovich, IO-52", 0

.code
start:

  invoke MessageBoxA, 0, addr Text, addr BoxHeader, 0
  invoke ExitProcess, 0

end start
