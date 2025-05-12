; Qais Jildeh 20210155

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
    user1 db 'Qais$'   
    pass1 db 'CPU/q/$' 
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
    q1 db 'Q1. Who zooms through the story as the star of Cars?$'
    a1 db ' A) Lightning McQueen$'
    b1 db ' B) Tow Mater$'
    c1 db ' C) Doc Hudson$'
    d1 db ' D) Chick Hicks$'

    q2 db 'Q2. What kind of vehicle is Mater, Lightning’s goofy best bud?$'
    a2 db ' A) A race car$'
    b2 db ' B) A monster truck$'
    c2 db ' C) A tow truck$'
    d2 db ' D) A fire truck$'

    q3 db 'Q3. Where does McQueen end up after falling out of his trailer?$'
    a3 db ' A) Radiator Springs$'
    b3 db ' B) Thunder Hollow$'
    c3 db ' C) Los Angeles$'
    d3 db ' D) Dinoco HQ$'

    q4 db 'Q4. Who is the wise old car that once ruled the racetrack?$'
    a4 db ' A) Ramone$'
    b4 db ' B) The King$'
    c4 db ' C) Cruz Ramirez$'
    d4 db ' D) Doc Hudson$'

    q5 db 'Q5. What number is Lightning McQueen proud to wear?$'
    a5 db ' A) 43$'
    b5 db ' B) 95$'
    c5 db ' C) 86$'
    d5 db ' D) 51$'
    
    correctAnswer db 'Correct Answer!$'
    wrongAnswer db 'Wrong Answer!$'     
                                
    answerPrompt db 'Enter Answer: $'
         
    ans1 db 2 dup('$') 
         
    ans2 db 2 dup('$') 
         
    ans3 db 2 dup('$') 
    
    ans4 db 2 dup('$') 
    
    ans5 db 2 dup('$')
    
    currentQuestion db 0

; Grading
    score db 48
    
    statement1 db 'You scored $'
    statement2 db '/4!$'
    
; Shuffling
    items db 1, 2, 3, 4, 5
    seed db 113 
    
; Scoreboard
    qaisScore db 48
    bassemScore db 48
    hannaScore db 48
                  
    scoreTitle db 'SCOREBOARD$'
    scoreboardLine db '----------$'
    firstName dw ?
    firstScore db ?
    secondName dw ?
    secondScore db ?
    thirdName dw ?
    thirdScore db ?
         
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
    mov cx, 3
    restart:
    cld
    push cx
    call userAuthentication
    call shuffleQuiz
    call quiz 
    call gradeQuiz
    pop cx  
    loop restart
    call printScoreboard  
    call terminateProgram


; --- [Print New Line] ---
    println proc
        lea dx, endl
        mov ah, 0x09
        int 21h 
        
        ret
    println endp    
         
; --- [Print Starting Screen Logo] ---   
    printLogo proc
        lea dx, logoLine1
        mov ah, 0x09
        int 21h
        
        call println   
        
        lea dx, logoLine2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, logoLine3
        mov ah, 0x09
        int 21h
        
        call println 
        
        lea dx, logoLine4
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, logoLine5
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, logoLine6
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, logoLine7
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, logoLine8
        mov ah, 0x09
        int 21h
        
        call println 
        
        ret
    printLogo endp 
                           
                           
; --- [User Authentication] ---    
    userAuthentication proc 
        call println
        
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
        
        call println
        
        ; print enter password statement       
        lea dx, passRequest
        mov ah, 0x09
        int 21h
        
        ; enter 6 character password
        lea dx, passIn
        mov ah, 0x0A
        int 21h
        
        call println 
        
        
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
        
        call println
        
        call println
            
        pop cx
        loop authentication 
        
        call terminateProgram  
        
        successful:
        lea dx, success
        mov ah, 0x09
        int 21h
        
        call println
        
        pop cx
        
        ret
    userAuthentication endp


