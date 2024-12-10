.model small

.data
newLine equ 10,13
maxInputSize equ 10; = (n+1)
nl db 10,13,'$'
msgInputSize           db newLine,"Enter the array size from 3 to 9 elements : $"
msgInvalidInputSize    db newLine,"Invalid input range, Enter a number from 3 to 9 : $"
msgSize          db newLine," Your array size is: $"
msgInfo          db newLine,"This Program Sorts every input in 'ascii code' order $"
msgInput         db newLine,"   Enter a character: $"
msgNotSorted     db newLine,newLine,"   Normal array is : $"
msgSorted        db newLine,newLine,"   Sorted array is : $"
msgTryAgain      db newLine,newLine,"Program ended press any key to try again and press 'ESC' to exit: $"
arr db maxInputSize DUP('$'),'$' ; Max Elements with (`$`) hotfix
outerLoop dw ? ; elements (n) can be changed
currentOuterIndex db 0
currentInnerIndex db 0
minNumberIndex db ?


.code
start:
main proc far
    call CLEAR_SCREEN
    mov ax,@data
    mov ds,ax
    call EnterArraySize       ; How many inputs
    call ResetArrayToNull     ; Name explains everything  
    lea si,arr
    mov cx,outerLoop
    
 readInput:
    lea dx,msgInput
    mov ah,9    ;Print Message
    int 21h     ;Print Message
    mov ah,1    ;Read Char
    int 21h     ;Read Char
    mov [si],al ; al store input
    inc si
    dec cx
    jnz readInput
    
 printNotSortedArray:
    call NewLine
    lea dx,msgNotSorted
    call printArray
    
    
  lea si,arr
  mov cx,outerLoop      ;                outerLoop -> n
 startOuterLoop:        ;for(int si = 0; outerLoop != 0; moveOuterLoop() ) looks good to me :)
   mov al,currentOuterIndex ;Assume the current position holds the minimum element
   mov minNumberIndex,al    ;Assume the current position holds the minimum element
    
                      ;                                CX = outerLoop
  startInnerLoop:     ;for(int di = currentOuterIndex; CX != 0 ; moveInnerLoop() ) looks good to me :)
    lea di,arr
    mov bh,0
    mov bl,currentOuterIndex
    add di,bx
    mov currentInnerIndex,bl
  
   mov cx,outerLoop ;loop condition
 moveInnerLoop:       
    dec cx
    jz swap  ; swaps(arr[si] < arr[di]) si represent current outerIndex element and di represent CurrentMinNumberIndex from the line 77
    inc currentInnerIndex
    inc di
    call getCurrentMinNumberIndex
    jmp moveInnerLoop
    
 swap:
    lea di,arr
    mov ah,0
    mov al,minNumberIndex ; currentMinNumberIndex
    add di,ax
    mov al,[si]
    mov bl,[di]
    mov [si],bl
    mov [di],al
    
    
 moveOuterLoop:
    mov cx,outerLoop
    dec cx 
    mov outerLoop,cx     ;decrement outerLoop to satisfy both loops condition
    cmp cx,1             ;No Need to check last input, it's guaranteed to be sorted
    je printSortedArray
    inc si
    inc currentOuterIndex
    jmp startOuterLoop
    
    
 printSortedArray:
    lea dx,msgSorted
    call printArray

 RunProgramAgain:
        lea dx,msgTryAgain
        mov ah,9
        int 21h
        mov ah,1
        int 21h
        cmp al,27
        je endProgram ;jne have lower range than jmp
        jmp start
   endProgram:
    mov ah, 4Ch
    mov al,0
    int 21h
main endp


getCurrentMinNumberIndex PROC NEAR

    lea bx,arr                     ; Find Correct minNumberIndex
    add bx,word ptr minNumberIndex ; Find Correct minNumberIndex
    
    mov al,[bx]
    mov bx,0
    mov bl,[di] ; bl second number to check smaller or not
    cmp al,bl ;adds 1 to al
    ja changeSmallestNumberIndex
    ret
    
 changeSmallestNumberIndex:
    mov bl,currentInnerIndex
    mov minNumberIndex,bl
    ret
    
getCurrentMinNumberIndex endp

    EnterArraySize PROC NEAR
        lea dx,msgInfo
        mov ah,9 
        int 21h
        lea dx, msgInputSize
        mov ah, 9
        int 21h 
    readSize:
        mov ah, 1
        int 21h
    
        sub al, '0'
        cmp al, 3
        jl invalidInput
        cmp al, 9
        jg invalidInput
    
    validInput:
        mov ah,0
        mov outerLoop, ax
        mov currentOuterIndex,0
        mov currentInnerIndex,0
        call CLEAR_SCREEN
    printProgramInfo:
        lea dx,msgInfo
        mov ah,9 
        int 21h
        lea dx,msgSize
        mov ah,9
        int 21h
        mov dx,outerLoop
        add dx,30h
        mov ah,2 ; Print Char
        int 21h
        call NewLine
        ret
    
    invalidInput:
        lea dx, msgInvalidInputSize
        mov ah, 9
        int 21h
        jmp readSize 

   EnterArraySize ENDP
 

   ResetArrayToNull PROC NEAR
            mov cx,maxInputSize
            lea si,arr
        resetArr:
            mov al,'$'
            mov [si],al
            inc si
            dec cx
            jnz resetArr
            ret
   ResetArrayToNull ENDP
   
 printArray PROC NEAR
        mov ah,9 ;Print Message
        int 21h
        lea di,arr
        mov dx,[di] ;Print letter
        mov ah,2    ;Print letter
        int 21h     ;Print letter
        inc di
    printArrayLoop:
        mov dx,',' ;Print letter
        mov ah,2    ;Print letter
        int 21h     ;Print letter
        mov dx,[di] ;Print letter
        mov ah,2    ;Print letter
        int 21h     ;Print letter
        inc di
        mov al,'$'
        cmp [di],al
        jne printArrayLoop
        ret
 printArray endp
    
 CLEAR_SCREEN PROC NEAR ; From emu8086 Examples :)
        PUSH    AX      ; store registers...
        PUSH    DS      ;
        PUSH    BX      ;
        PUSH    CX      ;
        PUSH    DI      ;

        MOV     AX, 40h
        MOV     DS, AX  ; for getting screen parameters.
        MOV     AH, 06h ; scroll up function id.
        MOV     AL, 0   ; scroll all lines!
        MOV     BH, 07  ; attribute for new lines.
        MOV     CH, 0   ; upper row.
        MOV     CL, 0   ; upper col.
        MOV     DI, 84h ; rows on screen -1,
        MOV     DH, [DI] ; lower row (byte).
        MOV     DI, 4Ah ; columns on screen,
        MOV     DL, [DI]
        DEC     DL      ; lower col.
        INT     10h

        ; set cursor position to top
        ; of the screen:
        MOV     BH, 0   ; current page.
        MOV     DL, 0   ; col.
        MOV     DH, 0   ; row.
        MOV     AH, 02
        INT     10h

        POP     DI      ; re-store registers...
        POP     CX      ;
        POP     BX      ;
        POP     DS      ;
        POP     AX      ;

        RET
CLEAR_SCREEN ENDP

NewLine PROC NEAR
        lea dx,nl
        mov ah,9 
        int 21h
        ret
NewLine endp

 end start
