; multi-segment executable file template.

data segment 
; utilities
    endl db 13, 10, '$'  ; 13 ==> carrige return (cursor at start), 10 ==> new line (move cursor downwards in same column)
; logo
    logoLine1 db '   ____        _     $'
    logoLine2 db '  / __ \____ _(_)____$'  
    logoLine3 db ' / / / / __ `/ / ___/$'
    logoLine4 db '/ /_/ / /_/ / (__  ) $'
    logoLine5 db '\___\_\__,_/_/____/  $'
    logoLine6 db '~~~~~~~~~~~~~~~~~~~~~$'
    
; login information
    user1 db 'Qais$' 
    pass1 db 'CPU/q/$'
    user2 db 'Bassem$'  
    pass2 db 'ALU/b/$'
    user3 db 'Hanna$' 
    pass3 db 'GPU/h/$'
    
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

;<============ Start of Program! ============>
   
    ; [Print Starting Screen]
    lea dx, logoLine1
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h    
    
    lea dx, logoLine2
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
    lea dx, logoLine3
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h 
    
    lea dx, logoLine4
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
    lea dx, logoLine5
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
    lea dx, logoLine6
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
;    lea dx, user1
;    mov ah, 9
;    int 21h             ; output string at ds:dx
;    
;    mov ah, 09          ; store in ah 0x09 to print strings
;    mov dx, offset endl ; offset operator gives begining of the string
;    int 21h         
;     
;    lea dx, user2
;    mov ah, 9
;    int 21h   
;    ; wait for any key....    
;    mov ah, 1
;    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