; --- [Shuffling Algorithm] --- 
    shuffleQuiz proc
        ShuffleLoop:
        ; Generate random index (0-4)
        MOV AL, Seed             ; Current seed value
        MOV AH, 0                ; Clear AH for multiplication
        MOV CL, 4                ; Scaling factor
        MUL CL                   ; AX = AL * 4
        MOV BL, 5                ; Modulo 5
        DIV BL                   ; AX / 5 ? AL=quotient, AH=remainder
        MOV DL, AH               ; Random index (0-4) in DL
        
        ; Swap Items[DL] with another item based on DL
        MOV SI, OFFSET Items     ; Address of Items array
        
        CMP DL, 0
        JE Swap00
        CMP DL, 1
        JE Swap01
        CMP DL, 2
        JE Swap02
        CMP DL, 3
        JE Swap03
        CMP DL, 4
        JE Swap04
        
        Swap00:                  ; Swap Items[0] and Items[1]
        MOV AL, [SI]
        MOV BL, [SI + 1]
        MOV [SI], BL
        MOV [SI + 1], AL
        JMP DoneSwap
        
        Swap01:                  ; Swap Items[1] and Items[2]
        MOV AL, [SI + 1]
        MOV BL, [SI + 2]
        MOV [SI + 1], BL
        MOV [SI + 2], AL
        JMP DoneSwap
        
        Swap02:                  ; Swap Items[2] and Items[3]
        MOV AL, [SI + 2]
        MOV BL, [SI + 3]
        MOV [SI + 2], BL
        MOV [SI + 3], AL
        JMP DoneSwap
        
        Swap03:                  ; Swap Items[3] and Items[4]
        MOV AL, [SI + 3]
        MOV BL, [SI + 4]
        MOV [SI + 3], BL
        MOV [SI + 4], AL
        JMP DoneSwap
        
        Swap04:                  ; Swap Items[0] and Items[4]
        MOV AL, [SI]
        MOV BL, [SI + 4]
        MOV [SI], BL
        MOV [SI + 4], AL
        JMP DoneSwap
        
        DoneSwap:
        ; Update seed for next iteration
        MOV AL, Seed
        MOV BL, 7
        MUL BL                   ; AL = AL * 7
        ADD AL, 3                ; AL = AL + 3
        MOV Seed, AL             ; Store updated seed
        
        ret
    shuffleQuiz endp

                  
; --- [The Quiz] ---     
    quiz proc 
        lea si, [items]
        mov cx, 0x0004
        cld
        nextQuestion:
        mov bx, si
        add bx, cx
        mov bl, [bx] 
        xor bh, bh
        
        push cx
        cmp bl, 1
        je question1
        
        cmp bl, 2
        je question2
        
        cmp bl, 3
        je question3
        
        cmp bl, 4
        je question4 
        
        cmp bl, 5
        je question5 
         
        backToLoop:
        pop cx
        loop nextQuestion
        
        ret
         
        question1:
        call println
        
        lea dx, q1
        mov ah, 0x09
        int 21h
        
        call println
         
        lea dx, a1
        mov ah, 0x09
        int 21h
        
        call println
       
        lea dx, b1
        mov ah, 0x09
        int 21h
        
        call println
       
        lea dx, c1
        mov ah, 0x09
        int 21h
        
        call println
       
        lea dx, d1
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x01   ; save question number
        
        call choose
        
        call println
        
        jmp backToLoop
                  
                
        question2:
        call println
        
        lea dx, q2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, a2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, b2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, c2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, d2
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x02   ; save question number
        
        call choose 
        
        call println
        
        jmp backToLoop
                
         
        question3:
        call println
         
        lea dx, q3
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, a3
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, b3
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, c3
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, d3
        mov ah, 0x09
        int 21h
        
        mov [currentQuestion], 0x03   ; save question number
        
        call choose 
        
        call println
        
        jmp backToLoop
                 
        
        question4:
        call println
         
        lea dx, q4
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, a4
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, b4
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, c4
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, d4
        mov ah, 0x09
        int 21h
                    
        mov [currentQuestion], 0x04   ; save question number         
        
        call choose 
        
        call println
        
        jmp backToLoop
         
        
        question5:
        call println
         
        lea dx, q5
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, a5
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, b5
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, c5
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, d5
        mov ah, 0x09
        int 21h
                    
        mov [currentQuestion], 0x05   ; save question number         
        
        call choose 
        
        call println
        
        jmp backToLoop
           
        ret 
    quiz endp  
               

