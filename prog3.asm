PUBLIC	main

_TEXT	SEGMENT
IoStatusBlock$ = 96

main	PROC
	mov ecx, -11  ; fffffff5H
	mov rax, gs:[96]
	mov rcx, [rax+32]
	mov rbx, [rcx+40] ; This effectively gets 0x4C (76)
	mov rcx, rbx
	; xor rax, rax  ; No need as rax is overwritten on next line
	mov rax, QWORD PTR[rsp+64]
	mov QWORD PTR [rsp+64], rax
	mov DWORD PTR [rsp+56], eax
	mov DWORD PTR [rsp+48], 19
	lea rax, QWORD PTR pwned
	mov QWORD PTR [rsp+40], rax
	lea rax, QWORD PTR IoStatusBlock$[rsp]
	mov QWORD PTR [rsp+32], rax
	xor r9d, r9d
	xor r8d, r8d
	xor edx, edx
	sub rsp, 8  ; Fix stack alignment
	mov r10, rcx
	mov eax, 8
	syscall
	add rsp, 8  ; Undo fix
	ret 0
main	ENDP

pwned DB 'You''ve been pwned', 0dH, 0aH, 00H

_TEXT	ENDS
END
