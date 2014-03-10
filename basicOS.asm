;copy from MikeOS [1]
;display "This is my cool new OS!"
;build & run��see build.bat or[1]
;ref 
;[1].http://mikeos.berlios.de/write-your-own-os.html


BITS 16
;tell NASM assembler that we're working in 16-bit mode,not an x86 instruction

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096
;set ss=07c0h+288,sp=4096,stack is used in call/ret
;07c0h is where the first instruction of this code is loaded to.
;this code will be using 512 bytes. 4096 bytes are allocated after this as stack.
;real address will be (07c0h+288)*16
;? 07c0h is not clear 

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax

	mov si, text_string	; Put string position into SI
	call print_string	; Call our string-printing routine

	jmp $			; Jump here - infinite loop!

	text_string db 'This is my cool new OS!', 0

;int 10H
;AH = Function code (0Eh: Teletype output)
;AL = Character, BH = Page Number, BL = Color (only in graphic mode)
;ref wiki ' int 10H '

print_string:			; Routine: output string in SI to screen
	mov ah, 0Eh		; int 10h 'print char' function

.repeat:
	lodsb			; Get character from string ;load string byte
	cmp al, 0
	je .done		; If char is zero, end of string
	int 10h			; Otherwise, print it
	jmp .repeat

.done:
	ret

	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
	dw 0xAA55		; The standard PC boot signature
;boot sector is 512 bytes and end with 0xAA55. 
