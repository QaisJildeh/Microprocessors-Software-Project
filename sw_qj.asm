; multi-segment executable file template.

data segment 
; utilities
    endl db 13, 10, '$'  ; 13 ==> carrige return (cursor at start), 10 ==> new line (move cursor downwards in same column) 
    terminate1 db '-----------------------$'
    terminate2 db '  Program Terminated!  $'
    terminate3 db '-----------------------$'  
    
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
;   user1 db 'Qais$' 
;    pass1 db 'CPU/q/$' 
    user1 db '1$' 
    pass1 db '1$'
    user2 db 'Bassem$'  
    pass2 db 'ALU/b/$'
    user3 db 'Hanna$' 
    pass3 db 'GPU/h/$'   
    
    userIn db 7
           db 0
           db 7 dup('$')
    
    passIn db 7
           db 0
           db 7 dup('$')
           
    success db 'Logged in Successfully!$'
    fail db 'Login failed!$'   
           
; Questions
    q1 db 'Q1. Which dinosaur had a long neck?$'
    a1 db ' A) Brachiosaurus$'
    b1 db ' B) Velociraptor$'
    c1 db ' C) T. rex$'
    d1 db ' D) Triceratops$'
    
    q2 db 'Q2. What does Velociraptor mean?$'
    a2 db ' A) Fast thief$'
    b2 db ' B) Big hunter$'
    c2 db ' C) Sharp claw$'
    d2 db ' D) Fast runner$'
    
    q3 db 'Q3. Which dinosaur had the strongest bite?$'
    a3 db ' A) T. rex$'
    b3 db ' B) Spinosaurus$'
    c3 db ' C) Carnotaurus$'
    d3 db ' D) Giganotosaurus$'
    
    q4 db 'Q4. Why did Triceratops have 3 horns?$'
    a4 db ' A) To fight enemies$'
    b4 db ' B) To dig holes$'
    c4 db ' C) To talk to others$'
    d4 db ' D) To climb rocks$'
    
    correctAnswer db 'Correct Answer!$'
    wrongAnswer db 'Wrong Answer!$'     
                                
    answerPrompt db 'Enter Answer: $'
         
    ans1 db 2 dup('$') 
         
    ans2 db 2 dup('$') 
         
    ans3 db 2 dup('$') 
    
    ans4 db 2 dup('$')
    
    currentQuestion db 0

; Grading
    score db 48
    
    statement1 db 'You scored $'
    statement2 db '/4!$'
    
; Shuffling
              
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

    call printLogo
    call userAuthentication
    call quiz 
    call gradeQuiz   
    call terminateProgram
    
         
; --- [Print Starting Screen Logo] ---   
    printLogo proc
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
        
        ret
    printLogo endp 
                           
                           
; --- [User Authentication] ---    
    userAuthentication proc 
        cld
        mov cx, 3
        authentication:
        push cx
        ; print enter username statement
        lea dx, userRequest
        mov ah, 0x09
        int 21h   
        
        ; take 6 characters
        lea dx, userIn
        mov ah, 0x0A
        int 21h 
        
                        ;    ; adding $ to username
                        ;    lea si, userIn
                        ;    add si, 1
                        ;    mov cl, [si]    ; cl = si + 1 ==> the number of characters enetred by the user                                                    
                        ;    xor ch, ch      ; clear ch
                        ;    add si, 1     
                        ;    add si, cx      ; si points at last character after user input
                        ;    mov [si], '$'   ; adding delimiter
        
                        ;    lea dx, endl
                        ;    mov ah, 0x09
                        ;    int 21h
        
                        ;   debugging          
                        ;    lea dx, userIn
                        ;    add dx, 2
                        ;    mov ah, 0x09
                        ;    int 21h 
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        ; print enter password statement       
        lea dx, passRequest
        mov ah, 0x09
        int 21h
        
        ; enter 6 character password
        lea dx, passIn
        mov ah, 0x0A
        int 21h
    
                        ;    ; adding $ to password
                        ;    lea si, passIn
                        ;    add si, 1
                        ;    mov cl, [si]    ; cl = si + 1 ==> the number of characters enetred by the user                                                    
                        ;    xor ch, ch      ; clear ch
                        ;    add si, 1     
                        ;    add si, cx      ; si points at last character after user input
                        ;    mov [si], '$'   ; adding delimiter
        
        lea dx, endl
        mov ah, 0x09
        int 21h 
        
                        ;   debugging          
                        ;    lea dx, passIn
                        ;    add dx, 2
                        ;    mov ah, 0x09
                        ;    int 21h
        
        testUsername1: 
        lea si, user1 
        lea di, userIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je testPassword1
        jmp testUsername2
        
        testPassword1:
        lea si, pass1 
        lea di, passIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je successful
        jmp failed
        
        
        testUsername2:
        lea si, user2 
        lea di, userIn 
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je testPassword2
        jmp testUsername3
        
        testPassword2: 
        lea si, pass2 
        lea di, passIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je successful
        jmp failed
              
                     
        testUsername3:
        lea si, user3 
        lea di, userIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je testPassword3  
        jmp failed
              
        testPassword3:
        lea si, pass3 
        lea di, passIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je successful
        jmp failed
        
                      
        failed:
        lea dx, fail
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h  
        
        lea dx, endl
        mov ah, 0x09
        int 21h
            
        pop cx
        loop authentication 
        
        call terminateProgram  
        
        successful:
        lea dx, success
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        pop cx
        
        ret
    userAuthentication endp
                    

