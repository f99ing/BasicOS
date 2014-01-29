BITS 16

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax




	mov si, text_string	; Put string position into SI
	call print_string	; Call our string-printing routine

	jmp $			; Jump here - infinite loop!


	text_string db 'This is my cool new OS!', 0


print_string:			; Routine: output string in SI to screen

mov ax,1010h ; Video BIOS function to change palette color
mov bx,0 ; color number 0 (usually background, black)
mov dh,20 ; red color value (0-63, not 0-255!)
mov ch, 0 ; green color component (0-63)
mov cl,30 ; blue color component (0-63)
int 10h ; Video BIOS interrupt

mov ax,1015h
mov bx,0 ; color number
int 10h

 

	mov ah, 0Eh		; int 10h 'print char' function

	mov bl,01h   ;color blue
	

.repeat:
	lodsb			; Get character from string
	cmp al, 0
	je .done		; If char is zero, end of string
	int 10h			; Otherwise, print it
	jmp .repeat

.done:
	ret


	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
	dw 0xAA55		; The standard PC boot signature