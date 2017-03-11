.586
.model flat, c
.code

; Adds two long integers
; 4th arg = operands length (in 4-byte chunks) [EBP + 20]
; 1st arg = first operand address [EBP + 16]
; 2nd arg = second operand address [EBP + 12]
; 3rd arg = result operand address [EBP + 8]
AddLong proc
    push ebp
    mov ebp, esp

    ; Retrieve args
    mov ecx, [ebp + 20] ; amount of iterations
    mov esi, [ebp + 16] ; first operand
    mov ebx, [ebp + 12] ; second operand
    mov edi, [ebp + 8] ; result

    ; Main loop
    clc    
    mov edx, 0
@cycle:
    mov eax, dword ptr[esi + 4 * edx]
    adc eax, dword ptr[ebx + 4 * edx]
    mov dword ptr[edi + 4 * edx], eax

    inc edx
    dec ecx
    jnz @cycle

    pop ebp
    ret 16
AddLong endp


; Subtracts two long integers
; 4th arg = operands length (in 4-byte chunks) [EBP + 20]
; 1st arg = first operand address [EBP + 16]
; 2nd arg = second operand address [EBP + 12]
; 3rd arg = result operand address [EBP + 8]
SubLong proc
    push ebp
    mov ebp, esp

    ; Retrieve args
    mov ecx, [ebp + 20] ; amount of iterations
    mov esi, [ebp + 16] ; first operand
    mov ebx, [ebp + 12] ; second operand
    mov edi, [ebp + 8] ; result

    ; Main loop
    clc    
    mov edx, 0
@cycle2:
    mov eax, dword ptr[esi + 4 * edx]
    sbb eax, dword ptr[ebx + 4 * edx]
    mov dword ptr[edi + 4 * edx], eax

    inc edx
    dec ecx
    jnz @cycle2

    pop ebp
    ret 16
SubLong endp

end