ORG 100H
.stack 100H
.data segment
 mat DB 00H,011H,022H,033H,044H,055H,066H,077H,088H,099H,0aaH,0bbH,0ccH,0ddH,0eeH,0ffH
 key DB 00H,01H,02H,03H,04H,05H,06H,07H,08H,09H,0aH,0bH,0cH,0dH,0eH,0fH 
    Sbox DB 063H,07CH,077H,07BH,0F2H,06BH,06FH,0C5H,030H,01H,067H,02BH,0FEH,0D7H,0ABH,076H
         DB 0CAH,082H,0C9H,07DH,0FAH,059H,047H,0F0H,0ADH,0D4H,0A2H,0AFH,09CH,0A4H,072H,0C0H
         DB 0B7H,0FDH,093H,026H,036H,03FH,0F7H,0CCH,034H,0A5H,0E5H,0F1H,071H,0D8H,031H,015H
         DB 04H,0C7H,023H,0C3H,018H,096H,05H,09AH,07H,012H,080H,0E2H,0EBH,027H,0B2H,075H
         DB 09H,083H,02CH,01AH,01BH,06EH,05AH,0A0H,052H,03BH,0D6H,0B3H,029H,0E3H,02FH,084H
         DB 053H,0D1H,00H,0EDH,020H,0FCH,0B1H,05BH,06AH,0CBH,0BEH,039H,04AH,4CH,058H,0CFH
         DB 0D0H,0EFH,0AAH,0FBH,043H,04DH,033H,085H,045H,0F9H,02H,07FH,050H,03CH,09FH,0A8H
         DB 051H,0A3H,040H,08FH,092H,09DH,038H,0F5H,0BCH,0B6H,0DAH,021H,010H,0FFH,0F3H,0D2H
         DB 0CDH,0CH,013H,0ECH,05FH,097H,044H,017H,0C4H,0A7H,07EH,03DH,064H,05DH,019H,073H
         DB 060H,081H,04FH,0DCH,022H,02AH,090H,088H,046H,0EEH,0B8H,014H,0DEH,05EH,0BH,0DBH
         DB 0E0H,032H,03AH,0AH,049H,06H,024H,05CH,0C2H,0D3H,0ACH,062H,091H,095H,0E4H,079H
         DB 0E7H,0C8H,037H,06DH,08DH,0D5H,04EH,0A9H,06CH,056H,0F4H,0EAH,065H,07AH,0AEH,08H
         DB 0BAH,078H,025H,02EH,01CH,0A6H,0B4H,0C6H,0E8H,0DDH,074H,01FH,04BH,0BDH,08BH,08AH
         DB 070H,03EH,0B5H,066H,048H,03H,0F6H,0EH,061H,035H,057H,0B9H,086H,0C1H,01DH,09EH
         DB 0E1H,0F8H,098H,011H,069H,0D9H,08EH,094H,09BH,01EH,087H,,0E9H,0CEH,055H,028H,0DFH
         DB 08CH,0A1H,089H,0DH,0BFH,0E6H,042H,068H,041H,099H,02DH,0FH,0B0H,054H,0BBH,016H
  col DB 02H,03H,01H,01H,01H,02H,03H,01H,01H,01H,02H,03H,03H,01H,01H,02H
  temp DB 4
 .CODE SEGMENT  
   
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00
L1: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L1 
    
                   
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L2:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L2
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L4: MOV SI,00
L3: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L3
    add di,4
    cmp di,16
    JNZ L4
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L5: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L5       
      
         
         
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L6:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L6
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L8: MOV SI,00
L7: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L7
    add di,4
    cmp di,16
    JNZ L8
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L9: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L9
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L10:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L10
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L12: MOV SI,00
L11: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L11
    add di,4
    cmp di,16
    JNZ L12
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L13: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L13
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L14:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L14
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L16: MOV SI,00
L15: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L15
    add di,4
    cmp di,16
    JNZ L16
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L17: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L17
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L18:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L18
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L20: MOV SI,00
L19: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L19
    add di,4
    cmp di,16
    JNZ L20
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L21: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L21
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L22:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L22
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L24: MOV SI,00
L23: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L23
    add di,4
    cmp di,16
    JNZ L24
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L25: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L25
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L26:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L26
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L28: MOV SI,00
L27: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L27
    add di,4
    cmp di,16
    JNZ L28
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L29: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L29
    
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L30:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L30
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L32: MOV SI,00
L31: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L31
    add di,4
    cmp di,16
    JNZ L32
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L33: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L33
    
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L34:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L34
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
    
    
    MOV di,00
L36: MOV SI,00
L35: MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV al,mat[si]
    MOV ah,col[di]
    mul ah
    MOV bl,al
    MOV al,mat[si+4]
    MOV ah,col[di+1]              ;mixcolumn
    mul ah
    MOV bh,al
    MOV al,mat[si+8]
    MOV ah,col[di+2]
    mul ah
    MOV dl,al
    MOV al,mat[si+12]
    MOV ah,col[di+3]
    mul ah
    MOV dh,al
    add bh,bl
    add dh,dl
    add bh,dh
    MOV mat[si],bh
    inc si
    cmp si,4
    JNZ L35
    add di,4
    cmp di,16
    JNZ L36
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L37: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L37
    
    
     MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,00                   
 L38:MOV bl,mat[si]       ;subbytes
    MOV DI,bx
    MOV bh,Sbox[di]
    MOV mat[si],bh
    inc si
    MOV bx,0000h
    cmp si,16
    jnz L38
    
     
    
    
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h
    MOV si,4  
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3] 
    MOV mat[si],bh
    MOV mat[si+1],al
    MOV mat[si+2],ah
    MOV mat[si+3],bl
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]              ;shiftrows
    MOV ah,mat[si+3]
    MOV mat[si],al
    MOV mat[si+1],ah
    MOV mat[si+2],bl
    MOV mat[si+3],bh
    
    ADD si,4
    MOV bl,mat[si]
    MOV bh,mat[si+1]
    MOV al,mat[si+2]
    MOV ah,mat[si+3]
    MOV mat[si],ah
    MOV mat[si+1],bl
    MOV mat[si+2],bh
    MOV mat[si+3],al
    
    
 
    
    
          
    MOV ax,0000h
    MOV bx,0000h
    MOV dx,0000h      
    MOV si,00
L39: MOV AL,mat[si]
    MOV ah,key[si]    ;addroundkey
    xor AL,AH
    MOV mat[si],AL
    inc si
    cmp si,16
    jnz L39     
    ret