; --- [The Quiz] ---     
    quiz proc
        question1:
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, q1
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
         
        lea dx, a1
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
       
        lea dx, b1
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
       
        lea dx, c1
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
       
        lea dx, d1
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x01   ; save question number
        
        call choose
        
        lea dx, endl
        mov ah, 0x09
        int 21h
                  
                
        question2:
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, q2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, a2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, b2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, c2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, d2
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x02   ; save question number
        
        call choose 
        
        lea dx, endl
        mov ah, 0x09
        int 21h
                  
         
        question3:
        lea dx, endl
        mov ah, 0x09
        int 21h
         
        lea dx, q3
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, a3
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, b3
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, c3
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, d3
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x03   ; save question number
        
        call choose 
        
        lea dx, endl
        mov ah, 0x09
        int 21h
                  
        
        question4:
        lea dx, endl
        mov ah, 0x09
        int 21h
         
        lea dx, q4
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, a4
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, b4
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, c4
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, d4
        mov ah, 0x09
        int 21h
                    
        mov [currentQuestion], 0x04   ; save question number         
        
        call choose 
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
         
        ret 
    quiz endp  
               

; --- [Take Answer] ---              
    choose proc
        incorrectInput:
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, answerPrompt
        mov ah, 0x09
        int 21h
        
        mov ah, 0x01
        int 21h
        
        call isValidAnswer
        loop incorrectInput
        
        ret
    choose endp


; --- [Is Valid Answer] ---
    isValidAnswer proc
        cmp al, 'A'
        je toLower 
        
        cmp al, 'a'
        je save
        
        cmp al, 'B'
        je toLower 
        
        cmp al, 'b'
        je save
        
        cmp al, 'C'
        je toLower 
        
        cmp al, 'c'
        je save
        
        cmp al, 'D'
        je toLower 
        
        cmp al, 'd'
        je save
               
        mov cx, 0x0002
        ret
        
        toLower:
        or al, 0x20
           
        save:
        mov cx, 0x0001
        
        mov bl, currentQuestion
        
        cmp bl, 1
        je saveAnswerQ1
        
        cmp bl, 2
        je saveAnswerQ2
        
        cmp bl, 3
        je saveAnswerQ3
        
        cmp bl, 4
        je saveAnswerQ4 
        
        saveAnswerQ1:
        mov [ans1], al
        jmp updateScore
        
        saveAnswerQ2:
        mov [ans2], al
        jmp updateScore
        
        saveAnswerQ3:
        mov [ans3], al
        jmp updateScore
        
        saveAnswerQ4:
        mov [ans4], al
        jmp updateScore  
        
        updateScore:
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        cmp al, 'a'
        jne incorrectChoiceChosen
        mov dl, [score]
        add dl, 1
        mov [score], dl
        
        lea dx, correctAnswer
        mov ah, 0x09
        int 21h
        
        ret
        
        incorrectChoiceChosen:
        lea dx, wrongAnswer
        mov ah, 0x09
        int 21h
        
        ret   
    isValidAnswer endp
        
        
; --- [Grade Quiz] ---
    gradeQuiz proc  
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, statement1
        mov ah, 0x09
        int 21h
                          
        mov ah, 0x02
        mov dl, [score]
        int 21h                  
                          
        lea dx, statement2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        ret
    gradeQuiz endp  
                    
; --- [Program Terimnation Logo] ---             
    terminateProgram proc
        lea dx, endl
        mov ah, 0x09
        int 21h
         
        lea dx, terminate1
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h    
        
        lea dx, terminate2
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        lea dx, terminate3
        mov ah, 0x09
        int 21h
        
        lea dx, endl
        mov ah, 0x09
        int 21h
        
        mov ax, 4c00h ; exit to operating system.
        int 21h         
        
        ret
    terminateProgram endp  
ends

end start ; set entry point and stop the assembler.