; --- [Take Answer] ---              
    choose proc
        incorrectInput:
        call println
        
        lea dx, answerPrompt
        mov ah, 0x09
        int 21h
        
        mov ah, 0x01
        int 21h
        
        call isValidAnswer
        cmp cx, 2
        je beepbeep
        jmp endOfLoop
        
        beepbeep:
        mov ah, 02h
        mov dl, 07h   
        int 21h       ; first beep
        
        mov ah, 02h
        mov dl, 07h
        int 21h       ; second beep
        
        endOfLoop:
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
        
        cmp bl, 5
        je saveAnswerQ5 
        
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
        
        saveAnswerQ5:
        mov [ans5], al
        jmp updateScore   
        
        updateScore: 
        xor ah, ah
        push ax
        
        call println
        
        pop ax
                 
        cmp bl, 1
        jne questionScoring2 
        cmp al, 'a'
        je addScore
        jne incorrectChoiceChosen
        
        questionScoring2:
        cmp bl, 2
        jne questionScoring3 
        cmp al, 'c' 
        je addScore
        jne incorrectChoiceChosen
        
        questionScoring3:
        cmp bl, 3
        jne questionScoring4 
        cmp al, 'a' 
        je addScore
        jne incorrectChoiceChosen
        
        questionScoring4:
        cmp bl, 4
        jne questionScoring5 
        cmp al, 'd'
        je addScore 
        jne incorrectChoiceChosen
        
        questionScoring5:
        cmp bl, 5
        jne incorrectChoiceChosen
        cmp al, 'b'
        je addScore 
        jne incorrectChoiceChosen
        
        addScore:
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
        
        mov ah, 02h
        mov dl, 07h   
        int 21h       ; first beep
        
        mov ah, 02h
        mov dl, 07h
        int 21h       ; second beep
        
        ret   
    isValidAnswer endp
        
        
; --- [Grade Quiz] ---
    gradeQuiz proc  
        call println
        
        lea dx, statement1
        mov ah, 0x09
        int 21h
                          
        mov ah, 0x02
        mov dl, [score]
        int 21h                  
                          
        lea dx, statement2
        mov ah, 0x09
        int 21h
        
        call println  
        
        lea si, user1 
        lea di, userIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je updateQaisScore
        jmp checkIfBassem
        
        checkIfBassem:
        lea si, user2 
        lea di, userIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je updateBassemScore
        jmp checkIfHanna
        
        checkIfHanna:
        lea si, user3 
        lea di, userIn
        mov cl, [di + 1]   
        xor ch, ch  
        add di, 2
        rep cmpsb
        je updateHannaScore
        ret
        
        updateQaisScore:
        mov bl, [score] 
        mov [qaisScore], bl
        jmp finishedGrading
        
        updateBassemScore:
        mov bl, [score]
        mov [bassemScore], bl
        jmp finishedGrading
        
        updateHannaScore:
        mov bl, [score]
        mov [hannaScore], bl
        
        finishedGrading:
        mov bl, 48
        mov [score], bl 
        
        ret
    gradeQuiz endp  
    
    
