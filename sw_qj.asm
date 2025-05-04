; multi-segment executable file template.

data segment 
; utilities
    endl db 13, 10, '$'  ; 13 ==> carrige return (cursor at start), 10 ==> new line (move cursor downwards in same column)   
    
; logo
    logoLine1 db ' ______    ________    ________  ______      $'
    logoLine2 db '/_____/\  /_______/\  /_______/\/_____/\     $'  
    logoLine3 db '\:::_ \ \ \::: _  \ \ \__.::._\/\::::_\/_    $'
    logoLine4 db ' \:\ \ \ \_\::(_)  \ \   \::\ \  \:\/___/\   $'
    logoLine5 db '  \:\ \ /_ \\:: __  \ \  _\::\ \__\_::._\:\  $'
    logoLine6 db '   \:\_-  \ \\:.\ \  \ \/__\::\__/\ /____\:\ $'
    logoLine7 db '    \___|\_\_/\__\/\__\/\________\/ \_____\/ $'
    logoLine8 db '*********************************************$'
    
; login information
    userRequest db 'Enter Username: $'
    passRequest db 'Enter Password: $'
    user1 db 'Qais$' 
    pass1 db 'CPU/q/$'
    user2 db 'Bassem$'  
    pass2 db 'ALU/b/$'
    user3 db 'Hanna$' 
    pass3 db 'GPU/h/$'   
    
    userIn db 7
           db 0
           db 7 dup(0)
    
    passIn db 7
           db 0
           db 7 dup(0)    
           
; Questions
    q1 db '1. Which dinosaur had a long neck and was one of the largest animals to ever walk the Earth?$'
    a1 db 'A) Brachiosaurus$'
    b1 db 'B) Velociraptor$'
    c1 db 'C) Tyrannosaurus rex$'
    d1 db 'D) Triceratops$'
    
    q2 db '2. What does the name Velociraptor mean?$'
    a2 db 'A) Fast thief$'
    b2 db 'B) Swift hunter$'
    c2 db 'C) Raptor claw$'
    d2 db 'D) Sharp runner$'
    
    q3 db '3. Which dinosaur is believed to have had the most powerful bite?$'
    a3 db 'A) Tyrannosaurus rex$'
    b3 db 'B) Spinosaurus$'
    c3 db 'C) Carnotaurus$'
    d3 db 'D) Giganotosaurus$'
    
    q4 db '4. What was the primary function of the Triceratops three horns?$'
    a4 db 'A) Defense and combat$'
    b4 db 'B) Digging$'
    c4 db 'C) Communication$'
    d4 db 'D) Climbing obstacles$'
    
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
   
    ; --- [Print Starting Screen] ---
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
    
    lea dx, logoLine7
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
    lea dx, logoLine8
    mov ah, 0x09
    int 21h
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
; --- [User Authentication] ---
    
    ; print enter username statement
    lea dx, userRequest
    mov ah, 0x09
    int 21h   
    
    ; take 6 characters
    lea dx, userIn
    mov ah, 0x0A
    int 21h 
    
    ; adding $ to username
    lea si, userIn
    add si, 1
    mov cl, [si]    ; cl = si + 1 ==> the number of characters enetred by the user                                                    
    xor ch, ch      ; clear ch
    add si, 1     
    add si, cx      ; si points at last character after user input
    mov [si], '$'   ; adding delimiter
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
;   debugging          
;    lea dx, userIn
;    add dx, 2
;    mov ah, 0x09
;    int 21h 
;    
;    lea dx, endl
;    mov ah, 0x09
;    int 21h
    
    ; print enter password statement       
    lea dx, passRequest
    mov ah, 0x09
    int 21h
    
    ; enter 6 character password
    lea dx, passIn
    mov ah, 0x0A
    int 21h

    ; adding $ to password
    lea si, passIn
    add si, 1
    mov cl, [si]    ; cl = si + 1 ==> the number of characters enetred by the user                                                    
    xor ch, ch      ; clear ch
    add si, 1     
    add si, cx      ; si points at last character after user input
    mov [si], '$'   ; adding delimiter
    
    lea dx, endl
    mov ah, 0x09
    int 21h
    
;   debugging          
;    lea dx, passIn
;    add dx, 2
;    mov ah, 0x09
;    int 21h    
       
    exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