; --- [Scoreboard] ---
    printScoreboard proc
        mov al, [qaisScore]
        cmp al, [bassemScore]
        jae qais_ge_bassem
        jmp bassem_gt_qais
    
        qais_ge_bassem:
        cmp al, [hannaScore]
        jae qais_first
        jmp hanna_first
    
        bassem_gt_qais:
        mov al, [bassemScore]
        cmp al, [hannaScore]
        jae bassem_first
        jmp hanna_first
    
        qais_first:
        lea ax, user1   
        mov [firstName], ax
        mov al, [qaisScore]
        mov [firstScore], al
        
        mov al, [bassemScore]
        cmp al, [hannaScore]
        jae bassem_second_qais_first
        jmp hanna_second_qais_first
    
        bassem_second_qais_first:
        lea ax, user2
        mov [secondName], ax
        mov al, [bassemScore]
        mov [secondScore], al 
        
        lea ax, user3
        mov [thirdName], ax
        mov al, [hannaScore]
        mov [thirdScore], al
        
        jmp print_sorted
    
        hanna_second_qais_first:
        lea ax, user3
        mov [secondName], ax
        mov al, [hannaScore]
        mov [secondScore], al 
        
        lea ax, user2
        mov [thirdName], ax
        mov al, [bassemScore]
        mov [thirdScore], al
        
        jmp print_sorted
    
        bassem_first:
        lea ax, user2
        mov [firstName], ax
        mov al, [bassemScore]
        mov [firstScore], al 
        
        mov al, [qaisScore]
        cmp al, [hannaScore]
        jae qais_second_bassem_first
        jmp hanna_second_bassem_first
    
        qais_second_bassem_first:
        lea ax, user1
        mov [secondName], ax
        mov al, [qaisScore]
        mov [secondScore], al  
        
        lea ax, user3
        mov [thirdName], ax
        mov al, [hannaScore]
        mov [thirdScore], al 
        
        jmp print_sorted
    
        hanna_second_bassem_first:
        lea ax, user3
        mov [secondName], ax
        mov al, [hannaScore]
        mov [secondScore], al 
        
        lea ax, user1
        mov [thirdName], ax
        mov al, [qaisScore]
        mov [thirdScore], al
        
        jmp print_sorted
    
        hanna_first:
        lea ax, user3
        mov [firstName], ax
        mov al, [hannaScore]
        mov [firstScore], al 
        
        mov al, [qaisScore]
        cmp al, [bassemScore]
        jae qais_second_hanna_first
        jmp bassem_second_hanna_first
    
        qais_second_hanna_first:
        lea ax, user1
        mov [secondName], ax
        mov al, [qaisScore]
        mov [secondScore], al  
        
        lea ax, user2
        mov [thirdName], ax
        mov al, [bassemScore]
        mov [thirdScore], al 
        
        jmp print_sorted
    
        bassem_second_hanna_first:
        lea ax, user2
        mov [secondName], ax
        mov al, [bassemScore]
        mov [secondScore], al
        
        lea ax, user1
        mov [thirdName], ax
        mov al, [qaisScore]
        mov [thirdScore], al
        
        jmp print_sorted
    
    print_sorted:
        call println

        lea dx, scoreTitle
        mov ah, 0x09
        int 21h
        
        call println  
        
        lea dx, scoreboardLine
        mov ah, 0x09
        int 21h
        
        call println
        
        ; Print first place
        mov dx, [firstName]
        mov ah, 0x09
        int 21h
        
        mov dl, ':'
        mov ah, 0x02
        int 21h
        
        mov dl, ' '
        mov ah, 0x02
        int 21h
        
        mov dl, [firstScore]
        mov ah, 0x02
        int 21h
        
        call println
    
        ; Print second place
        mov dx, [secondName]
        mov ah, 0x09
        int 21h
        
        mov dl, ':'
        mov ah, 0x02
        int 21h
        
        mov dl, ' '
        mov ah, 0x02
        int 21h
        
        mov dl, [secondScore]
        mov ah, 0x02
        int 21h
        
        call println
    
        ; Print third place
        mov dx, [thirdName]
        mov ah, 0x09
        int 21h
        
        mov dl, ':'
        mov ah, 0x02
        int 21h
        
        mov dl, ' '
        mov ah, 0x02
        int 21h
        
        mov dl, [thirdScore]
        mov ah, 0x02
        int 21h
        
        call println
        
        ret
    printScoreboard endp
                    
; --- [Program Terimnation Logo + Exit] ---             
    terminateProgram proc
        call println
         
        lea dx, terminate1
        mov ah, 0x09
        int 21h
        
        call println   
        
        lea dx, terminate2
        mov ah, 0x09
        int 21h
        
        call println
        
        lea dx, terminate3
        mov ah, 0x09
        int 21h
        
        call println
        
        mov ax, 4c00h ; exit to operating system.
        int 21h         
        
        ret
    terminateProgram endp  
ends

end start ; set entry point and stop the assembler.
